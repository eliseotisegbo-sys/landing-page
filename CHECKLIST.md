# ✅ CHECKLIST DE TEST — LANDING PAGE TEXTILEHUB

## 📋 Avant mise en ligne

### Configuration initiale

- [ ] **Facebook Pixel ID** configuré dans `index.html` et `confirmation.html`
  - Remplacer `YOUR_PIXEL_ID` par votre ID réel
  - Tester avec Facebook Pixel Helper (extension Chrome)

- [ ] **Google Analytics ID** configuré dans les 2 fichiers
  - Remplacer `G-XXXXXXXXXX` par votre ID GA4
  - Vérifier dans GA4 > Rapports en temps réel

- [ ] **Numéro WhatsApp** configuré (2 endroits)
  - `index.html` : Section CTA Final
  - `confirmation.html` : Bouton de contact
  - Format : `+229XXXXXXXX` (indicatif + numéro sans espaces)

- [ ] **Logo TextileHub** ajouté (optionnel pour V1)
  - Si disponible, remplacer le placeholder texte
  - Format recommandé : SVG ou PNG transparent

- [ ] **Netlify Forms** activé
  - Formulaire déployé sur Netlify (pas en local)
  - Attribut `data-netlify="true"` présent

---

## 🧪 Tests fonctionnels

### Navigation générale

