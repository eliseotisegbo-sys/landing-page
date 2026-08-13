# Configuration Vercel pour TextileHub

Ce guide explique comment configurer correctement le projet TextileHub sur Vercel.

## Architecture du projet

Le projet utilise une architecture Vercel moderne avec :
- **Frontend** : Fichiers HTML statiques (index.html, candidature.html, etc.)
- **Backend** : Serveur Express dans `server.js`
- **API** : Fonction serverless dans `api/index.js` qui exporte l'application Express
- **Configuration** : `vercel.json` avec rewrites pour router les requêtes API

## Structure des fichiers

```
textilehub-landing/
├── server.js              # Application Express principale
├── api/
│   └── index.js          # Point d'entrée pour Vercel (exporte server.js)
├── vercel.json           # Configuration Vercel
├── candidature.html      # Formulaire de candidature
├── index.html            # Landing page
└── .env.example          # Exemple de variables d'environnement
```

## Variables d'environnement requises

Dans le tableau de bord Vercel (Settings > Environment Variables), ajoutez les variables suivantes pour l'environnement **Production** :

### 1. SUPABASE_URL
- **Description** : URL de votre projet Supabase
- **Exemple** : `https://xxxxxxxxxxxxx.supabase.co`
- **Où trouver** : Dashboard Supabase > Settings > API

### 2. SUPABASE_SERVICE_ROLE_KEY
- **Description** : Clé de rôle service Supabase (très importante)
- **Où trouver** : Dashboard Supabase > Settings > API > service_role (secret)
- **⚠️ IMPORTANT** :
  - N'utilisez PAS la clé `anon` ou `public`
  - N'utilisez PAS `NEXT_PUBLIC_` comme préfixe
  - Cette clé contournera les restrictions RLS
  - Gardez cette clé secrète !

### 3. FRONTEND_URL
- **Description** : URL de votre frontend en production
- **Valeur** : `https://textilehub-founderoncel.app`
- **Note** : Sans slash final

### 4. NODE_ENV
- **Description** : Environnement d'exécution
- **Valeur** : `production`

## Vérification de la configuration

Après avoir ajouté les variables :

1. Allez dans votre projet Vercel
2. Cliquez sur "Settings" > "Environment Variables"
3. Vérifiez que les 4 variables sont présentes
4. Assurez-vous qu'elles sont activées pour "Production", "Preview" et "Development"

## Redéploiement après configuration

Une fois les variables configurées :

1. Allez dans "Deployments"
2. Cliquez sur le dernier déploiement
3. Cliquez sur "Redeploy" pour appliquer les nouvelles variables

## Test de l'API

Après redéploiement, testez :

1. Health check : `https://textilehub-founderoncel.app/api/health`
   - Doit retourner : `{"status":"ok","message":"API TextileHub fonctionnelle."}`
2. Formulaire : `https://textilehub-founderoncel.app/candidature.html`
   - Remplissez et soumettez le formulaire
   - Vérifiez que vous recevez le message de succès

## Résolution des problèmes courants

### Erreur 405 Method Not Allowed
- **Cause** : Configuration Vercel incorrecte
- **Solution** : Vérifiez que `api/index.js` existe et que `vercel.json` contient les rewrites corrects

### Erreur 503 "Service de base de données temporairement indisponible"
- **Cause** : Variables Supabase non configurées
- **Solution** : Vérifiez que `SUPABASE_URL` et `SUPABASE_SERVICE_ROLE_KEY` sont correctement configurés dans Vercel

### Erreur RLS (code 42501)
- **Cause** : Mauvaise clé Supabase utilisée
- **Solution** : Vérifiez que vous utilisez bien `SUPABASE_SERVICE_ROLE_KEY` et pas la clé `anon`

### Erreur CORS
- **Cause** : FRONTEND_URL mal configuré
- **Solution** : Vérifiez que `FRONTEND_URL` correspond exactement à votre domaine frontend (sans slash final)

### Erreur JSON.parse
- **Cause** : Le serveur renvoie du HTML au lieu du JSON
- **Solution** : Le backend est maintenant configuré pour toujours renvoyer du JSON, même en cas d'erreur

## Mode dégradé

Le backend inclut un mode dégradé :
- Si Supabase n'est pas configuré, l'API renvoie une erreur 503 avec un message clair
- L'API ne crash jamais et renvoie toujours du JSON
- Cela permet de tester le frontend même sans configuration Supabase

## Déploiement local

Pour tester en local :

1. Copiez `.env.example` vers `.env`
2. Remplissez les variables Supabase dans `.env`
3. Installez les dépendances : `npm install`
4. Démarrez le serveur : `node server.js`
5. Testez : `http://localhost:3000/api/health`

## Support

En cas de problème :
1. Vérifiez les logs Vercel (Deployments > View Logs)
2. Vérifiez les logs de fonction (Function Logs)
3. Testez l'endpoint `/api/health` pour vérifier que le serveur démarre correctement
4. Consultez la console du navigateur pour les erreurs frontend
