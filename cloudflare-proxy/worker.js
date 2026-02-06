/**
 * Cloudflare Worker - Proxy CORS para Flutter Web
 *
 * Este worker recibe peticiones desde tu app Flutter Web
 * y las reenvía a las APIs externas (decolecta, github, etc.)
 * agregando los headers de autorización y CORS necesarios.
 *
 * Gratis: 100,000 peticiones/día en el plan free.
 */

// Configuración de APIs y sus tokens
const API_CONFIG = {
  '/decolecta': {
    baseUrl: 'https://api.decolecta.com',
    headers: {
      'Authorization': 'Bearer sk_12091.ydBsh4Xhx0XBODzTTjVvrNFAtGzZB3x8',
      'Content-Type': 'application/json',
    },
  },
  '/apisnet': {
    baseUrl: 'https://api.apis.net.pe/v2',
    headers: {
      'Authorization': 'Bearer apis-token-13256.AaMuj87c8DJO6III6YDgTey6lunnM8jk',
      'Accept': 'application/json',
    },
  },
  '/github': {
    baseUrl: 'https://api.github.com',
    headers: {
      'Accept': 'application/vnd.github.v3+json',
      'User-Agent': 'Flutter-Portfolio-App',
    },
  },
};

// Headers CORS que se agregan a todas las respuestas
const CORS_HEADERS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization, Accept',
  'Access-Control-Max-Age': '86400',
};

export default {
  async fetch(request) {
    // Manejar preflight (OPTIONS)
    if (request.method === 'OPTIONS') {
      return new Response(null, { status: 204, headers: CORS_HEADERS });
    }

    const url = new URL(request.url);
    const path = url.pathname;

    // Ruta raíz: mostrar info del proxy
    if (path === '/' || path === '') {
      return new Response(
        JSON.stringify({
          status: 'ok',
          message: 'Proxy CORS activo',
          endpoints: {
            '/decolecta/*': 'API de Decolecta (SUNAT/RENIEC)',
            '/apisnet/*': 'API de apis.net.pe',
            '/github/*': 'API de GitHub',
          },
          example: '/decolecta/v1/sunat/ruc?numero=10722530921',
        }),
        {
          headers: { ...CORS_HEADERS, 'Content-Type': 'application/json' },
        }
      );
    }

    // Buscar la configuración de API que corresponde
    let matchedPrefix = null;
    let config = null;

    for (const [prefix, cfg] of Object.entries(API_CONFIG)) {
      if (path.startsWith(prefix)) {
        matchedPrefix = prefix;
        config = cfg;
        break;
      }
    }

    if (!config) {
      return new Response(
        JSON.stringify({
          error: 'Ruta no encontrada',
          message: `Use uno de estos prefijos: ${Object.keys(API_CONFIG).join(', ')}`,
        }),
        {
          status: 404,
          headers: { ...CORS_HEADERS, 'Content-Type': 'application/json' },
        }
      );
    }

    // Construir la URL de destino
    const apiPath = path.substring(matchedPrefix.length);
    const queryString = url.search;
    const targetUrl = `${config.baseUrl}${apiPath}${queryString}`;

    try {
      // Hacer la petición a la API real
      const apiResponse = await fetch(targetUrl, {
        method: request.method,
        headers: config.headers,
      });

      // Leer la respuesta
      const responseBody = await apiResponse.text();

      // Devolver la respuesta con headers CORS
      return new Response(responseBody, {
        status: apiResponse.status,
        headers: {
          ...CORS_HEADERS,
          'Content-Type': apiResponse.headers.get('Content-Type') || 'application/json',
        },
      });
    } catch (error) {
      return new Response(
        JSON.stringify({
          error: 'Error en el proxy',
          message: error.message,
          targetUrl: targetUrl,
        }),
        {
          status: 500,
          headers: { ...CORS_HEADERS, 'Content-Type': 'application/json' },
        }
      );
    }
  },
};
