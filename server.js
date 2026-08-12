require('dotenv').config();

const express = require('express');
const { createClient } = require('@supabase/supabase-js');
const cors = require('cors');
const rateLimit = require('express-rate-limit');
const { parsePhoneNumberFromString } = require('libphonenumber-js');
const emailValidator = require('email-validator');

const app = express();
const PORT = process.env.PORT || 3000;

// ===============================
// CORS
// ===============================

const corsOptions = {
    origin: process.env.FRONTEND_URL || '*',
    optionsSuccessStatus: 200
};

app.use(cors(corsOptions));
app.use(express.json());
app.use(express.static(__dirname));

// ===============================
// SUPABASE
// ===============================

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error(
        'Erreur : SUPABASE_URL ou SUPABASE_SERVICE_ROLE_KEY manquant.'
    );
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

console.log('Client Supabase serveur configuré.');
// Routes
// Test route
app.get('/api/health', (req, res) => {
    res.status(200).json({ status: 'ok', message: 'API TextileHub fonctionnelle.' });
});

// Rate limiter pour l'API des candidatures (ex: 5 requêtes max par heure par IP)
const apiLimiter = rateLimit({
    windowMs: 60 * 60 * 1000, // 1 heure
    max: 5,
    message: { success: false, message: 'Trop de requêtes depuis cette adresse IP, veuillez réessayer plus tard.' },
    standardHeaders: true,
    legacyHeaders: false,
});

// Soumission de candidature
app.post('/api/candidatures', apiLimiter, async (req, res) => {
    try {
        const {
            prenom, nom, email, telephone, pays, ville,
            nom_atelier, type_activite, annee_creation, nombre_employes,
            volume_commandes, canal_commandes, description_atelier,
            probleme_principal, objectif_plateforme, fonctionnalite_cle,
            source, utm_source, utm_medium, utm_campaign, referrer_url,
            consentement_rgpd, accepte_newsletter
        } = req.body;

        // Validation de base (tous les champs sont désormais obligatoires)
        if (!prenom || !nom || !email || !telephone || !pays || !ville ||
            !nom_atelier || !type_activite || !volume_commandes || !nombre_employes ||
            !probleme_principal || !fonctionnalite_cle || (consentement_rgpd !== 1 && consentement_rgpd !== true)) {
            return res.status(400).json({ success: false, message: 'Champs obligatoires manquants ou consentement non accordé.' });
        }

        // Validation avancée de l'email
        if (!emailValidator.validate(email)) {
            return res.status(400).json({ success: false, message: 'Veuillez fournir une adresse email valide.' });
        }
        // Vérification des fautes de frappe courantes pour Gmail
        const lowerEmail = email.toLowerCase();
        if (lowerEmail.endsWith('@gmai.com') || lowerEmail.endsWith('@gmail.con') || lowerEmail.endsWith('@gamil.com') || lowerEmail.endsWith('@gmail.fr')) {
            return res.status(400).json({ success: false, message: 'Vérifiez votre adresse email. Voulez-vous dire @gmail.com ?' });
        }

        // Validation avancée du numéro de téléphone
        // libphonenumber-js tente d'analyser le numéro. Si pas de + on assume le code pays sélectionné (BJ pour Bénin, etc.)
        // Une simple association des noms de pays fréquents avec leur code ISO
        const paysIso = pays.toLowerCase().includes('bénin') || pays.toLowerCase().includes('benin') ? 'BJ' :
            pays.toLowerCase().includes('togo') ? 'TG' :
                pays.toLowerCase().includes('côte d') || pays.toLowerCase().includes('cote d') ? 'CI' :
                    pays.toLowerCase().includes('sénégal') || pays.toLowerCase().includes('senegal') ? 'SN' : undefined;

        const phoneNumber = parsePhoneNumberFromString(telephone, paysIso);
        if (!phoneNumber || !phoneNumber.isValid()) {
            return res.status(400).json({ success: false, message: 'Veuillez fournir un numéro de téléphone valide.' });
        }
        const formattedPhone = phoneNumber.number; // Format E.164 (ex: +22997000000)

        // Récupération des métadonnées
        const ip_address = req.headers['x-forwarded-for'] || req.socket.remoteAddress;
        const user_agent = req.headers['user-agent'];

        const { data, error } = await supabase
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
            ])
            .select();

        if (error) {
            throw error;
        }

        res.status(201).json({
            success: true,
            message: 'Candidature enregistrée avec succès.',
            candidatureId: data[0].id
        });

    } catch (error) {
        console.error('Erreur lors de l\'enregistrement de la candidature:', error);

        // Gestion des erreurs de duplicata (email) - PostgreSQL
        if (error.code === '23505') { // PostgreSQL unique violation
            return res.status(409).json({ success: false, message: 'Cette adresse email est déjà utilisée.' });
        }
        res.status(500).json({ success: false, message: 'Erreur interne du serveur.', details: error.message, code: error.code });
    }
});

// Démarrage du serveur (en local) ou Export (pour Vercel)
if (process.env.NODE_ENV !== 'production' && !process.env.VERCEL) {
    app.listen(PORT, () => {
        console.log(`Serveur démarré sur le port ${PORT}`);
        console.log(`Test API: http://localhost:${PORT}/api/health`);
    });
}

module.exports = app;
