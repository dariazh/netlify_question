import {tagController} from '../controllers/tags.js';

export async function registerRoutes(fastify) {
  fastify.get('/tags', tagController.getTags);
}
