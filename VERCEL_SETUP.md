# Configuration Vercel pour TextileHub

Ce guide explique comment configurer correctement le projet TextileHub sur Vercel.

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
2. Formulaire : `https://textilehub-founderoncel.app/candidature.html`

## Résolution des problèmes courants

### Erreur 503 "Service de base de données temporairement indisponible"
- Vérifiez que `SUPABASE_URL` et `SUPABASE_SERVICE_ROLE_KEY` sont correctement configurés
- Vérifiez que la clé est bien la clé `service_role` et pas la clé `anon`

### Erreur RLS (code 42501)
- Vérifiez que vous utilisez bien `SUPABASE_SERVICE_ROLE_KEY`
- La clé `service_role` doit contourner les restrictions RLS

### Erreur CORS
- Vérifiez que `FRONTEND_URL` correspond exactement à votre domaine frontend
- Sans slash final : `https://textilehub-founderoncel.app`

## Architecture du projet

Le projet utilise une architecture unifiée Vercel :
- Frontend (HTML statique) et Backend (server.js) sont déployés ensemble
- Le fichier `vercel.json` configure le rewrite `/api/*` vers `server.js`
- L'URL relative `/api/candidatures` fonctionne car tout est sur le même domaine

## Support

En cas de problème :
1. Vérifiez les logs Vercel (Deployments > View Logs)
2. Vérifiez les logs de fonction (Function Logs)
3. Testez l'endpoint `/api/health` pour vérifier que le serveur démarre correctement
