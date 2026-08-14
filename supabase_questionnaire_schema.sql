-- ============================================================
-- TextileHub — Schéma Supabase : Réponses Questionnaire
-- Programme Atelier Fondateur — Formulaire 5 étapes
-- ============================================================
-- 
-- À exécuter dans Supabase SQL Editor APRÈS la migration.
-- La table `candidatures_fondateurs` existante reste intacte.
-- ============================================================

CREATE TABLE IF NOT EXISTS reponses_questionnaire (
    -- Identifiant unique
    id                      SERIAL PRIMARY KEY,

    -- ── Step 1 : Profil ──
    profil                  VARCHAR(50)     NOT NULL,
    -- Valeurs : 'atelier', 'employe', 'client', 'designer', 'entreprise', 'interesse'

    -- ── Step 5 : Contact ──
    nom_prenom              VARCHAR(200)    NOT NULL,
    nom_atelier             VARCHAR(200)    DEFAULT NULL,
    email                   VARCHAR(255)    NOT NULL UNIQUE,
    telephone               VARCHAR(30)     NOT NULL,
    ville                   VARCHAR(100)    NOT NULL,
    pays                    VARCHAR(100)    DEFAULT 'Bénin',
    is_pro                  BOOLEAN         DEFAULT FALSE,

    -- ── Step 2 : Qualification & Activité (pros) ──
    types_activite          TEXT[]          DEFAULT '{}',
    anciennete              VARCHAR(50)     DEFAULT NULL,
    taille_equipe           VARCHAR(50)     DEFAULT NULL,
    volume_commandes        VARCHAR(50)     DEFAULT NULL,
    reception_commandes     TEXT[]          DEFAULT '{}',
    outils_suivi            TEXT[]          DEFAULT '{}',
    problemes_actuels       TEXT[]          DEFAULT '{}',
    frequence_erreurs_com   VARCHAR(50)     DEFAULT NULL,
    supprimer_difficulte    TEXT            DEFAULT NULL,
    moyens_paiement         TEXT[]          DEFAULT '{}',

    -- ── Step 3 : Besoins de l'Atelier (pros) ──
    fonctionnalites_urgentes TEXT[]         DEFAULT '{}',
    attente_textilehub      TEXT            DEFAULT NULL,
    pret_a_tester           VARCHAR(100)    DEFAULT NULL,

    -- ── Step 4 : Parcours Client (clients/designers) ──
    deja_commande           VARCHAR(50)     DEFAULT NULL,
    mode_commande           TEXT[]          DEFAULT '{}',
    frustrations_client     TEXT[]          DEFAULT '{}',
    importance_apercu       VARCHAR(50)     DEFAULT NULL,
    amelioration_souhaitee  TEXT            DEFAULT NULL,

    -- ── Step 5 : Question finale ──
    fonctionnalite_reve     TEXT            NOT NULL,

    -- ── Métadonnées ──
    source                  VARCHAR(50)     DEFAULT 'landing_page',
    ip_address              VARCHAR(45)     DEFAULT NULL,
    user_agent              TEXT,
    statut                  VARCHAR(30)     NOT NULL DEFAULT 'nouveau',
    created_at              TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- ── Index de performance ──
CREATE INDEX IF NOT EXISTS idx_questionnaire_profil
    ON reponses_questionnaire (profil);

CREATE INDEX IF NOT EXISTS idx_questionnaire_statut
    ON reponses_questionnaire (statut);

CREATE INDEX IF NOT EXISTS idx_questionnaire_is_pro
    ON reponses_questionnaire (is_pro);

CREATE INDEX IF NOT EXISTS idx_questionnaire_created_at
    ON reponses_questionnaire (created_at);

CREATE INDEX IF NOT EXISTS idx_questionnaire_pays_ville
    ON reponses_questionnaire (pays, ville);

-- ── Trigger updated_at ──
-- (Réutilise la fonction set_updated_at() existante du schéma précédent)
DROP TRIGGER IF EXISTS trg_questionnaire_before_update ON reponses_questionnaire;
CREATE TRIGGER trg_questionnaire_before_update
    BEFORE UPDATE ON reponses_questionnaire
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

-- ── RLS : Autoriser les insertions anonymes ──
ALTER TABLE reponses_questionnaire ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow anonymous inserts" ON reponses_questionnaire
    FOR INSERT
    WITH CHECK (true);

-- Lecture réservée aux utilisateurs authentifiés (dashboard admin)
CREATE POLICY "Allow authenticated reads" ON reponses_questionnaire
    FOR SELECT
    USING (auth.role() = 'authenticated');

-- ── Vue Dashboard ──
CREATE OR REPLACE VIEW v_dashboard_questionnaire AS
SELECT
    profil,
    is_pro,
    statut,
    COUNT(*) AS total,
    SUM(CASE WHEN DATE(created_at) = CURRENT_DATE THEN 1 ELSE 0 END) AS aujourd_hui,
    SUM(CASE WHEN created_at >= NOW() - INTERVAL '7 days' THEN 1 ELSE 0 END) AS cette_semaine,
    SUM(CASE WHEN created_at >= NOW() - INTERVAL '30 days' THEN 1 ELSE 0 END) AS ce_mois
FROM reponses_questionnaire
GROUP BY profil, is_pro, statut;
