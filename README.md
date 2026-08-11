# Landing Page TextileHub — Programme Atelier Fondateur

## 📋 Vue d'ensemble

Landing page de validation commerciale pour le Programme Atelier Fondateur de TextileHub.

**Objectif :** Collecter 10 candidatures qualifiées d'ateliers de personnalisation textile en Afrique francophone.

---

## 🏗️ Architecture

### Pages
- **index.html** — Landing page principale
- **confirmation.html** — Page de confirmation après soumission du formulaire

### Sections de la landing page
1. **Hero** — Proposition de valeur + CTA principal
2. **Problème** — Reconnaissance des difficultés des ateliers
3. **Solution** — Présentation TextileHub en 3 piliers
4. **Comment ça marche** — Process en 4 étapes
5. **Programme Atelier Fondateur** — Offre principale (cœur de la conversion)
6. **Vision** — Pourquoi nous construisons TextileHub (crédibilité)
7. **FAQ** — 7 questions pour lever les objections
8. **CTA Final** — Dernière opportunité de conversion

### Formulaire de qualification (modale)
**3 étapes** — 12 champs de qualification :
- Étape 1 : Informations personnelles (prénom, nom, WhatsApp, email, atelier, ville, pays)
- Étape 2 : Activité (techniques, volume commandes, outils actuels, problème principal)
- Étape 3 : Intention (fonctionnalités intéressantes, intention utilisation, intention paiement, motivation)

---

## 🛠️ Stack technique

- **HTML5 sémantique**
- **Tailwind CSS** (via CDN)
- **Alpine.js** (interactivité légère — modale, FAQ accordéon)
- **Netlify Forms** (stockage des candidatures)
- **Facebook Pixel** (tracking conversions)
- **Google Analytics 4** (analytics)

---

## 🚀 Déploiement sur Netlify

### Prérequis
- Compte Netlify (gratuit)
- Repository Git (optionnel mais recommandé)

### Étapes

