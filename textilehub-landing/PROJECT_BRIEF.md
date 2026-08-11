# 📋 BRIEF PROJET — LANDING PAGE TEXTILEHUB

**Date de création :** Août 2026  
**Phase :** Validation commerciale Phase 1  
**Objectif :** Programme Atelier Fondateur — 10 places  

---

## 🎯 OBJECTIF STRATÉGIQUE

Valider commercialement l'hypothèse que les ateliers de personnalisation textile en Afrique francophone sont prêts à adopter (et payer) une plateforme SaaS centralisée pour gérer leur activité.

---

## 📊 DÉFINITION DU SUCCÈS

### Objectif quantitatif
**10 candidatures qualifiées** dans les 2 premières semaines

### Critères de qualification
1. Atelier textile actif (flocage, DTF, broderie, sérigraphie, sublimation)
2. Volume minimum : 10 commandes/mois
3. Confronté au problème de désorganisation (WhatsApp, appels, notes...)
4. Comprend la proposition de valeur TextileHub
5. Intention d'utilisation exprimée (réponse au formulaire)
6. Disposition à payer testée (question dans le formulaire)

### Objectif qualitatif
- Comprendre les **besoins réels** des ateliers
- Identifier les **fonctionnalités prioritaires**
- Valider ou invalider nos hypothèses sur le problème
- Établir un **pricing acceptable** pour le marché
- Créer une **communauté fondatrice** engagée

---

## 🎨 IDENTITÉ DE MARQUE

### Positionnement
"La plateforme SaaS qui transforme un atelier textile gérant ses commandes via WhatsApp en une activité numérique structurée avec boutique professionnelle."

### Promesse principale
"Transformez votre atelier textile en boutique professionnelle en ligne"

### Valeurs
- **Simplicité** — Aussi facile que WhatsApp
- **Proximité** — Construit avec et pour les ateliers africains
- **Professionnalisme** — Outils dignes des grands ateliers
- **Honnêteté** — Transparence totale sur l'avancement du projet

### Ton de voix
- Professionnel mais accessible
- Empathique et concret
- Pas de jargon SaaS
- Langage du terrain (flocage, DTF, WhatsApp...)

---

## 👥 CIBLE PRINCIPALE

### Profil démographique
- **Géographie :** Bénin (Cotonou priorité), puis Afrique francophone
- **Taille :** Ateliers micro (2-5 personnes) et solo
- **Techniques :** Flocage, DTF, Broderie, Sérigraphie, Sublimation
- **Volume :** 10-100+ commandes/mois
- **Outils actuels :** WhatsApp, appels, cahier, Excel

### Profil psychographique
- Entrepreneur textile ambitieux
- Veut professionnaliser son activité
- Frustré par la désorganisation actuelle
- Perd du temps à gérer manuellement
- Veut se démarquer de la concurrence
- Prêt à investir dans des outils

### Pain points (problèmes)
1. Commandes dispersées (WhatsApp, appels, messages)
2. Informations difficiles à retrouver
3. Erreurs de personnalisation fréquentes
4. Clients qui relancent sans cesse
5. Pas de catalogue professionnel à partager
6. Aucune vision claire de l'activité (CA, commandes en cours...)

### Gains recherchés
1. Centralisation des commandes
2. Présence professionnelle en ligne (boutique)
3. Gain de temps au quotidien
4. Moins d'erreurs, plus de clarté
5. Clients autonomes (moins de relances)
6. Visibilité sur l'activité

---

## 🏗️ ARCHITECTURE DE LA LANDING PAGE

### Parcours utilisateur

```
DÉCOUVERTE (Facebook Ads, Bouche à oreille)
  ↓
LANDING PAGE (index.html)
  ↓ Hero — Capter l'attention
  ↓ Problème — Créer la résonance
  ↓ Solution — Présenter TextileHub
  ↓ Comment ça marche — Rassurer
  ↓ Programme Fondateur — ❤️ CONVERSION
  ↓ Vision — Crédibilité
  ↓ FAQ — Lever objections
  ↓ CTA Final — Dernière chance
  ↓
MODALE DE QUALIFICATION (formulaire 3 étapes)
  ↓
PAGE DE CONFIRMATION (confirmation.html)
  ↓
CONTACT WHATSAPP (sous 48h)
  ↓
PRÉSENTATION DÉTAILLÉE
  ↓
SÉLECTION ATELIER FONDATEUR
```

