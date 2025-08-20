# Aplicación Flutter con Gemini AI

Esta aplicación combina una simulación de física con una pelota rebotando y un chat inteligente powered by Google Gemini.

## 🏀 Características

### Simulación de Física
- Pelota con físicas realistas
- Gravedad y colisiones
- Rebotes dentro de un círculo contenedor
- Botón para resetear la pelota
- Botón cohete para impulso extra

### Chat con Gemini AI 🤖
- Asistente inteligente integrado
- Preguntas sobre la aplicación
- Consejos de física
- Ideas para mejorar la app

## 🚀 Configuración de Gemini

1. **Obtén tu API Key de Gemini:**
   - Ve a [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Crea una nueva API key
   - Cópiala para usarla en la app

2. **Configura la API Key:**
   - Abre `lib/services/gemini_service.dart`
   - Reemplaza `'YOUR_API_KEY_HERE'` con tu API key real:
   ```dart
   static const String _apiKey = 'tu_api_key_aqui';
   ```

## 📱 Cómo usar

1. **Simulación de Física:**
   - La pelota rebota automáticamente
   - Usa el botón 🔄 para resetear
   - Usa el botón 🚀 para dar impulso

2. **Chat con Gemini:**
   - Toca el botón morado 🤖 para abrir el chat
   - Haz preguntas sobre la app, física, o cualquier cosa
   - Usa el menú ⋮ para consejos de física o ideas de mejora

## 🛠️ Instalación

```bash
# Instalar dependencias
flutter pub get

# Ejecutar la aplicación
flutter run
```

## 📦 Dependencias

- `fl_chart`: Gráficos personalizables
- `google_generative_ai`: Integración con Gemini AI

## ⚠️ Importante

- Necesitas una API key válida de Gemini para usar el chat
- La API key debe mantenerse secreta y no incluirse en el código fuente