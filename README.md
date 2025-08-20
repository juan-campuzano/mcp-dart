# Aplicación Flutter con Gemini AI y Widget Previews

Esta aplicación combina una simulación de física con una pelota rebotando y un chat inteligente powered by Google Gemini. Actualizada para Flutter 3.35.1 con soporte completo para Widget Previews.

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

### Widget Previews ✨ (Nuevo en 3.35.1)
- Previsualización de widgets en VS Code
- Desarrollo de UI más rápido
- Componentes aislados para testing
- Múltiples estados y temas

## 🚀 Configuración

### Variables de Entorno (.env)
1. **Crea el archivo .env:**
   ```bash
   cp .env.example .env
   ```

2. **Configura tu API Key de Gemini:**
   - Ve a [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Crea una nueva API key
   - Agrega tu API key al archivo `.env`:
   ```
   GEMINI_API_KEY=tu_api_key_aqui
   ```

### Widget Previews
- Asegúrate de tener Flutter 3.35.1 o superior
- VS Code con extensión de Flutter actualizada
- Configuración automática incluida en `.vscode/settings.json`

## 📱 Cómo usar

### 1. Simulación de Física
- La pelota rebota automáticamente
- Usa el botón 🔄 para resetear
- Usa el botón 🚀 para dar impulso extra

### 2. Chat con Gemini
- Toca el botón azul 💬 para abrir el chat
- Haz preguntas sobre la app, física, o cualquier cosa
- Usa el menú ⋮ para consejos de física o ideas de mejora

### 3. Widget Previews
- Abre `lib/previews/widget_previews.dart` en VS Code
- Haz clic en "Preview" junto a cualquier función
- Ve los widgets en el panel lateral
- Experimenta con diferentes estados y temas

## 🛠️ Instalación

```bash
# Instalar dependencias
flutter pub get

# Ejecutar la aplicación
flutter run
```

## 📦 Dependencias

- `fl_chart`: ^1.0.0 - Gráficos personalizables
- `google_generative_ai`: ^0.4.6 - Integración con Gemini AI
- `flutter_dotenv`: ^5.1.0 - Gestión segura de variables de entorno

## 🎨 Widget Previews Disponibles

### Chat Components
- Burbujas de chat (usuario y IA)
- Conversaciones completas
- Estados de carga
- Temas claro y oscuro

### Physics Components
- Pelota en diferentes posiciones
- Estadísticas de física en tiempo real
- Controles de la aplicación

### Custom Components
- Tarjetas informativas
- Grids de componentes
- Comparaciones de temas

Ver documentación completa en [WIDGET_PREVIEWS.md](WIDGET_PREVIEWS.md)

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                    # Aplicación principal con física
├── screens/
│   └── gemini_chat_screen.dart  # Pantalla de chat con IA
├── services/
│   └── gemini_service.dart      # Servicio de Gemini AI
├── widgets/
│   └── physics_widgets.dart     # Widgets de física reutilizables
└── previews/
    └── widget_previews.dart     # Widget Previews para desarrollo
```

## ⚠️ Importante

### Seguridad
- ✅ API key se carga desde archivo `.env`
- ✅ Archivo `.env` está en `.gitignore`
- ⚠️ **NUNCA** incluyas la API key en el código fuente
- ⚠️ **NUNCA** hagas commit del archivo `.env`

### Desarrollo
- Usa Widget Previews para desarrollo de UI más rápido
- Los previews no requieren la API key de Gemini
- Componentes aislados facilitan debugging

## 🔧 Comandos útiles

```bash
# Análisis del código
flutter analyze

# Formatear código
flutter format .

# Ejecutar tests
flutter test

# Build para producción
flutter build apk  # Android
flutter build ios  # iOS
```

## 🚀 Características técnicas

- **Flutter 3.35.1**: Última versión con Widget Previews
- **Material 3**: Diseño moderno y consistente
- **Física realista**: Matemáticas precisas para colisiones
- **IA conversacional**: Integración completa con Gemini
- **Desarrollo acelerado**: Widget Previews para UI
- **Seguridad**: Variables de entorno protegidas