### Taux de conversion cibles

| Étape | Taux de conversion cible |
|-------|--------------------------|
| Visite → Scroll 50% | 50% |
| Visite → CTA click | 10% |
| CTA click → Formulaire ouvert | 80% |
| Formulaire ouvert → Soumission | 50% |
| **Visite → Candidature** | **2.5%** |

**Pour 10 candidatures :** ~400 visites nécessaires

---

## 📝 FORMULAIRE DE QUALIFICATION

### Objectif du formulaire
Collecter suffisamment d'informations pour :
1. Qualifier l'atelier (taille, techniques, volume)
2. Comprendre le problème vécu
3. Mesurer l'intention d'utilisation
4. Tester la disposition à payer
5. Contacter rapidement (WhatsApp prioritaire)

### Structure : 3 étapes, 12 champs

**Étape 1 — Qui êtes-vous ?**
- Prénom, Nom
- WhatsApp (canal prioritaire)
- Email
- Nom de l'atelier
- Ville, Pays

**Étape 2 — Votre activité**
- Techniques (checkboxes multiples)
- Volume de commandes/mois
- Outils actuels
- Problème principal

**Étape 3 — Votre intérêt**
- Fonctionnalités intéressantes
- Intention d'utilisation
- Intention de paiement
- Motivation (optionnel)

### Backend
**Netlify Forms** (gratuit, zéro config)

---

## 📊 TRACKING & ANALYTICS

### Événements critiques à suivre

| Événement | Déclencheur | Plateforme |
|-----------|-------------|------------|
| `PageView` | Chargement page | FB + GA4 |
| `program_cta_click` | Clic CTA Programme | FB + GA4 |
| `form_opened` | Ouverture modale | FB + GA4 |
| `form_submitted` | ⭐ Soumission formulaire | FB + GA4 |
| `Lead` | Page confirmation | FB Pixel |
| `whatsapp_click` | Clic WhatsApp | FB + GA4 |

### Outils
- **Facebook Pixel** (tracking conversions Facebook Ads)
- **Google Analytics 4** (analyse comportementale)
- **Netlify Forms** (réception candidatures)

---

## 💰 MODÈLE ÉCONOMIQUE TESTÉ

### Programme Atelier Fondateur

**Bénéfices garantis :**
- Tarif fondateur à vie (préférentiel vs tarif public)
- Accès anticipé à TextileHub
- Accompagnement personnalisé
- Influence sur les fonctionnalités
- Communauté privée des fondateurs
- Statut de fondateur

**Tarification à valider :**
- Option 1 : Précommande symbolique 5 000 FCFA (réserver place)
- Option 2 : Tarif fondateur mensuel (ex : 5 000 FCFA/mois à vie vs 15 000 public)
- Option 3 : Gratuit phase pilote, tarif après validation

**Décision :** À prendre après analyse des intentions de paiement dans les formulaires

---

## 🚀 PLAN DE LANCEMENT

### Phase 1 : Préparation (J-7 à J-1)
- [ ] Configuration landing page (Pixel, GA4, WhatsApp)
- [ ] Tests complets (formulaire, tracking, responsive)
- [ ] Création compte Facebook Ads
- [ ] Préparation visuels publicitaires
- [ ] Brief équipe de suivi (qui contacte les candidats ?)

### Phase 2 : Lancement soft (J0 à J+3)
- [ ] Mise en ligne landing page
- [ ] Campagne test Facebook Ads (budget : 50-100€)
- [ ] Partage organique (réseaux sociaux, groupes WhatsApp)
- [ ] Monitoring quotidien des métriques
- [ ] Contact immédiat des premiers candidats

### Phase 3 : Optimisation (J+4 à J+14)
- [ ] Analyse des données (où abandonnent-ils ?)
- [ ] Ajustements copywriting si nécessaire
- [ ] Augmentation budget pub si funnel fonctionne
- [ ] Feedback des premiers échanges candidats
- [ ] Itération sur le message

