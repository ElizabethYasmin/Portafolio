# Solución al Problema de CORS en Flutter Web

## 🔴 El Problema
Cuando ejecutas la app en **Flutter Web**, las peticiones a APIs externas son bloqueadas por la política CORS del navegador:
```
Access to fetch at 'https://api.decolecta.com/...' has been blocked by CORS policy
```

## ✅ La Solución

### Paso 1: Ejecutar el Servidor Proxy (DESARROLLO)

Antes de ejecutar tu app en web, abre una **nueva terminal** y ejecuta:

```bash
dart run proxy_server.dart
```

Deberías ver:
```
🚀 Proxy server ejecutándose en http://localhost:8080
📡 Redirigiendo peticiones a las APIs externas
⚠️  Solo para desarrollo - NO usar en producción
```

### Paso 2: Ejecutar Flutter Web

En otra terminal, ejecuta tu app normalmente:

```bash
flutter run -d chrome
```

### Paso 3: ¡Listo!

Ahora las peticiones funcionarán:
- **En Web**: Las peticiones van a `http://localhost:8080` → Proxy → API externa
- **En Móvil/Desktop**: Las peticiones van directamente a la API (sin proxy)

## 🎯 Cómo Funciona

```
┌─────────────┐
│ Flutter Web │
│ (Chrome)    │
└──────┬──────┘
       │
       │ http://localhost:8080/sunat/ruc?numero=...
       ▼
┌──────────────┐
│ Proxy Server │ ← NO tiene restricciones CORS
│ (Dart)       │
└──────┬───────┘
       │
       │ https://api.apis.net.pe/v2/sunat/ruc?numero=...
       │ + Authorization: Bearer token
       ▼
┌──────────────┐
│  API Externa │
└──────────────┘
```

## 📝 Notas Importantes

1. **Solo para desarrollo**: Este proxy es para desarrollo local. En producción necesitarás un backend real.

2. **El proxy debe estar corriendo**: Si ves errores de conexión en web, verifica que `dart run proxy_server.dart` esté ejecutándose.

3. **Plataformas móviles**: En Android/iOS el proxy NO se usa, las peticiones van directamente a la API.

## 🚀 Solución para Producción

Para producción, necesitarás:

1. **Backend real** (Node.js, Python, Go, etc.)
2. **Desplegar en un servidor** (Heroku, Vercel, Railway, etc.)
3. **Actualizar la URL del proxy** en `ApiClient`:
   ```dart
   static const String _baseUrlProxy = "https://tu-backend.com";
   ```

## 🔧 Troubleshooting

### Error: "Connection refused"
- ✅ Verifica que el proxy esté corriendo (`dart run proxy_server.dart`)
- ✅ Verifica que el puerto 8080 esté libre

### Error: "Endpoint no soportado"
- ✅ Asegúrate de que tu endpoint comience con `/sunat/` o `/github/`

### Funciona en móvil pero no en web
- ✅ Esto es normal - ejecuta el proxy para web
