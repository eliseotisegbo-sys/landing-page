// Configuration Supabase — TextileHub
// La clé "publishable" (anon) est publique par conception :
// la sécurité est assurée par les politiques RLS (voir schema-supabase.sql).
const SUPABASE_URL = 'https://svojvnblqxsdrwlxzesk.supabase.co';
const SUPABASE_PUBLISHABLE_KEY = 'sb_publishable_5dcyBKdr8ExQp9y-qA-luQ_veHq26JI';

window.supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY, {
    db: { schema: 'api' } // ce projet Supabase expose le schéma "api"
});