### Phase 4 : Sélection (J+15)
- [ ] Revue des 10+ candidatures
- [ ] Scoring de qualification
- [ ] Sélection des 10 Ateliers Fondateurs
- [ ] Organisation onboarding

---

## 📱 CANAUX D'ACQUISITION

### Prioritaires
1. **Facebook Ads** (ciblage ateliers textiles Bénin)
2. **Instagram Ads** (même ciblage)
3. **Bouche à oreille** (réseaux d'entrepreneurs textiles)
4. **Groupes WhatsApp** (communautés professionnelles)

### Secondaires
5. Google Ads (recherche "gestion atelier textile")
6. Partenariats fournisseurs (vinyle, flex, machines)
7. Événements sectoriels (salons, formations)

---

## 🎯 CRITÈRES DE DÉCISION POST-VALIDATION

### Si succès (≥ 10 candidatures qualifiées)
✅ **Hypothèse validée** → Passer au développement MVP  
→ Actions :
- Onboarder les 10 ateliers fondateurs
- Prioriser les fonctionnalités selon leurs feedbacks
- Définir le pricing définitif
- Lancer le développement Laravel

### Si échec partiel (5-9 candidatures)
⚠️ **Intérêt mitigé** → Investiguer les blocages  
→ Actions :
- Analyser les abandons (quelle étape ?)
- Interviewer les candidats (pourquoi oui/non ?)
- Ajuster le message ou la proposition de valeur
- Relancer une campagne test

### Si échec total (< 5 candidatures)
❌ **Hypothèse invalidée** → Pivoter ou abandonner  
→ Actions :
- Interviews approfondies (le problème existe-t-il vraiment ?)
- Revoir le pricing (trop cher ?)
- Revoir la cible (mauvais segment ?)
- Décider : pivoter ou arrêter

---

## 📅 TIMELINE PROJET

| Date | Étape | Statut |
|------|-------|--------|
| **Semaine 1** | Développement landing page | ✅ Terminé |
| **Semaine 2** | Configuration & Tests | En cours |
| **Semaine 3** | Lancement campagne | À venir |
| **Semaine 4-5** | Collecte candidatures | À venir |
| **Semaine 6** | Analyse & Sélection | À venir |
| **Semaine 7+** | Onboarding fondateurs | À venir |

---

## 👥 ÉQUIPE & RESPONSABILITÉS

### Développement
- Développement landing page : ✅ Terminé
- Configuration tracking : À faire
- Tests & QA : À faire

### Marketing
- Copywriting : ✅ Terminé (à ajuster selon retours)
- Visuels publicitaires : À créer
- Campagne Facebook Ads : À lancer
- Community management : À définir

### Commercial
- Suivi candidatures : À définir (qui ?)
- Contact WhatsApp : À définir (qui ?)
- Qualification : À définir (critères ✅)
- Présentation détaillée : À préparer

### Produit
- Priorisation fonctionnalités : Selon feedbacks fondateurs
- Roadmap MVP : Après validation commerciale

---

## 💡 HYPOTHÈSES À TESTER

1. **Le problème est réel**
   → Les ateliers sont vraiment confrontés à la désorganisation WhatsApp

2. **La solution est comprise**
   → Les ateliers comprennent ce que TextileHub va leur apporter

3. **La solution est désirable**
   → Les ateliers veulent utiliser TextileHub

4. **La solution est payante**
   → Les ateliers sont prêts à payer pour la solution

5. **Le pricing est acceptable**
   → Le tarif proposé est dans leur budget

---

## 📊 DASHBOARD DE SUIVI

### Métriques quotidiennes (Semaines 3-5)
- Visiteurs uniques
- Taux de scroll 50%
- Clics CTA Programme Fondateur
- Formulaires ouverts
- **Formulaires soumis** ⭐
- Taux de conversion global

### Métriques qualitatives
- Motivations citées dans le formulaire
- Problèmes principaux rencontrés
- Fonctionnalités les plus demandées
- Objections récurrentes
- Feedbacks directs (WhatsApp, email)

---

## 🔄 PROCESS POST-CANDIDATURE

### J+0 : Candidature reçue
- Notification automatique (Netlify)
- Ajout à Google Sheets
- Scoring automatique (si possible)

### J+1 : Premier contact
- Message WhatsApp personnalisé :
  > "Bonjour [Prénom], merci pour votre candidature au Programme Atelier Fondateur TextileHub ! Nous étudions votre profil et revenons vers vous sous 48h. Avez-vous des questions en attendant ?"

### J+2 : Qualification
- Revue du profil
- Décision : qualifié / non qualifié / à investiguer
- Si qualifié → Planifier appel de présentation

### J+3 à J+7 : Présentation détaillée
- Appel WhatsApp ou téléphone (30-45 min)
- Démo TextileHub (maquettes)
- Réponses aux questions
- Présentation du programme en détail
- Proposition de tarif fondateur

### J+8 à J+14 : Décision
- Candidat décide : oui / non / besoin de réfléchir
- Si oui → Précommande symbolique (si applicable)
- Si non → Comprendre pourquoi (feedback)

---

## 📋 LIVRABLES DU PROJET

### Livrables techniques ✅
- [x] Landing page responsive (index.html)
- [x] Page de confirmation (confirmation.html)
- [x] Formulaire de qualification (3 étapes, 12 champs)
- [x] Configuration tracking (Facebook Pixel + GA4)
- [x] Configuration Netlify Forms
- [x] Configuration déploiement (netlify.toml)

### Livrables documentation ✅
- [x] README.md (doc technique)
- [x] QUICK_START.md (démarrage rapide)
- [x] CHECKLIST.md (tests pré-lancement)
- [x] SUMMARY.md (récapitulatif)
- [x] COPYWRITING_GUIDE.md (alternatives textes)
- [x] PROJECT_BRIEF.md (ce document)

### Livrables à produire
- [ ] Visuels Facebook Ads (3-5 variations)
- [ ] Script de présentation détaillée (appel candidats)
- [ ] Template de suivi Google Sheets
- [ ] Email/WhatsApp templates (suivi candidats)

---

## 🎯 KPIs FINAUX

| Métrique | Objectif | Critique |
|----------|----------|----------|
| **Candidatures reçues** | ≥ 10 | ⭐⭐⭐ |
| **Candidatures qualifiées** | ≥ 10 | ⭐⭐⭐ |
| Taux de conversion visite → candidature | ≥ 2.5% | ⭐⭐ |
| Taux de completion formulaire | ≥ 50% | ⭐⭐ |
| Coût par lead (Facebook Ads) | < 10€ | ⭐ |
| Intention de paiement (réponses formulaire) | ≥ 60% "Oui" ou "Peut-être" | ⭐⭐⭐ |

---

## ✅ CHECKLIST FINALE AVANT LANCEMENT

### Configuration
- [ ] Facebook Pixel ID configuré
- [ ] Google Analytics ID configuré
- [ ] Numéro WhatsApp configuré (3 endroits)
- [ ] Netlify Forms testé et fonctionnel
- [ ] Logo TextileHub ajouté (si disponible)

### Tests
- [ ] Formulaire soumis avec succès (test end-to-end)
- [ ] Page de confirmation accessible
- [ ] Tracking vérifié (Facebook Events Manager)
- [ ] Responsive testé (mobile, tablet, desktop)
- [ ] Tous les CTA ouvrent la modale
- [ ] FAQ accordéon fonctionne
- [ ] Lien WhatsApp fonctionne

### Marketing
- [ ] Campagne Facebook Ads créée
- [ ] Budget défini et validé
- [ ] Ciblage configuré (ateliers textiles Bénin)
- [ ] Visuels publicitaires prêts
- [ ] Landing page URL finalisée

### Équipe
- [ ] Responsable suivi candidatures désigné
- [ ] Process de contact défini
- [ ] Script de présentation préparé
- [ ] Planning disponibilités équipe (appels candidats)

---

**🚀 Prêt pour la validation commerciale TextileHub !**

**Date de lancement prévue :** [À compléter]  
**Responsable projet :** [À compléter]  
**Contact technique :** [À compléter]
