# 🚀 DÉMARRAGE RAPIDE — TEXTILEHUB LANDING PAGE

## ⏱️ En 10 minutes, votre landing page est en ligne

---

## ÉTAPE 1 : Configuration minimale (2 min)

### Ouvrir `index.html` et `confirmation.html`

Remplacer ces 3 éléments :

#### A. Facebook Pixel ID (ligne ~45 dans les 2 fichiers)
```javascript
fbq('init', 'YOUR_PIXEL_ID'); // ← Remplacer
```
👉 **Votre Pixel ID :** [À trouver dans Facebook Business Manager]

#### B. Google Analytics ID (ligne ~53 dans les 2 fichiers)
```javascript
gtag('config', 'G-XXXXXXXXXX'); // ← Remplacer
```
👉 **Votre GA4 ID :** [À trouver dans Google Analytics > Admin > Flux de données]

#### C. Numéro WhatsApp (2 endroits dans `index.html`, 1 dans `confirmation.html`)
```html
href="https://wa.me/YOUR_PHONE_NUMBER?text=..."
```
👉 **Format :** `+229XXXXXXXX` (indicatif pays + numéro sans espaces)

**Exemple Bénin :** `+22997123456`

---

## ÉTAPE 2 : Déploiement sur Netlify (5 min)

### Option la plus simple : Drag & Drop

1. **Allez sur [app.netlify.com](https://app.netlify.com)**
2. **Créez un compte** (gratuit)
3. **Cliquez sur "Add new site" > "Deploy manually"**
4. **Glissez-déposez** tout le dossier `textilehub-landing`
5. **Attendez 30 secondes** ⏳
6. **Votre site est en ligne !** 🎉

Netlify vous donne une URL temporaire : `https://random-name-123.netlify.app`

---

## ÉTAPE 3 : Test du formulaire (2 min)

1. **Ouvrez votre site Netlify**
2. **Cliquez sur un CTA** (Rejoindre le Programme)
3. **Remplissez le formulaire** avec des données de test
4. **Soumettez**
5. **Vérifiez la réception :**
   - Netlify Dashboard > **Forms** > **atelier-fondateur**
   - Vous devez voir votre soumission test ✅

---

## ÉTAPE 4 : Test mobile (1 min)

1. **Ouvrez le site sur votre téléphone**
2. **Vérifiez que tout s'affiche correctement**
3. **Testez le bouton WhatsApp** (il doit ouvrir l'app)

---

## ✅ C'EST TOUT ! Vous êtes prêt.

### Prochaines actions recommandées :

#### Immédiat
- [ ] Partager le lien sur vos réseaux sociaux pour tester
- [ ] Envoyer à 2-3 ateliers textiles que vous connaissez
- [ ] Vérifier que vous recevez bien les soumissions

#### Dans les 24h
- [ ] Configurer une campagne Facebook Ads test (budget : 50-100€)
- [ ] Vérifier que les événements Facebook Pixel fonctionnent
- [ ] Analyser les premières interactions

#### Première semaine
- [ ] Contacter les candidats sous 48h
- [ ] Analyser le taux de conversion
- [ ] Ajuster le copywriting si besoin

---

## 📞 Besoin d'aide ?

### Problème : Le formulaire ne fonctionne pas
**Solution :** Le site doit être déployé sur Netlify (pas en local)

### Problème : Facebook Pixel ne track pas
**Solution :** 
1. Installer [Facebook Pixel Helper](https://chrome.google.com/webstore/detail/facebook-pixel-helper/fdgfkebogiimcoedlicjlajpkdmockpc)
2. Vérifier que le Pixel ID est correct
3. Désactiver votre bloqueur de pub pour tester

### Problème : Page de confirmation 404
**Solution :** Vérifier que `confirmation.html` est bien dans le dossier racine

---

## 🎯 Métriques à suivre

### Dans Netlify Forms
- Nombre de candidatures reçues
- Taux de completion (formulaires commencés vs soumis)

### Dans Facebook Ads Manager
- Événement `form_submitted` (conversion principale)
- Coût par lead (CPL)

### Dans Google Analytics
- Visiteurs uniques
- Taux de rebond
- Événements `program_cta_click` et `form_opened`

---

## 🔥 Optimisations rapides (après 1 semaine de données)

### Si beaucoup de visites mais peu de formulaires ouverts :
👉 **Problème :** Le message ne résonne pas  
✅ **Action :** Ajuster le copywriting du Hero

### Si beaucoup de formulaires ouverts mais peu de soumissions :
👉 **Problème :** Le formulaire est trop long ou effrayant  
✅ **Action :** Simplifier à 6-8 champs maximum

### Si beaucoup de soumissions mais peu qualifiées :
👉 **Problème :** Le ciblage est trop large  
✅ **Action :** Ajouter des critères de qualification

---

## 🎨 Personnalisation (optionnel)

### Ajouter votre logo
1. Ajoutez votre fichier dans `/assets/logo-textilehub.svg`
2. Remplacez le placeholder texte dans `index.html` (ligne ~58)

### Changer les couleurs
Modifiez dans le `<script>` du `<head>` :
```javascript
colors: {
    primary: '#1E40AF',    // Bleu
    accent: '#F97316',     // Orange (CTA)
    secondary: '#059669',  // Vert
}
```

### Ajouter des mockups
1. Exportez vos maquettes Figma en PNG/WebP
2. Ajoutez-les dans `/assets/mockups/`
3. Remplacez les placeholders dans le code

---

## 📚 Documentation complète

Pour plus de détails, consultez :
- **README.md** — Documentation technique complète
- **CHECKLIST.md** — Tous les tests à effectuer avant lancement
- **netlify.toml** — Configuration du déploiement

---

## 🎉 Félicitations !

Votre landing page de validation commerciale est maintenant en ligne.

**L'objectif : 10 candidatures qualifiées dans les 2 premières semaines.**

**Bonne chance avec le Programme Atelier Fondateur ! 🚀**

---

**TextileHub — Transformons ensemble le secteur textile africain.**
