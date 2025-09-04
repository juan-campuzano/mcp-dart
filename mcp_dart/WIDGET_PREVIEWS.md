# Widget Previews en Flutter 3.35.1

Este proyecto está configurado para usar las nuevas funcionalidades de Widget Previews disponibles en Flutter 3.35.1.

## ¿Qué son los Widget Previews?

Los Widget Previews te permiten ver y probar widgets individuales directamente en VS Code sin necesidad de ejecutar toda la aplicación. Es especialmente útil para:

- Desarrollar y probar componentes de UI de forma aislada
- Ver diferentes estados de un widget
- Comparar variaciones de diseño
- Acelerar el proceso de desarrollo de UI

## Cómo usar Widget Previews

### 1. Requisitos previos
- Flutter 3.35.1 o superior
- VS Code con extensión de Flutter actualizada
- Configuración habilitada en `.vscode/settings.json`

### 2. Visualizar previews
1. Abre el archivo `lib/previews/widget_previews.dart`
2. Verás botones "Preview" junto a cada función de widget
3. Haz clic en "Preview" para ver el widget en el panel lateral

### 3. Previews disponibles en este proyecto

#### Componentes de Chat
- `chatBubbleUserPreview()` - Burbuja de mensaje del usuario
- `chatBubbleAiPreview()` - Burbuja de respuesta de IA
- `chatConversationPreview()` - Conversación completa
- `chatBubbleDarkPreview()` - Tema oscuro
- `chatLoadingPreview()` - Estado de carga

#### Componentes de Física
- `physicsBallStaticPreview()` - Pelota estática
- `physicsBallPositionsPreview()` - Múltiples posiciones
- `physicsStatsPreview()` - Estadísticas de física
- `physicsControlsPreview()` - Controles de la aplicación

#### Componentes Personalizados
- `infoCardSimplePreview()` - Tarjeta informativa
- `infoCardsGridPreview()` - Grid de tarjetas
- `themeComparisonPreview()` - Comparación de temas

## Ventajas de Widget Previews

### 🚀 Desarrollo más rápido
- No necesitas ejecutar toda la app para ver un widget
- Cambios instantáneos en el preview
- Múltiples widgets visibles simultáneamente

### 🎨 Mejor diseño
- Fácil comparación de variaciones
- Prueba de diferentes estados
- Visualización de temas claro/oscuro

### 🐛 Debugging mejorado
- Aislamiento de componentes problemáticos
- Estados específicos fáciles de reproducir
- Menos complejidad en el debugging

## Estructura de archivos

```
lib/
├── previews/
│   └── widget_previews.dart     # Todos los previews
├── widgets/
│   └── physics_widgets.dart     # Widgets de física
├── screens/
│   └── gemini_chat_screen.dart  # Pantalla de chat
└── main.dart                    # App principal
```

## Configuración de VS Code

El archivo `.vscode/settings.json` incluye:
- Habilitación de Flutter UI Guides
- Formato automático
- Configuraciones optimizadas para Dart
- Colores personalizados para mejor visualización

## Consejos para crear buenos previews

### 1. Nombres descriptivos
```dart
Widget chatBubbleUserPreview() {  // ✅ Claro y descriptivo
Widget preview1() {               // ❌ No descriptivo
```

### 2. Estados representativos
```dart
// ✅ Muestra el widget en diferentes estados
Widget buttonEnabledPreview() { ... }
Widget buttonDisabledPreview() { ... }
Widget buttonLoadingPreview() { ... }
```

### 3. Contexto mínimo necesario
```dart
// ✅ Solo lo necesario para el preview
Widget cardPreview() {
  return MaterialApp(
    theme: ThemeData.light(),
    home: Scaffold(
      body: Center(child: MyCard()),
    ),
  );
}
```

### 4. Datos de ejemplo realistas
```dart
// ✅ Datos que representan uso real
ChatMessage(
  text: "Esta es una pregunta típica del usuario sobre física",
  isUser: true,
)

// ❌ Datos no representativos
ChatMessage(text: "test", isUser: true)
```

## Próximos pasos

1. **Experimenta**: Modifica los previews existentes para ver cambios en tiempo real
2. **Crea nuevos**: Agrega previews para tus propios widgets
3. **Comparte**: Los previews ayudan a otros desarrolladores a entender tu código
4. **Documenta**: Usa comentarios para explicar casos de uso específicos

## Recursos adicionales

- [Documentación oficial de Flutter Widget Previews](https://docs.flutter.dev/tools/vs-code#widget-previews)
- [VS Code Flutter Extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
- [Flutter 3.35.1 Release Notes](https://docs.flutter.dev/release/release-notes)

---

¡Disfruta desarrollando con Widget Previews! 🚀
