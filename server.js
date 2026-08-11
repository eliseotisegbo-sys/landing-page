require('dotenv').config();
const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static(__dirname)); // Serve static files (HTML, CSS, JS)

// Configuration de la connexion à la base de données
const dbConfig = {
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'textilehub',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
};

let pool;
try {
    pool = mysql.createPool(dbConfig);
    console.log('Connexion au pool MySQL configurée.');
} catch (error) {
    console.error('Erreur lors de la création du pool MySQL:', error);
}

// Routes
// Test route
app.get('/api/health', (req, res) => {
    res.status(200).json({ status: 'ok', message: 'API TextileHub fonctionnelle.' });
});

// Soumission de candidature
app.post('/api/candidatures', async (req, res) => {
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
            !probleme_principal || !fonctionnalite_cle || consentement_rgpd !== 1) {
            return res.status(400).json({ success: false, message: 'Champs obligatoires manquants ou consentement non accordé.' });
        }

        // Récupération des métadonnées
        const ip_address = req.headers['x-forwarded-for'] || req.socket.remoteAddress;
        const user_agent = req.headers['user-agent'];

        const query = `
            INSERT INTO candidatures_fondateurs (
                prenom, nom, email, telephone, pays, ville,
                nom_atelier, type_activite, annee_creation, nombre_employes,
                volume_commandes, canal_commandes, description_atelier,
                probleme_principal, objectif_plateforme, fonctionnalite_cle,
                source, utm_source, utm_medium, utm_campaign, referrer_url,
                consentement_rgpd, accepte_newsletter, ip_address, user_agent,
                statut
            ) VALUES (
                ?, ?, ?, ?, ?, ?,
                ?, ?, ?, ?,
                ?, ?, ?,
                ?, ?, ?,
                ?, ?, ?, ?, ?,
                ?, ?, ?, ?,
                'nouveau'
            )
        `;

        const values = [
            prenom, nom, email, telephone, pays || 'Bénin', ville,
            nom_atelier, type_activite, annee_creation || null, nombre_employes || 1,
            volume_commandes, canal_commandes, description_atelier,
            probleme_principal, objectif_plateforme, fonctionnalite_cle,
            source || 'landing_page', utm_source, utm_medium, utm_campaign, referrer_url,
            consentement_rgpd, accepte_newsletter || 0, ip_address, user_agent
        ].map(v => v === undefined ? null : v);

        const [result] = await pool.execute(query, values);

        res.status(201).json({
            success: true,
            message: 'Candidature enregistrée avec succès.',
            candidatureId: result.insertId
        });

    } catch (error) {
        console.error('Erreur lors de l\'enregistrement de la candidature:', error);

        // Gestion des erreurs de duplicata (email)
        if (error.code === 'ER_DUP_ENTRY') {
            return res.status(409).json({ success: false, message: 'Une candidature existe déjà avec cette adresse email.' });
        }

        res.status(500).json({ success: false, message: 'Erreur interne du serveur.' });
    }
});

// Démarrage du serveur
app.listen(PORT, () => {
    console.log(`Serveur démarré sur le port ${PORT}`);
    console.log(`Test API: http://localhost:${PORT}/api/health`);
});
