import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://cnenxmqldembntoseldw.supabase.co/';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNuZW54bXFsZGVtYm50b3NlbGR3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg4Njg2MjEsImV4cCI6MjA1NDQ0NDYyMX0.BTmnCo91GOgTgscRhzh6Tq00VEGpk3B6D7HI2Oarnsw';

export const supabase = createClient(supabaseUrl, supabaseKey);