- [ ] Page se charge correctement (pas d'erreurs console)
- [ ] Tous les liens d'ancres fonctionnent (`#comment-ca-marche`)
- [ ] Scroll smooth fonctionne
- [ ] Logo cliquable retourne à l'accueil (si logo ajouté)

### Hero (Section 1)

- [ ] Titre et sous-titre lisibles
- [ ] Badge "10 places disponibles" visible
- [ ] CTA "Rejoindre le Programme" ouvre la modale
- [ ] Mockup visuel s'affiche correctement

### Section Problème

- [ ] Les 5 problèmes s'affichent correctement
- [ ] Icônes et textes alignés
- [ ] Lisible sur mobile

### Section Solution

- [ ] Les 3 piliers s'affichent en grille
- [ ] Icônes SVG s'affichent
- [ ] Lien "Voir comment ça fonctionne" scroll vers la bonne section

### Section Comment ça marche

- [ ] Timeline des 4 étapes s'affiche
- [ ] Numéros dans les cercles visibles
- [ ] CTA "Rejoindre le programme" ouvre la modale

### Programme Atelier Fondateur (SECTION CRITIQUE)

- [ ] Badge "Places limitées" visible et animé
- [ ] Les 6 bénéfices s'affichent en grille
- [ ] CTA principal "Postuler maintenant" ouvre la modale
- [ ] Texte "Plus que 10 places" visible

### Section Vision

- [ ] Texte lisible et bien espacé
- [ ] Encart bleu avec message clé visible

### FAQ

- [ ] Accordéon fonctionne (clic ouvre/ferme)
- [ ] Les 7 questions s'affichent
- [ ] Icône flèche tourne à l'ouverture
- [ ] Tracking `faq_item_click` fonctionne

### CTA Final

- [ ] CTA "Postuler au Programme Fondateur" ouvre la modale
- [ ] Lien WhatsApp fonctionne et pré-remplit le message
- [ ] Lien s'ouvre dans un nouvel onglet

### Footer

- [ ] Copyright et texte s'affichent
- [ ] Pas de liens cassés

---

## 📝 Formulaire de qualification (CRITIQUE)

### Modale

- [ ] S'ouvre au clic sur n'importe quel CTA
- [ ] Se ferme au clic sur X
- [ ] Se ferme au clic sur l'overlay (fond noir)
- [ ] Se ferme avec la touche Échap
- [ ] Indicateur de progression (3 barres) fonctionne

### Étape 1 : Informations personnelles

- [ ] Champs prénom, nom, WhatsApp, email obligatoires
- [ ] Validation email fonctionne (format email)
- [ ] Validation téléphone fonctionne
- [ ] Champs ville et pays obligatoires
- [ ] Select pays affiche les bonnes options
- [ ] Bouton "Suivant" passe à l'étape 2
- [ ] Tracking `qualification_step_complete` (step: 1)

### Étape 2 : Votre activité

- [ ] Checkboxes techniques fonctionnent (choix multiples)
- [ ] Au moins 1 technique doit être sélectionnée
- [ ] Select "Commandes par mois" obligatoire
- [ ] Champ "Outils actuels" optionnel
- [ ] Select "Problème principal" obligatoire
- [ ] Bouton "Retour" revient à l'étape 1
- [ ] Bouton "Suivant" passe à l'étape 3
- [ ] Tracking `qualification_step_complete` (step: 2)

### Étape 3 : Intention et motivation

- [ ] Select "Fonctionnalités intéressantes" obligatoire
- [ ] Select "Intention utilisation" obligatoire
- [ ] Select "Intention paiement" obligatoire
- [ ] Textarea "Motivation" optionnelle
- [ ] Checkbox consentement obligatoire
- [ ] Bouton "Retour" revient à l'étape 2
- [ ] Bouton "Envoyer" soumet le formulaire

### Soumission du formulaire

- [ ] Tracking `qualification_complete` avant envoi
- [ ] Formulaire s'envoie sans erreur
- [ ] Redirection vers `/confirmation.html` après succès
- [ ] Tracking `form_submitted` après succès
- [ ] Message d'erreur si échec
- [ ] Tracking `form_error` si échec

### Réception des données

- [ ] Se connecter à Netlify Dashboard
- [ ] Aller dans "Forms" > "atelier-fondateur"
- [ ] Vérifier que la soumission test apparaît
- [ ] Vérifier que toutes les données sont présentes
- [ ] Techniques apparaissent en liste séparée par virgules

---

## ✉️ Page de confirmation

- [ ] Page accessible via `/confirmation.html`
- [ ] Icône de succès ✓ s'affiche
- [ ] Titre "Candidature reçue ! 🎉" visible
- [ ] Les 4 prochaines étapes listées
- [ ] Lien WhatsApp fonctionne et pré-remplit le message
- [ ] Lien "Retour à l'accueil" fonctionne
- [ ] Tracking `Lead` Facebook Pixel déclenché
- [ ] Tracking `conversion` Google Analytics déclenché

---

## 📱 Tests responsive (PRIORITÉ)

### Mobile (320px - 767px)

- [ ] Toutes les sections s'affichent correctement
- [ ] Textes lisibles sans zoom
- [ ] Boutons faciles à cliquer (min 44x44px)
- [ ] Formulaire confortable à remplir
- [ ] Pas de scroll horizontal
- [ ] Images ne débordent pas
- [ ] Grilles passent en 1 colonne
- [ ] Timeline "Comment ça marche" lisible
- [ ] FAQ confortable à utiliser
- [ ] Modale prend toute la hauteur d'écran

### Tablet (768px - 1023px)

- [ ] Layout s'adapte correctement
- [ ] Grilles en 2 colonnes où prévu
- [ ] Espacements corrects

### Desktop (1024px+)

- [ ] Contenu centré (max-width respecté)
- [ ] Grilles en 3 colonnes où prévu
- [ ] Pas d'espaces vides disgracieux

### Appareils à tester en priorité

- [ ] iPhone SE (320px)
- [ ] iPhone 12/13/14 (390px)
- [ ] Samsung Galaxy S21 (360px)
- [ ] iPad (768px)
- [ ] Desktop 1920px

---

## 🎯 Tests de tracking

### Facebook Pixel

Installer [Facebook Pixel Helper](https://chrome.google.com/webstore/detail/facebook-pixel-helper/fdgfkebogiimcoedlicjlajpkdmockpc)

- [ ] `PageView` tracké au chargement
- [ ] `hero_cta_click` au clic Hero
- [ ] `program_cta_click` au clic Programme Fondateur
- [ ] `form_opened` à l'ouverture modale
- [ ] `qualification_step_complete` à chaque étape
- [ ] `qualification_complete` avant soumission
- [ ] `form_submitted` après soumission
- [ ] `Lead` sur page de confirmation
- [ ] `whatsapp_click` au clic WhatsApp
- [ ] `scroll_50` à 50% de scroll
- [ ] `scroll_100` à 100% de scroll

Vérifier dans **Facebook Events Manager > Test Events** en temps réel.

### Google Analytics 4

- [ ] Ouvrir GA4 > Rapports en temps réel
- [ ] `page_view` s'affiche
- [ ] Événements personnalisés s'affichent
- [ ] Conversion `lead` sur page confirmation

---

## ⚡ Tests de performance

### Lighthouse (Chrome DevTools)

- [ ] Ouvrir DevTools (F12) > Lighthouse
- [ ] Mode : Mobile
- [ ] Lancer l'audit

**Scores cibles :**
- [ ] Performance : > 90
- [ ] Accessibility : > 95
- [ ] Best Practices : > 90
- [ ] SEO : 100

### Temps de chargement

- [ ] First Contentful Paint < 1.5s
- [ ] Time to Interactive < 3s
- [ ] Largest Contentful Paint < 2.5s

### Poids de la page

- [ ] Total < 500 KB (ou < 1 MB avec images)
- [ ] Si > 1 MB, optimiser les images (compression, WebP)

---

## 🔍 Tests SEO

### Balises meta

- [ ] `<title>` présent et descriptif
- [ ] `<meta description>` présente (150-160 caractères)
- [ ] `<meta keywords>` présente
- [ ] Open Graph configuré (`og:title`, `og:description`, `og:image`)
- [ ] `lang="fr"` dans `<html>`

### Structure HTML

- [ ] Un seul `<h1>` (Hero)
- [ ] Hiérarchie `<h2>`, `<h3>` respectée
- [ ] Textes alternatifs sur les images (`alt=""`)
- [ ] Liens externes avec `target="_blank"` et `rel="noopener"`

### Indexation

- [ ] Pas de `noindex` (sauf si voulu)
- [ ] Fichier `robots.txt` (optionnel)
- [ ] Sitemap.xml (optionnel pour V1)

---

## 🔒 Tests de sécurité

- [ ] HTTPS actif (automatique sur Netlify)
- [ ] Pas d'erreurs de certificat SSL
- [ ] Honeypot anti-spam présent (`bot-field` caché)
- [ ] Validation HTML5 des champs formulaire
- [ ] Pas de données sensibles en clair dans le code

---

## 🌍 Tests multi-navigateurs

- [ ] Chrome (priorité)
- [ ] Safari (iOS — important !)
- [ ] Firefox
- [ ] Edge
- [ ] Chrome Mobile
- [ ] Safari Mobile

---

## 📊 Tests d'intégration Netlify

### Déploiement

- [ ] Site déployé sans erreurs
- [ ] URL personnalisée configurée (si domaine acheté)
- [ ] Redirections 301 si nécessaire

### Formulaires

- [ ] Netlify détecte le formulaire automatiquement
- [ ] Soumission apparaît dans Dashboard > Forms
- [ ] Notifications email configurées (optionnel)
- [ ] Export CSV fonctionne

---

## 🎨 Tests visuels

### Design général

- [ ] Couleurs cohérentes (primary, accent, secondary)
- [ ] Polices chargées correctement (Inter)
- [ ] Espacements homogènes
- [ ] Pas d'éléments qui se chevauchent
- [ ] Contrastes suffisants (WCAG AA minimum)

### Animations

- [ ] Badge "Places limitées" pulse doucement
- [ ] Transitions des boutons au hover
- [ ] Accordéon FAQ s'ouvre/ferme en douceur
- [ ] Pas d'animations saccadées

---

## 📞 Tests de contact

### WhatsApp

- [ ] Lien WhatsApp ouvre l'app/web correctement
- [ ] Message pré-rempli apparaît
- [ ] Numéro correct (format international)

### Email (si utilisé)

- [ ] Lien `mailto:` fonctionne
- [ ] Sujet pré-rempli

---

## 🚀 Tests avant campagne publicitaire

### Facebook Ads

- [ ] Pixel installé et validé
- [ ] Événement de conversion `form_submitted` configuré
- [ ] URL finale testée (cliquable depuis un post/annonce test)
- [ ] Open Graph s'affiche correctement (aperçu lien Facebook)

### Google Ads (si utilisé)

- [ ] Conversion `lead` configurée
- [ ] URL de destination correcte

---

## 📝 Checklist finale pré-lancement

- [ ] Toutes les URLs de test remplacées par les URLs finales
- [ ] Tous les placeholders remplacés (logo, images, numéros)
- [ ] Aucun "Lorem ipsum" ou texte de dev
- [ ] Console navigateur sans erreurs
- [ ] Tests sur 3 appareils minimum (mobile, tablet, desktop)
- [ ] 1 soumission test complétée et reçue
- [ ] Tracking validé sur tous les CTA critiques
- [ ] README.md à jour
- [ ] Documentation partagée avec l'équipe

---

## 🎯 Post-lancement immédiat

### Premières 24h

- [ ] Vérifier que le site est accessible
- [ ] Vérifier réception des premières soumissions
- [ ] Monitorer les événements Facebook/GA4
- [ ] Vérifier temps de réponse (< 3s)
- [ ] Pas d'erreurs console

### Première semaine

- [ ] Analyser taux de conversion formulaire
- [ ] Identifier les abandons (quelle étape ?)
- [ ] Lire les motivations des candidats
- [ ] Ajuster copywriting si nécessaire
- [ ] Optimiser selon données réelles

---

## 🐛 Problèmes courants et solutions

### Le formulaire ne s'envoie pas
✅ **Vérifier :**
- Site déployé sur Netlify (pas en local)
- `data-netlify="true"` présent
- `name="atelier-fondateur"` correspond
- Console navigateur (F12) pour les erreurs

### Facebook Pixel ne track pas
✅ **Vérifier :**
- Pixel ID correct
- Facebook Pixel Helper (extension)
- Bloqueur de pub désactivé (test)
- Events Manager (temps réel)

### Page de confirmation 404
✅ **Vérifier :**
- `confirmation.html` à la racine
- Chemin correct : `/confirmation.html` (pas `confirmation.html`)
- Fichier bien déployé sur Netlify

### Modale ne s'ouvre pas
✅ **Vérifier :**
- Alpine.js chargé (CDN accessible)
- `@click="$dispatch('open-modal')"` présent
- `x-data` initialisé
- Console pour erreurs JavaScript

---

**🎉 Une fois tous les tests validés, vous êtes prêt pour le lancement !**

**📊 N'oubliez pas : la validation commerciale commence maintenant. Analysez, apprenez, itérez.**
