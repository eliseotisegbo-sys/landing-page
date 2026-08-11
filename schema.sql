-- ============================================================
-- TextileHub — Schéma Base de Données
-- Programme Atelier Fondateur — Candidatures
-- ============================================================
-- Compatible : MySQL 5.7+ / MariaDB 10.3+
-- Encodage   : UTF-8
-- ============================================================

-- Sécurité : supprimer les tables si elles existent déjà
-- (optionnel — commenter en production pour ne pas perdre de données)
-- DROP TABLE IF EXISTS contacts_whatsapp;
-- DROP TABLE IF EXISTS candidatures_historique;
-- DROP TABLE IF EXISTS candidatures_fondateurs;

-- ── 1. TABLE PRINCIPALE : Candidatures Fondateurs ───────────

CREATE TABLE IF NOT EXISTS candidatures_fondateurs (

    -- Identifiant unique
    id                  INT             NOT NULL AUTO_INCREMENT PRIMARY KEY,

    -- Informations personnelles
    prenom              VARCHAR(100)    NOT NULL,
    nom                 VARCHAR(100)    NOT NULL,
    email               VARCHAR(255)    NOT NULL,
    telephone           VARCHAR(30)     DEFAULT NULL,           -- ex: +229 01 46 34 79 88
    pays                VARCHAR(100)    DEFAULT 'Bénin',
    ville               VARCHAR(100)    DEFAULT NULL,

    -- Informations sur l'atelier
    nom_atelier         VARCHAR(200)    NOT NULL,
    type_activite       VARCHAR(100)    DEFAULT NULL,           -- flocage, broderie, DTF, sérigraphie...
    annee_creation      SMALLINT        DEFAULT NULL,
    nombre_employes     SMALLINT        DEFAULT 1,
    volume_commandes    VARCHAR(50)     DEFAULT NULL,           -- ex: "10-20 commandes/mois"
    canal_commandes     TEXT,                                   -- WhatsApp, réseaux sociaux...
    description_atelier TEXT,

    -- Motivations & Attentes
    probleme_principal  TEXT,                                   -- Réponse libre
    objectif_plateforme TEXT,
    fonctionnalite_cle  VARCHAR(100)    DEFAULT NULL,           -- Boutique / Gestion prod / Personnalisation

    -- Source de trafic
    source              VARCHAR(50)     DEFAULT 'landing_page',
    utm_source          VARCHAR(100)    DEFAULT NULL,
    utm_medium          VARCHAR(100)    DEFAULT NULL,
    utm_campaign        VARCHAR(100)    DEFAULT NULL,
    referrer_url        TEXT,

    -- Gestion & Suivi
    -- Valeurs statut : nouveau | en_examen | qualifie | refuse | onboarde
    statut              VARCHAR(30)     NOT NULL DEFAULT 'nouveau',
    priorite            SMALLINT        DEFAULT 3,              -- 1 (haute) à 5 (basse)
    notes_internes      TEXT,
    traite_par          VARCHAR(100)    DEFAULT NULL,
    date_traitement     DATETIME        DEFAULT NULL,

    -- Consentement
    consentement_rgpd   TINYINT(1)      NOT NULL DEFAULT 0,    -- 0 = non, 1 = oui
    accepte_newsletter  TINYINT(1)      DEFAULT 0,

    -- Métadonnées
    ip_address          VARCHAR(45)     DEFAULT NULL,           -- IPv4 (15 car.) ou IPv6 (45 car.)
    user_agent          TEXT,
    created_at          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Contraintes
    UNIQUE KEY uq_email (email)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── 2. INDEX de performance ─────────────────────────────────

CREATE INDEX idx_candidatures_statut
    ON candidatures_fondateurs (statut);

CREATE INDEX idx_candidatures_pays_ville
    ON candidatures_fondateurs (pays, ville);

CREATE INDEX idx_candidatures_created_at
    ON candidatures_fondateurs (created_at);

-- ── 3. TABLE : Historique des changements de statut ─────────

CREATE TABLE IF NOT EXISTS candidatures_historique (

    id              INT             NOT NULL AUTO_INCREMENT PRIMARY KEY,
    candidature_id  INT             NOT NULL,
    ancien_statut   VARCHAR(30)     DEFAULT NULL,
    nouveau_statut  VARCHAR(30)     NOT NULL,
    note            TEXT,
    modifie_par     VARCHAR(100)    DEFAULT NULL,
    created_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_historique_candidature
        FOREIGN KEY (candidature_id)
        REFERENCES candidatures_fondateurs(id)
        ON DELETE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_historique_candidature
    ON candidatures_historique (candidature_id);

-- ── 4. TABLE : Interactions WhatsApp / Contacts ─────────────

CREATE TABLE IF NOT EXISTS contacts_whatsapp (

    id              INT             NOT NULL AUTO_INCREMENT PRIMARY KEY,
    candidature_id  INT             DEFAULT NULL,
    nom_visiteur    VARCHAR(200)    DEFAULT NULL,
    message_initial TEXT,
    -- Valeurs statut : ouvert | en_cours | clos
    statut          VARCHAR(30)     DEFAULT 'ouvert',
    created_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_contact_candidature
        FOREIGN KEY (candidature_id)
        REFERENCES candidatures_fondateurs(id)
        ON DELETE SET NULL

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── 5. TRIGGERS : updated_at automatique ────────────────────
-- Note : MySQL gère updated_at automatiquement via
-- "ON UPDATE CURRENT_TIMESTAMP" dans la définition de colonne.
-- Les triggers ci-dessous sont donc facultatifs mais présents
-- pour compatibilité avec les outils qui n'utilisent pas cet attribut.

DROP TRIGGER IF EXISTS trg_candidatures_before_update;
DELIMITER $$
CREATE TRIGGER trg_candidatures_before_update
    BEFORE UPDATE ON candidatures_fondateurs
    FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_contacts_before_update;
DELIMITER $$
CREATE TRIGGER trg_contacts_before_update
    BEFORE UPDATE ON contacts_whatsapp
    FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$
DELIMITER ;

-- ── 6. VUE : Dashboard résumé ───────────────────────────────

CREATE OR REPLACE VIEW v_dashboard_candidatures AS
SELECT
    statut,
    COUNT(*)                                                                AS total,
    SUM(CASE WHEN DATE(created_at) = CURDATE() THEN 1 ELSE 0 END)          AS aujourd_hui,
    SUM(CASE WHEN created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY) THEN 1 ELSE 0 END)  AS cette_semaine,
    SUM(CASE WHEN created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY) THEN 1 ELSE 0 END) AS ce_mois
FROM candidatures_fondateurs
GROUP BY statut
ORDER BY
    CASE statut
        WHEN 'nouveau'    THEN 1
        WHEN 'en_examen'  THEN 2
        WHEN 'qualifie'   THEN 3
        WHEN 'onboarde'   THEN 4
        WHEN 'refuse'     THEN 5
        ELSE 6
    END;

-- ── 7. DONNÉES DE TEST ── (décommenter pour tester)

/*
INSERT INTO candidatures_fondateurs (
    prenom, nom, email, telephone, pays, ville,
    nom_atelier, type_activite, annee_creation, nombre_employes,
    volume_commandes, probleme_principal, fonctionnalite_cle,
    consentement_rgpd, source, statut
) VALUES
(
    'Kofi', 'Mensah', 'kofi@atelier-mensah.bj', '+229 97 12 34 56', 'Bénin', 'Cotonou',
    'Atelier Mensah Broderie', 'broderie, flocage', 2019, 3,
    '15-25 commandes/mois',
    'Gestion des commandes dispersées sur WhatsApp, erreurs de personnalisation fréquentes',
    'Boutique en ligne',
    1, 'landing_page', 'nouveau'
),
(
    'Aminata', 'Diallo', 'aminata@dtf-lome.tg', '+228 90 98 76 54', 'Togo', 'Lomé',
    'DTF Express Lomé', 'DTF, impression numérique', 2021, 2,
    '30-50 commandes/mois',
    'Aucun suivi de production, clients me demandent l avancement toutes les heures',
    'Gestion de production',
    1, 'instagram', 'en_examen'
);
*/

-- ============================================================
-- FIN DU SCHÉMA
-- Commande d'exécution MySQL :
--   mysql -u <user> -p <database> < schema.sql
-- ============================================================
