-- ============================================================
-- TextileHub — Schéma Base de Données (Supabase / PostgreSQL)
-- Programme Atelier Fondateur — Candidatures
-- ============================================================
-- À exécuter dans : Supabase Dashboard → SQL Editor
-- NB : ce projet Supabase expose le schéma "api" (et non "public").
-- ============================================================

-- ── 0. SCHÉMA ──────────────────────────────────────────────

CREATE SCHEMA IF NOT EXISTS api;
GRANT USAGE ON SCHEMA api TO anon, authenticated, service_role;

-- ── 1. TABLE PRINCIPALE : Candidatures Fondateurs ───────────

CREATE TABLE IF NOT EXISTS api.candidatures_fondateurs (

    -- Identifiant unique
    id                  BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    -- Informations personnelles
    prenom              VARCHAR(100)    NOT NULL,
    nom                 VARCHAR(100)    NOT NULL,
    email               VARCHAR(255)    NOT NULL,
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
    -- Valeurs statut : nouveau | en_examen | qualifie | refuse | onboarde
    statut              VARCHAR(30)     NOT NULL DEFAULT 'nouveau',
    priorite            SMALLINT        DEFAULT 3,
    notes_internes      TEXT,
    traite_par          VARCHAR(100)    DEFAULT NULL,
    date_traitement     TIMESTAMPTZ     DEFAULT NULL,

    -- Consentement
    consentement_rgpd   SMALLINT        NOT NULL DEFAULT 0,
    accepte_newsletter  SMALLINT        DEFAULT 0,

    -- Métadonnées
    user_agent          TEXT,
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT now(),
    updated_at          TIMESTAMPTZ     NOT NULL DEFAULT now(),

    -- Contraintes
    CONSTRAINT uq_email UNIQUE (email)
);

-- ── 2. INDEX de performance ─────────────────────────────────

CREATE INDEX IF NOT EXISTS idx_candidatures_statut
    ON api.candidatures_fondateurs (statut);

CREATE INDEX IF NOT EXISTS idx_candidatures_pays_ville
    ON api.candidatures_fondateurs (pays, ville);

CREATE INDEX IF NOT EXISTS idx_candidatures_created_at
    ON api.candidatures_fondateurs (created_at);

-- ── 3. TABLE : Historique des changements de statut ─────────

CREATE TABLE IF NOT EXISTS api.candidatures_historique (

    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    candidature_id  BIGINT          NOT NULL,
    ancien_statut   VARCHAR(30)     DEFAULT NULL,
    nouveau_statut  VARCHAR(30)     NOT NULL,
    note            TEXT,
    modifie_par     VARCHAR(100)    DEFAULT NULL,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT now(),

    CONSTRAINT fk_historique_candidature
        FOREIGN KEY (candidature_id)
        REFERENCES api.candidatures_fondateurs(id)
        ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_historique_candidature
    ON api.candidatures_historique (candidature_id);

-- ── 4. TABLE : Interactions WhatsApp / Contacts ─────────────

CREATE TABLE IF NOT EXISTS api.contacts_whatsapp (

    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    candidature_id  BIGINT          DEFAULT NULL,
    nom_visiteur    VARCHAR(200)    DEFAULT NULL,
    message_initial TEXT,
    -- Valeurs statut : ouvert | en_cours | clos
    statut          VARCHAR(30)     DEFAULT 'ouvert',
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT now(),

    CONSTRAINT fk_contact_candidature
        FOREIGN KEY (candidature_id)
        REFERENCES api.candidatures_fondateurs(id)
        ON DELETE SET NULL
);

-- ── 5. TRIGGERS : updated_at automatique ────────────────────

CREATE OR REPLACE FUNCTION api.set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_candidatures_before_update ON api.candidatures_fondateurs;
CREATE TRIGGER trg_candidatures_before_update
    BEFORE UPDATE ON api.candidatures_fondateurs
    FOR EACH ROW
    EXECUTE FUNCTION api.set_updated_at();

DROP TRIGGER IF EXISTS trg_contacts_before_update ON api.contacts_whatsapp;
CREATE TRIGGER trg_contacts_before_update
    BEFORE UPDATE ON api.contacts_whatsapp
    FOR EACH ROW
    EXECUTE FUNCTION api.set_updated_at();

-- ── 6. VUE : Dashboard résumé ───────────────────────────────

CREATE OR REPLACE VIEW api.v_dashboard_candidatures AS
SELECT
    statut,
    COUNT(*)                                                                    AS total,
    SUM(CASE WHEN created_at::date = CURRENT_DATE THEN 1 ELSE 0 END)            AS aujourd_hui,
    SUM(CASE WHEN created_at >= now() - INTERVAL '7 days' THEN 1 ELSE 0 END)    AS cette_semaine,
    SUM(CASE WHEN created_at >= now() - INTERVAL '30 days' THEN 1 ELSE 0 END)   AS ce_mois
FROM api.candidatures_fondateurs
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

-- ── 7. SÉCURITÉ : Row Level Security (RLS) ──────────────────
-- Le formulaire public (clé anon/publishable) peut uniquement
-- INSÉRER des candidatures. La lecture/modification est réservée
-- au dashboard Supabase et aux clés service_role.

ALTER TABLE api.candidatures_fondateurs ENABLE ROW LEVEL SECURITY;
ALTER TABLE api.candidatures_historique ENABLE ROW LEVEL SECURITY;
ALTER TABLE api.contacts_whatsapp       ENABLE ROW LEVEL SECURITY;

-- Droits d'accès : le rôle public (anon) ne peut qu'insérer des candidatures
GRANT INSERT ON api.candidatures_fondateurs TO anon;
GRANT ALL ON api.candidatures_fondateurs, api.candidatures_historique, api.contacts_whatsapp TO service_role;
GRANT SELECT ON api.v_dashboard_candidatures TO service_role;

DROP POLICY IF EXISTS "Insertion publique des candidatures" ON api.candidatures_fondateurs;
CREATE POLICY "Insertion publique des candidatures"
    ON api.candidatures_fondateurs
    FOR INSERT
    TO anon
    WITH CHECK (true);

-- ============================================================
-- FIN DU SCHÉMA
-- ============================================================
