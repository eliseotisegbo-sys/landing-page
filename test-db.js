require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_KEY;

if (!supabaseUrl || !supabaseKey) {
    console.error('❌ Erreur: SUPABASE_URL ou SUPABASE_KEY manquant.');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function testConnection() {
    console.log('🔄 Test de connexion à Supabase en cours...');
    
    // 1. Test de lecture (vérifie si la table existe)
    const { data, error } = await supabase
        .from('candidatures_fondateurs')
        .select('id')
        .limit(1);

    if (error) {
        console.error('❌ La connexion a échoué ou la table n\'existe pas :');
        console.error(error.message);
        console.error('\nAvez-vous exécuté le script supabase_schema.sql dans le tableau de bord Supabase ?');
    } else {
        console.log('✅ Connexion réussie ! La base de données est bien configurée et la table existe.');
        console.log('Données trouvées (1 max):', data);
    }
}

testConnection();
