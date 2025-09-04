# Flutter Hooks Example App

Esta es una aplicación de ejemplo que demuestra el uso del paquete `flutter_hooks` en Flutter.

## 🎯 Propósito

La aplicación muestra diferentes hooks de Flutter que simplifican el manejo de estado y efectos secundarios en widgets funcionales, siguiendo las mejores prácticas de desarrollo descritas en las [Reglas Generales de Codificación](../.github/general-coding.instructions.md).

## 🚀 Hooks Demostrados

### Pantalla Principal (`HooksExampleScreen`)

1. **`useState`** - Manejo de estado local reactivo
   - Contador con botones de incremento y decremento
   - Campo de texto para el nombre

2. **`useTextEditingController`** - Controlador de campos de texto
   - Manejo automático del ciclo de vida del controlador

3. **`useAnimationController`** - Controlador de animaciones
   - Animación de escala y sombra en un ícono
   - Manejo automático del dispose

4. **`useEffect`** - Efectos secundarios
   - Equivalente a `initState` y `dispose`
   - Configuración de animaciones al montar el widget

5. **`useMemoized`** - Memorización de valores calculados
   - Cálculo costoso que solo se recalcula cuando cambia la dependencia

6. **`useCallback`** - Memorización de funciones
   - Funciones optimizadas que evitan recreaciones innecesarias

### Segunda Pantalla (`SecondScreen`)

7. **`usePageController`** - Controlador de páginas
   - Navegación entre diferentes ejemplos

8. **`useScrollController`** - Controlador de scroll
   - Lista scrolleable con elementos

9. **`useFuture`** - Manejo de operaciones asíncronas
   - Simulación de carga de datos del servidor

10. **`useStream`** - Escucha de streams
    - Reloj en tiempo real usando streams

## 📱 Características

- ✅ **Interfaz intuitiva**: Cards organizadas con ejemplos claros
- ✅ **Navegación fluida**: Entre múltiples pantallas de ejemplos
- ✅ **Animaciones**: Demostraciones visuales de los hooks
- ✅ **Tiempo real**: Stream de tiempo actualizado cada segundo
- ✅ **Operaciones asíncronas**: Simulación de carga de datos
- ✅ **Testing**: Pruebas unitarias comprehensivas

## 🛠️ Instalación y Ejecución

### Prerrequisitos
- Flutter SDK (versión 3.9.0 o superior)
- Dart SDK

### Pasos

1. **Navegar al directorio del proyecto:**
   ```bash
   cd flutter_hooks
   ```

2. **Instalar dependencias:**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación:**
   ```bash
   flutter run
   ```

4. **Ejecutar pruebas:**
   ```bash
   flutter test
   ```

## 🏗️ Estructura del Proyecto

```
flutter_hooks/
├── lib/
│   └── main.dart              # Aplicación principal con todos los ejemplos
├── test/
│   └── hooks_test.dart        # Pruebas unitarias
├── pubspec.yaml               # Dependencias del proyecto
└── README.md                  # Este archivo
```

## 📦 Dependencias

- **flutter_hooks**: ^0.20.5 - Paquete principal para hooks
- **flutter**: SDK de Flutter
- **flutter_test**: Para pruebas unitarias

## 🧪 Pruebas

La aplicación incluye pruebas unitarias que verifican:

- ✅ Incremento y decremento del contador
- ✅ Entrada de texto y actualización de saludo
- ✅ Navegación entre pantallas
- ✅ Cálculos memorizados
- ✅ Funcionalidad de todos los hooks

Para ejecutar las pruebas:
```bash
flutter test
```

## 🔍 Conceptos Clave de Flutter Hooks

### ¿Por qué usar Flutter Hooks?

1. **Código más limpio**: Elimina la necesidad de StatefulWidget para lógica simple
2. **Reutilización**: Los hooks personalizados permiten compartir lógica entre widgets
3. **Menos boilerplate**: Menos código repetitivo
4. **Mejor testing**: Más fácil de probar la lógica de estado

### Hooks más Comunes

- `useState` - Para estado local simple
- `useEffect` - Para efectos secundarios y cleanup
- `useMemoized` - Para optimización de rendimiento
- `useCallback` - Para memorizar funciones
- `useFuture` - Para operaciones asíncronas
- `useStream` - Para streams de datos

## 📋 Buenas Prácticas Aplicadas

- **ISG001**: Sin comentarios innecesarios en el código
- **ISG002**: Código optimizado y reutilizable
- **ISG004**: Sin duplicación de código
- **ISG005**: Sin variables o funciones innecesarias
- **ISG011**: Testing comprehensive del código
- **ISG014**: Clases mantenibles (menos de 250 líneas)
- **ISG016**: Sin magic numbers/strings

## 🤝 Contribuciones

Para contribuir a este proyecto, por favor:

1. Sigue las [Reglas Generales de Codificación](../.github/general-coding.instructions.md)
2. Asegúrate de que todas las pruebas pasen
3. Mantén la cobertura de tests mínima del 70%
4. Usa nombres descriptivos para ramas y commits

## 📚 Recursos Adicionales

- [Documentación oficial de flutter_hooks](https://pub.dev/packages/flutter_hooks)
- [React Hooks (inspiración)](https://reactjs.org/docs/hooks-intro.html)
- [Flutter Documentation](https://flutter.dev/docs)
