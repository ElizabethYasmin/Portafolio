# ✅ Solución CORS sin Servidor Local (100% Gratuita)

## 🎯 Problema Resuelto
Ya no necesitas ejecutar `dart run proxy_server.dart`. Ahora tu app usa un **proxy CORS público gratuito** que funciona automáticamente.

## 🚀 Cómo Usar

### Paso 1: Ejecuta tu app normalmente
```bash
flutter run -d chrome
```

### Paso 2: ¡Listo!
Ya no necesitas hacer nada más. El proxy público se encarga automáticamente.

## 🌐 Opciones de Proxy Público Gratuitos

He configurado tu app con **AllOrigins** (el más confiable), pero aquí están las alternativas:

### 1. **AllOrigins** (Actual - Recomendado) ⭐
- ✅ **Más confiable y rápido**
- ✅ Sin límites estrictos
- ✅ Sin registro necesario
- URL: `https://api.allorigins.win/raw?url=`
- Documentación: https://allorigins.win/

### 2. **CORS Anywhere (Heroku)**
- ⚠️ Requiere "despertar" el servicio primero
- Visita: https://cors-anywhere.herokuapp.com/corsdemo
- Haz clic en "Request temporary access"
- URL: `https://cors-anywhere.herokuapp.com/`

### 3. **ThingProxy**
- ✅ Simple y sin configuración
- ⚠️ Puede ser más lento
- URL: `https://thingproxy.freeboard.io/fetch/`

## 🔄 Cambiar de Proxy

Si quieres probar otro proxy, edita estos archivos:

### 1. Para la API de SUNAT/RENIEC ([api_client.dart:9](lib/core/api/api_client.dart#L9))
```dart
// Cambiar esta línea:
static const String _corsProxyUrl = "https://api.allorigins.win/raw?url=";

// Por una de estas opciones:
static const String _corsProxyUrl = "https://cors-anywhere.herokuapp.com/";
static const String _corsProxyUrl = "https://thingproxy.freeboard.io/fetch/";
```

### 2. Para la API de DECOLECTA ([person_remote_datasource.dart:39](lib/features/reniec/data/datasources/person_remote_datasource.dart#L39))
```dart
// Cambiar esta línea:
const corsProxy = 'https://api.allorigins.win/raw?url=';

// Por otra opción de proxy
```

### 3. Para la API de GitHub ([github_remote_datasource.dart:20](lib/features/github/data/datasources/github_remote_datasource.dart#L20))
```dart
// Cambiar esta línea:
const corsProxy = 'https://api.allorigins.win/raw?url=';

// Por otra opción de proxy
```

## 📊 Comparación de Opciones

| Proxy | Velocidad | Confiabilidad | Límites | Configuración |
|-------|-----------|---------------|---------|---------------|
| **AllOrigins** | ⚡⚡⚡ | ⭐⭐⭐⭐⭐ | Generosos | ✅ Ninguna |
| CORS Anywhere | ⚡⚡ | ⭐⭐⭐ | Sí | ⚠️ Activar cada 12h |
| ThingProxy | ⚡ | ⭐⭐⭐ | Desconocido | ✅ Ninguna |

## ⚠️ Limitaciones de Proxies Públicos

1. **No son para producción**: Estos servicios son para desarrollo/pruebas
2. **Pueden tener downtime**: Al ser gratuitos, pueden estar caídos ocasionalmente
3. **No hay garantía de privacidad**: Los datos pasan por servidores de terceros

## 🎯 Para Producción Real

Si vas a publicar tu portafolio, considera estas opciones:

### Opción A: Backend Gratuito en la Nube

1. **Vercel** (Recomendado para proyectos pequeños)
   - Crea un archivo `api/proxy.js`:
   ```javascript
   export default async function handler(req, res) {
     const { url } = req.query;
     const response = await fetch(url);
     const data = await response.json();
     res.status(200).json(data);
   }
   ```
   - Deploy: `vercel deploy`
   - Actualiza las URLs a: `https://tu-proyecto.vercel.app/api/proxy?url=...`

2. **Cloudflare Workers** (Muy rápido y global)
   ```javascript
   addEventListener('fetch', event => {
     event.respondWith(handleRequest(event.request))
   })

   async function handleRequest(request) {
     const url = new URL(request.url)
     const apiUrl = url.searchParams.get('url')

     const response = await fetch(apiUrl)
     const newResponse = new Response(response.body, response)

     newResponse.headers.set('Access-Control-Allow-Origin', '*')
     return newResponse
   }
   ```

3. **Railway.app** (Backend completo gratis)
   - Sube el archivo `proxy_server.dart` que creé antes
   - Railway lo ejecutará automáticamente
   - Actualiza las URLs en tu app

## 🔧 Troubleshooting

### Error: "Failed to fetch"
- ✅ Verifica tu conexión a internet
- ✅ Prueba con otro proxy de la lista
- ✅ Revisa la consola del navegador para más detalles

### Error: "CORS policy" aún aparece
- ✅ Limpia el caché del navegador (Ctrl + Shift + R)
- ✅ Verifica que estás en modo web (no móvil)
- ✅ Asegúrate de que los cambios se guardaron

### La API responde pero con error 401/403
- ✅ Esto significa que CORS está resuelto
- ⚠️ El problema ahora es el token de la API
- 🔑 Verifica que tu API key sea válida

## ✨ Ventajas de Esta Solución

✅ **Sin instalación** - No necesitas configurar nada local
✅ **Funciona inmediatamente** - Solo ejecuta `flutter run -d chrome`
✅ **Multiplataforma** - En móvil funciona sin proxy (directo)
✅ **Gratis** - No pagas nada
✅ **Sin mantenimiento** - No tienes que mantener un servidor corriendo

## 🎓 Cómo Funciona

```
┌─────────────┐
│ Flutter Web │
│ (Chrome)    │
└──────┬──────┘
       │
       │ https://api.allorigins.win/raw?url=https%3A%2F%2Fapi.decolecta.com%2F...
       ▼
┌──────────────────┐
│  AllOrigins      │ ← Proxy público (sin CORS)
│  (Servidor)      │
└──────┬───────────┘
       │
       │ https://api.decolecta.com/v1/sunat/ruc?numero=...
       ▼
┌──────────────┐
│  API Externa │
└──────────────┘
```

¡Tu app ahora funciona en web sin necesidad de servidor local! 🎉
