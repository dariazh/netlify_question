import {supabase} from '../config/supabase';

export const tagController = {
  async getTags(request, reply) {
    await supabase.auth.signInWithPassword({
      email: 'admin@example.com',
      password: 'securepassword'
    })

    try {
      const { data, error } = await supabase
        .from('tags')
        .select('*')
        .order('name');
      if (error) throw error;
      return reply.send(data);
    } catch (error) {
      return reply.status(500).send({ error: 'Internal Server Error' });
    }
  }
};
