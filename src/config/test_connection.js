import {supabase} from "./supabase.js";

async function testConnection() {
    // const { data: user } = await supabase.auth.getUser();
    // let { data, error } = await supabase.auth.signUp({
    //     email: 'someone@email.com',
    //     password: 'CvaNQFrQMgQWqTvXbLwq'
    // })
    let { data } = await supabase.auth.signInWithPassword({
        email: 'admin@example.com',
        password: 'securepassword'
    })
    console.error('User:', data.user);
    // const {data, error} = await supabase
    //     .from('categories')  // Replace 'your_table' with an actual table in your Supabase database
    //     .select('*')
    //     .limit(1);
    //
    // if (error) {
    //     console.error('Error:', error);
    //     process.exit(1);  // Exit with error code
    // } else {
    //     console.log('Connected to Supabase:', data);
    //     process.exit(0);  // Exit with success code
    // }
}

await testConnection();
