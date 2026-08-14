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
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_ANON_KEY || process.env.SUPABASE_KEY || process.env.SUPABASE_SERVICE_ROLE_KEY;

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

// Candidatures endpoint
app.post('/api/candidatures', apiLimiter, async (req, res) => {
    if (!supabaseConfigured || !supabase) {
        return res.status(503).json({
            success: false,
            message: 'Service de base de données temporairement indisponible. Veuillez réessayer plus tard.'
        });
    }

    try {
        const {
            prenom, nom, email, telephone, pays, ville,
            nom_atelier, type_activite, annee_creation, nombre_employes,
            volume_commandes, canal_commandes, description_atelier,
            probleme_principal, objectif_plateforme, fonctionnalite_cle,
            source, utm_source, utm_medium, utm_campaign, referrer_url,
            consentement_rgpd, accepte_newsletter
        } = req.body;

        if (!prenom || !nom || !email || !telephone || !pays || !ville ||
            !nom_atelier || !type_activite || !volume_commandes || !nombre_employes ||
            !probleme_principal || !fonctionnalite_cle || (consentement_rgpd !== 1 && consentement_rgpd !== true)) {
            return res.status(400).json({ success: false, message: 'Champs obligatoires manquants ou consentement non accordé.' });
        }

        if (!emailValidator.validate(email)) {
            return res.status(400).json({ success: false, message: 'Veuillez fournir une adresse email valide.' });
        }

        const lowerEmail = email.toLowerCase();
        if (lowerEmail.endsWith('@gmai.com') || lowerEmail.endsWith('@gmail.con') || lowerEmail.endsWith('@gamil.com') || lowerEmail.endsWith('@gmail.fr')) {
            return res.status(400).json({ success: false, message: 'Vérifiez votre adresse email. Voulez-vous dire @gmail.com ?' });
        }

        const paysIso = pays.toLowerCase().includes('bénin') || pays.toLowerCase().includes('benin') ? 'BJ' :
            pays.toLowerCase().includes('togo') ? 'TG' :
                pays.toLowerCase().includes('côte d') || pays.toLowerCase().includes('cote d') ? 'CI' :
                    pays.toLowerCase().includes('sénégal') || pays.toLowerCase().includes('senegal') ? 'SN' : undefined;

        const phoneNumber = parsePhoneNumberFromString(telephone, paysIso);
        if (!phoneNumber || !phoneNumber.isValid()) {
            return res.status(400).json({ success: false, message: 'Veuillez fournir un numéro de téléphone valide.' });
        }
        const formattedPhone = phoneNumber.number;

        const ip_address = req.headers['x-forwarded-for'] || req.socket.remoteAddress;
        const user_agent = req.headers['user-agent'];

        const { error } = await supabase
            .from('candidatures_fondateurs')
            .insert([
                {
                    prenom,
                    nom,
                    email: lowerEmail,
                    telephone: formattedPhone,
                    pays: pays || 'Bénin',
                    ville,
                    nom_atelier,
                    type_activite,
                    annee_creation: annee_creation || null,
                    nombre_employes: nombre_employes || 1,
                    volume_commandes,
                    canal_commandes: canal_commandes || null,
                    description_atelier: description_atelier || null,
                    probleme_principal,
                    objectif_plateforme: objectif_plateforme || null,
                    fonctionnalite_cle,
                    source: source || 'landing_page',
                    utm_source: utm_source || null,
                    utm_medium: utm_medium || null,
                    utm_campaign: utm_campaign || null,
                    referrer_url: referrer_url || null,
                    consentement_rgpd: consentement_rgpd === 1 || consentement_rgpd === true,
                    accepte_newsletter: accepte_newsletter === 1 || accepte_newsletter === true,
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
            message: 'Candidature enregistrée avec succès.'
        });

    } catch (error) {
        console.error('Erreur lors de l\'enregistrement de la candidature:', error);

        if (error.code === '23505') {
            return res.status(409).json({ success: false, message: 'Cette adresse email est déjà utilisée.' });
        }

        if (error.code === '42501') {
            console.error('Erreur RLS Supabase - Vérifier la clé API ou les permissions RLS');
            return res.status(500).json({ success: false, message: 'Erreur de configuration de la base de données.' });
        }

        if (error.message && error.message.includes('fetch failed')) {
            console.error('Erreur de connexion à Supabase');
            return res.status(503).json({ success: false, message: 'Service de base de données temporairement indisponible.' });
        }

        return res.status(500).json({ success: false, message: 'Erreur interne du serveur.' });
    }
});

module.exports = app;
