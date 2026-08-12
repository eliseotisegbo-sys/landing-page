-- ============================================================
-- TextileHub — Schéma Base de Données Supabase (PostgreSQL)
-- Programme Atelier Fondateur — Candidatures
-- ============================================================

-- ── 1. TABLE PRINCIPALE : Candidatures Fondateurs ───────────

CREATE TABLE IF NOT EXISTS candidatures_fondateurs (
    -- Identifiant unique
    id                  SERIAL PRIMARY KEY,

    -- Informations personnelles
    prenom              VARCHAR(100)    NOT NULL,
    nom                 VARCHAR(100)    NOT NULL,
    email               VARCHAR(255)    NOT NULL UNIQUE,
    telephone           VARCHAR(30)     DEFAULT NULL,
    pays                VARCHAR(100)    DEFAULT 'Bénin',
    ville               VARCHAR(100)    DEFAULT NULL,

    -- Informations sur l'atelier
    nom_atelier         VARCHAR(200)    NOT NULL,
    type_activite       VARCHAR(100)    DEFAULT NULL,
    annee_creation      SMALLINT        DEFAULT NULL,
    nombre_employes     SMALLINT        DEFAULT 1,
    volume_commandes    VARCHAR(50)     DEFAULT NULL,
    canal_commandes     TEXT,
    description_atelier TEXT,

    -- Motivations & Attentes
    probleme_principal  TEXT,
    objectif_plateforme TEXT,
    fonctionnalite_cle  VARCHAR(100)    DEFAULT NULL,

    -- Source de trafic
    source              VARCHAR(50)     DEFAULT 'landing_page',
    utm_source          VARCHAR(100)    DEFAULT NULL,
    utm_medium          VARCHAR(100)    DEFAULT NULL,
    utm_campaign        VARCHAR(100)    DEFAULT NULL,
    referrer_url        TEXT,

    -- Gestion & Suivi
    statut              VARCHAR(30)     NOT NULL DEFAULT 'nouveau',
    priorite            SMALLINT        DEFAULT 3,
    notes_internes      TEXT,
    traite_par          VARCHAR(100)    DEFAULT NULL,
    date_traitement     TIMESTAMP WITH TIME ZONE DEFAULT NULL,

    -- Consentement
    consentement_rgpd   BOOLEAN         NOT NULL DEFAULT FALSE,
    accepte_newsletter  BOOLEAN         DEFAULT FALSE,

    -- Métadonnées
    ip_address          VARCHAR(45)     DEFAULT NULL,
    user_agent          TEXT,
    created_at          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- ── 2. INDEX de performance ─────────────────────────────────

CREATE INDEX IF NOT EXISTS idx_candidatures_statut
    ON candidatures_fondateurs (statut);

CREATE INDEX IF NOT EXISTS idx_candidatures_pays_ville
    ON candidatures_fondateurs (pays, ville);

CREATE INDEX IF NOT EXISTS idx_candidatures_created_at
    ON candidatures_fondateurs (created_at);

-- ── 3. TABLE : Historique des changements de statut ─────────

CREATE TABLE IF NOT EXISTS candidatures_historique (
    id              SERIAL PRIMARY KEY,
    candidature_id  INTEGER         NOT NULL REFERENCES candidatures_fondateurs(id) ON DELETE CASCADE,
    ancien_statut   VARCHAR(30)     DEFAULT NULL,
    nouveau_statut  VARCHAR(30)     NOT NULL,
    note            TEXT,
    modifie_par     VARCHAR(100)    DEFAULT NULL,
    created_at      TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_historique_candidature
    ON candidatures_historique (candidature_id);

-- ── 4. TABLE : Interactions WhatsApp / Contacts ─────────────

CREATE TABLE IF NOT EXISTS contacts_whatsapp (
    id              SERIAL PRIMARY KEY,
    candidature_id  INTEGER         DEFAULT NULL REFERENCES candidatures_fondateurs(id) ON DELETE SET NULL,
    nom_visiteur    VARCHAR(200)    DEFAULT NULL,
    message_initial TEXT,
    statut          VARCHAR(30)     DEFAULT 'ouvert',
    created_at      TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- ── 5. FUNCTION & TRIGGERS : updated_at automatique ─────────

CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_candidatures_before_update ON candidatures_fondateurs;
CREATE TRIGGER trg_candidatures_before_update
    BEFORE UPDATE ON candidatures_fondateurs
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS trg_contacts_before_update ON contacts_whatsapp;
CREATE TRIGGER trg_contacts_before_update
    BEFORE UPDATE ON contacts_whatsapp
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

-- ── 6. VUE : Dashboard résumé ───────────────────────────────

CREATE OR REPLACE VIEW v_dashboard_candidatures AS
SELECT
    statut,
    COUNT(*) AS total,
    SUM(CASE WHEN DATE(created_at) = CURRENT_DATE THEN 1 ELSE 0 END) AS aujourd_hui,
    SUM(CASE WHEN created_at >= NOW() - INTERVAL '7 days' THEN 1 ELSE 0 END) AS cette_semaine,
    SUM(CASE WHEN created_at >= NOW() - INTERVAL '30 days' THEN 1 ELSE 0 END) AS ce_mois
FROM candidatures_fondateurs
GROUP BY statut;
