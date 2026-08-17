require('dotenv').config();
const express = require('express');
const { createClient } = require('@supabase/supabase-js');
const cors = require('cors');
const rateLimit = require('express-rate-limit');
const { parsePhoneNumberFromString } = require('libphonenumber-js');
const emailValidator = require('email-validator');

const app = express();

// CORS
const corsOptions = {
    origin: process.env.FRONTEND_URL || '*',
    optionsSuccessStatus: 200
};

app.use(cors(corsOptions));
app.use(express.json());

// SUPABASE
const supabaseUrl = (process.env.SUPABASE_URL || '').trim();
let rawKey = process.env.SUPABASE_ANON_KEY || process.env.SUPABASE_KEY || process.env.SUPABASE_SERVICE_ROLE_KEY || '';
const supabaseKey = rawKey.replace(/\s+/g, ''); // Remove ALL whitespaces including newlines

let supabase = null;
let supabaseConfigured = false;

if (supabaseUrl && supabaseKey) {
    try {
        supabase = createClient(supabaseUrl, supabaseKey);
        supabaseConfigured = true;
        console.log('Client Supabase serveur configuré.');
    } catch (error) {
        console.error('Erreur lors de la configuration du client Supabase:', error);
    }
} else {
    console.warn('AVERTISSEMENT: Clés Supabase manquantes. L\'API fonctionnera en mode dégradé.');
}

// Health check
app.get('/api/health', (req, res) => {
    res.status(200).json({ status: 'ok', message: 'API TextileHub fonctionnelle.' });
});

// Rate limiter
const apiLimiter = rateLimit({
    windowMs: 60 * 60 * 1000,
    max: 5,
    message: { success: false, message: 'Trop de requêtes depuis cette adresse IP, veuillez réessayer plus tard.' },
    standardHeaders: true,
    legacyHeaders: false,
});

// Candidatures endpoint — Programme Atelier Fondateur (Questionnaire 5 étapes)
app.post('/api/candidatures', apiLimiter, async (req, res) => {
    if (!supabaseConfigured || !supabase) {
        return res.status(503).json({
            success: false,
            message: 'Service de base de données temporairement indisponible. Veuillez réessayer plus tard.'
        });
    }

    try {
        const data = req.body;

        // ── Validation des champs obligatoires (Step 1 + Step 5) ──
        if (!data.profil) {
            return res.status(400).json({ success: false, message: 'Le champ profil est obligatoire.' });
        }
        if (!data.nom_prenom || !data.email || !data.telephone || !data.ville || !data.pays || !data.fonctionnalite_reve) {
            return res.status(400).json({ success: false, message: 'Veuillez remplir tous les champs de contact obligatoires.' });
        }

        // ── Validation email ──
        if (!emailValidator.validate(data.email)) {
            return res.status(400).json({ success: false, message: 'Veuillez fournir une adresse email valide.' });
        }

        const lowerEmail = data.email.toLowerCase().trim();
        const emailTypos = ['@gmai.com', '@gmail.con', '@gamil.com', '@gmail.fr'];
        if (emailTypos.some(typo => lowerEmail.endsWith(typo))) {
            return res.status(400).json({ success: false, message: 'Vérifiez votre adresse email. Voulez-vous dire @gmail.com ?' });
        }

        // ── Validation téléphone ──
        const paysStr = (data.pays || '').toLowerCase();
        const paysIso = paysStr.includes('bénin') || paysStr.includes('benin') ? 'BJ' :
            paysStr.includes('togo') ? 'TG' :
                paysStr.includes('côte d') || paysStr.includes('cote d') ? 'CI' :
                    paysStr.includes('sénégal') || paysStr.includes('senegal') ? 'SN' : undefined;

        const phoneNumber = parsePhoneNumberFromString(data.telephone, paysIso);
        if (!phoneNumber || !phoneNumber.isValid()) {
            return res.status(400).json({ success: false, message: 'Veuillez fournir un numéro de téléphone valide.' });
        }

        const ip_address = req.headers['x-forwarded-for'] || req.socket.remoteAddress;
        const user_agent = req.headers['user-agent'];

        // ── Déterminer le type de profil ──
        const isPro = ['atelier', 'employe'].includes(data.profil);

        // ── Insertion dans Supabase ──
        const { error } = await supabase
            .from('reponses_questionnaire')
            .insert([
                {
                    // Identité & Contact
                    profil: data.profil,
                    nom_prenom: data.nom_prenom.trim(),
                    nom_atelier: data.nom_atelier ? data.nom_atelier.trim() : null,
                    email: lowerEmail,
                    telephone: phoneNumber.number,
                    ville: data.ville.trim(),
                    pays: data.pays.trim() || 'Bénin',
                    is_pro: isPro,

                    // Step 2 — Qualification & Activité (pros uniquement)
                    types_activite: data.types_activite || [],
                    anciennete: data.anciennete || null,
                    taille_equipe: data.taille_equipe || null,
                    volume_commandes: data.volume_commandes || null,
                    reception_commandes: data.reception_commandes || [],
                    outils_suivi: data.outils_suivi || [],
                    problemes_actuels: data.problemes_actuels || [],
                    frequence_erreurs_com: data.frequence_erreurs_com || null,
                    supprimer_difficulte: data.supprimer_difficulte || null,
                    moyens_paiement: data.moyens_paiement || [],

                    // Step 3 — Besoins de l'Atelier (pros uniquement)
                    fonctionnalites_urgentes: data.fonctionnalites_urgentes || [],
                    attente_textilehub: data.attente_textilehub || null,
                    pret_a_tester: data.pret_a_tester || null,

                    // Step 4 — Parcours Client (clients/designers)
                    deja_commande: data.deja_commande || null,
                    mode_commande: data.mode_commande || [],
                    frustrations_client: data.frustrations_client || [],
                    importance_apercu: data.importance_apercu || null,
                    amelioration_souhaitee: data.amelioration_souhaitee || null,

                    // Step 5 — Question finale
                    fonctionnalite_reve: data.fonctionnalite_reve,

                    // Métadonnées
                    source: 'landing_page',
                    ip_address: ip_address || null,
                    user_agent: user_agent || null,
                    statut: 'nouveau'
                }
            ]);

        if (error) {
            throw error;
        }

        res.status(201).json({
            success: true,
            message: 'Merci ! Vos réponses ont été enregistrées avec succès.'
        });

    } catch (error) {
        console.error('Erreur lors de l\'enregistrement:', error);

        if (error.code === '23505') {
            return res.status(409).json({ success: false, message: 'Cette adresse email a déjà été utilisée pour répondre au questionnaire.' });
        }

        if (error.code === '42501') {
            console.error('Erreur RLS Supabase — Vérifier la clé API ou les permissions RLS');
            return res.status(500).json({ success: false, message: 'Erreur de configuration de la base de données.' });
        }

        if (error.message && error.message.includes('fetch failed')) {
            console.error('Erreur de connexion à Supabase');
            return res.status(503).json({ success: false, message: 'Service de base de données temporairement indisponible.' });
        }

        return res.status(500).json({
            success: false,
            message: 'Erreur interne du serveur: ' + (error.message || 'Erreur inconnue'),
            details: error.details || error.hint || error.toString()
        });
    }
});

module.exports = app;