#### Option A : Déploiement drag & drop (le plus simple)
1. Allez sur [netlify.com](https://netlify.com) et connectez-vous
2. Cliquez sur **"Add new site" > "Deploy manually"**
3. Glissez-déposez le dossier `textilehub-landing` complet
4. Votre site est en ligne en quelques secondes !

#### Option B : Déploiement via Git (recommandé pour la production)
1. Créez un repository GitHub avec ces fichiers
2. Sur Netlify : **"Add new site" > "Import an existing project"**
3. Connectez votre repository GitHub
4. Configuration :
   - Build command : *(laisser vide)*
   - Publish directory : `/`
5. Cliquez sur **"Deploy"**

### Configuration du formulaire Netlify Forms

Le formulaire est déjà configuré dans le code avec :
```html
<form name="atelier-fondateur" method="POST" data-netlify="true" netlify-honeypot="bot-field">
```

Les soumissions apparaîtront automatiquement dans :
**Netlify Dashboard > Forms > atelier-fondateur**

Vous pouvez :
- Voir toutes les candidatures
- Exporter en CSV
- Configurer des notifications email

---

## 📊 Configuration du tracking

### 1. Facebook Pixel

**Remplacer dans `index.html` et `confirmation.html` :**
```javascript
fbq('init', 'YOUR_PIXEL_ID'); // ← Remplacer par votre Pixel ID
```

**Où trouver votre Pixel ID :**
1. Facebook Business Manager > Gestionnaire d'événements
2. Créez un pixel si vous n'en avez pas
3. Copiez l'ID (format : 123456789012345)

**Événements trackés :**
- `PageView` (automatique)
- `hero_cta_click`
- `program_cta_click` (métrique principale)
- `form_opened`
- `form_submitted` (conversion principale)
- `qualification_step_complete`
- `faq_item_click`
- `footer_cta_click`
- `whatsapp_click`
- `scroll_50`, `scroll_100`

### 2. Google Analytics 4

**Remplacer dans `index.html` et `confirmation.html` :**
```javascript
gtag('config', 'G-XXXXXXXXXX'); // ← Remplacer par votre ID GA4
```

**Où trouver votre ID :**
1. Google Analytics > Admin > Flux de données
2. Créez une propriété GA4 si nécessaire
3. Copiez l'ID de mesure (format : G-XXXXXXXXXX)

---

## 🎨 Personnalisation

### Logo TextileHub
Actuellement, un placeholder texte est utilisé. Pour ajouter votre logo :

1. Ajoutez votre logo dans `/assets/logo-textilehub.svg` (ou .png)
2. Remplacez dans `index.html` ligne ~58 :
```html
<!-- Remplacer ce bloc -->
<div class="inline-block bg-white/10 backdrop-blur-sm px-6 py-3 rounded-lg">
    <h1 class="text-2xl font-bold">TextileHub</h1>
</div>

<!-- Par -->
<img src="/assets/logo-textilehub.svg" alt="TextileHub" class="h-12">
```

### Numéro WhatsApp
**Remplacer dans 2 endroits :**

1. `index.html` ligne ~XXX (CTA Footer)
2. `confirmation.html` ligne ~XXX

```html
href="https://wa.me/YOUR_PHONE_NUMBER?text=..."
```

**Format :** `+229XXXXXXXX` (indicatif pays + numéro sans espaces)

Exemple Bénin : `+22997123456`

### Couleurs
Dans `<script>` du `<head>` :
```javascript
tailwind.config = {
    theme: {
        extend: {
            colors: {
                primary: '#1E40AF',    // Bleu principal
                accent: '#F97316',     // Orange (CTA)
                secondary: '#059669',  // Vert (succès)
            }
        }
    }
}
```

### Mockups TextileHub
Les placeholders actuels sont des rectangles gris. Pour ajouter de vrais mockups :

1. Exportez vos maquettes Figma en PNG/WebP (optimisées)
2. Ajoutez-les dans `/assets/mockups/`
3. Remplacez les placeholders dans la section Hero et Solution

---

## ✅ Checklist avant mise en ligne

### Configuration
- [ ] Facebook Pixel ID configuré
- [ ] Google Analytics ID configuré
- [ ] Numéro WhatsApp configuré (2 endroits)
- [ ] Logo TextileHub ajouté (optionnel pour V1)
- [ ] Mockups réels ajoutés (optionnel pour V1)

### Tests
- [ ] Formulaire : remplir et soumettre un test
- [ ] Vérifier réception dans Netlify Forms
- [ ] Tester tous les CTA (ouverture modale)
- [ ] Tester FAQ (accordéon fonctionne)
- [ ] Tester lien WhatsApp
- [ ] Page de confirmation accessible
- [ ] Responsive : tester sur mobile (prioritaire !)
- [ ] Tracking : vérifier dans Facebook Events Manager

### Performance
- [ ] Lighthouse Score > 90 Performance
- [ ] Temps de chargement < 3s
- [ ] Images optimisées (WebP si possible)

### SEO
- [ ] Meta description renseignée
- [ ] Open Graph configuré
- [ ] Favicon ajouté (optionnel)

---

## 📱 Test mobile

**PRIORITÉ ABSOLUE** — 80% du trafic sera mobile.

### Outils de test
- DevTools Chrome (F12 > Toggle device toolbar)
- [Responsive Design Checker](https://responsivedesignchecker.com/)
- Votre propre téléphone (le mieux !)

### Points à vérifier
- Textes lisibles sans zoom
- Boutons faciles à cliquer (min 44x44px)
- Formulaire confortable à remplir
- Pas de scroll horizontal
- Temps de chargement acceptable (3G/4G)

---

## 📊 Analyse des conversions

### Funnel de conversion à suivre

```
100% Visiteurs (PageView)
  ↓
  X% Engagement (scroll_50)
  ↓
  X% Intérêt (hero_cta_click, program_cta_click)
  ↓
  X% Intention (form_opened)
  ↓
  X% Conversion (form_submitted)
```

### Objectifs initiaux
- **10 candidatures qualifiées** en 2 semaines
- Taux de conversion formulaire ouvert → soumis : > 50%
- Taux de conversion visite → formulaire ouvert : > 5%

### Où voir les données

**Netlify Forms :**
- Dashboard Netlify > Forms > atelier-fondateur
- Export CSV pour analyse

**Facebook Ads Manager :**
- Événements personnalisés
- Conversion `form_submitted`

**Google Analytics :**
- Événements > Tous les événements
- Filtrer par nom d'événement

---

## 🔒 Sécurité & Anti-spam

### Protections intégrées
- ✅ Honeypot Netlify (champ caché anti-bot)
- ✅ Validation HTML5 des champs
- ✅ HTTPS automatique (Netlify)

### Notifications de spam
Si vous recevez du spam :
1. Netlify Dashboard > Forms > Settings
2. Activer **reCAPTCHA** (gratuit)
3. Ou activer **Akismet** (payant)

---

## 💾 Export des candidatures

### Via Netlify Dashboard
1. Forms > atelier-fondateur
2. Bouton **"Export to CSV"**
3. Ouvrir dans Excel/Google Sheets

### Via Zapier (automatisation avancée)
Connecter Netlify Forms à :
- Google Sheets (auto-ajout des candidatures)
- Email (notification instantanée)
- WhatsApp Business API
- CRM (Notion, Airtable, HubSpot...)

---

## 📞 Support & Contact

### Structure des données du formulaire

Les candidatures contiendront :
- **Informations contact :** prénom, nom, whatsapp, email
- **Atelier :** nom_atelier, ville, pays
- **Activité :** techniques (liste), commandes_mois, outils_actuels, probleme_principal
- **Intention :** fonctionnalites_interessantes, intention_utilisation, intention_paiement, motivation
- **Métadonnées :** date/heure de soumission, IP (Netlify)

---

## 🎯 Prochaines étapes après déploiement

1. **Campagne test** — Petit budget Facebook Ads (50-100€) pour valider le funnel
2. **Itération** — Analyser les premiers résultats, ajuster le copywriting si besoin
3. **Qualification** — Contacter les candidats sous 48h par WhatsApp
4. **Feedback** — Comprendre pourquoi ils ont postulé (ou pas)
5. **Scale** — Augmenter le budget pub si les conversions sont bonnes

---

## 📝 Notes techniques

### Pourquoi Netlify Forms ?
- ✅ Gratuit jusqu'à 100 soumissions/mois
- ✅ Zéro configuration backend
- ✅ Anti-spam intégré
- ✅ Notifications email possibles
- ✅ Export CSV facile

### Pourquoi Alpine.js ?
- ✅ Léger (15 KB)
- ✅ Syntaxe simple (comme Vue.js)
- ✅ Pas de build step
- ✅ Parfait pour interactivité légère (modale, accordéon)

### Pourquoi Tailwind CDN ?
- ✅ Développement rapide
- ✅ Zéro configuration
- ⚠️ Pour production : passer au build optimisé (réduire le poids de 3 MB à ~10 KB)

---

## ⚡ Optimisations futures (après validation)

### Performance
- [ ] Build Tailwind optimisé (PurgeCSS)
- [ ] Lazy loading images
- [ ] WebP/AVIF pour les images
- [ ] Minification HTML/CSS/JS

### Fonctionnalités
- [ ] A/B testing du copywriting (hero)
- [ ] Heatmap (Hotjar, Microsoft Clarity)
- [ ] Chat WhatsApp intégré
- [ ] Preloader de formulaire
- [ ] Validation temps réel des champs

---

## 🐛 Troubleshooting

### Le formulaire ne s'envoie pas
- Vérifier que `data-netlify="true"` est présent
- Vérifier que `name="atelier-fondateur"` correspond
- Vérifier la console du navigateur (F12) pour les erreurs

### Facebook Pixel ne track pas
- Vérifier que le Pixel ID est correct
- Installer Facebook Pixel Helper (extension Chrome)
- Vérifier dans Events Manager (temps réel)

### Page de confirmation 404
- Vérifier que `confirmation.html` est à la racine
- Vérifier le chemin dans `submitForm()` : `/confirmation.html`

---

## 📄 Licence

© 2026 TextileHub. Tous droits réservés.

---

**Développé avec ❤️ pour le Programme Atelier Fondateur TextileHub**
