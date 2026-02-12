// EN LA CONFIGURACIÓN DE TU WORKER, USA:

const API_CONFIG = {
  '/decolecta': {
    baseUrl: 'https://api.decolecta.com',
    headers: {
      // ✅ LEE DEL ENVIRONMENT, no del código
      'Authorization': `Bearer ${env.DECOLECTA_API_KEY}`,
      'Content-Type': 'application/json',
    },
  },
  '/apisnet': {
    baseUrl: 'https://api.apis.net.pe/v2',
    headers: {
      // ✅ LEE DEL ENVIRONMENT
      'Authorization': `Bearer ${env.APISNET_TOKEN}`,
      'Accept': 'application/json',
    },
  },
  // ... resto
};

export default {
  // ✅ IMPORTANTE: Recibir env como parámetro
  async fetch(request, env, ctx) {
    // Ahora API_CONFIG tiene acceso a env
    const config = API_CONFIG[prefix]; // Esto NO funcionará directamente