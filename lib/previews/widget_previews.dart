import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import '../screens/gemini_chat_screen.dart';
import '../widgets/physics_widgets.dart';

// Widget Previews para Flutter 3.35.1
// Los Widget Previews funcionan detectando automáticamente funciones Widget
// que retornan widgets válidos para previsualización

/// Widget Previews para Flutter 3.35.1
///
/// Los Widget Previews permiten ver y probar widgets de forma aislada
/// directamente en VS Code sin ejecutar toda la aplicación.
///
/// Para usar estos previews:
/// 1. Abre VS Code con la extensión de Flutter
/// 2. Navega a este archivo
/// 3. Verás botones "Preview" junto a cada función
/// 4. Haz clic para ver el widget en el panel de previews

// =============================================================================
// PREVIEWS DE CHAT COMPONENTS
// =============================================================================

/// Preview de burbuja de chat del usuario
@Preview()
Widget chatBubbleUserPreview() {
  return MaterialApp(
    theme: ThemeData.light(useMaterial3: true),
    home: Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ChatBubble(
            message: ChatMessage(
              text:
                  "Hola! Esta es una burbuja de mensaje de usuario. ¿Puedes ayudarme con la física de la aplicación?",
              isUser: true,
            ),
          ),
        ),
      ),
    ),
  );
}

/// Preview de burbuja de chat de IA
@Preview()
Widget chatBubbleAiPreview() {
  return MaterialApp(
    theme: ThemeData.light(useMaterial3: true),
    home: Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ChatBubble(
            message: ChatMessage(
              text:
                  "¡Hola! Soy Gemini, tu asistente con IA. Puedo ayudarte con física, matemáticas y explicar cómo funciona la simulación de la pelota en tu aplicación.",
              isUser: false,
            ),
          ),
        ),
      ),
    ),
  );
}

/// Preview de conversación completa
@Preview()
Widget chatConversationPreview() {
  return MaterialApp(
    theme: ThemeData.light(useMaterial3: true),
    home: Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChatBubble(
              message: ChatMessage(
                text: "¿Cómo funciona la física en esta app?",
                isUser: true,
              ),
            ),
            ChatBubble(
              message: ChatMessage(
                text:
                    "La aplicación simula física realista con:\n• Gravedad constante\n• Colisiones elásticas\n• Conservación de energía\n• Friction en las colisiones\n\nLa pelota rebota dentro del círculo manteniendo momentum físico real.",
                isUser: false,
              ),
            ),
            ChatBubble(
              message: ChatMessage(
                text: "¡Increíble! ¿Puedo cambiar la gravedad?",
                isUser: true,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Preview con tema oscuro
@Preview()
Widget chatBubbleDarkPreview() {
  return MaterialApp(
    theme: ThemeData.dark(useMaterial3: true),
    home: Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChatBubble(
                message: ChatMessage(
                  text: "Me gusta el tema oscuro",
                  isUser: true,
                ),
              ),
              const SizedBox(height: 16),
              ChatBubble(
                message: ChatMessage(
                  text:
                      "¡El tema oscuro se ve genial! Es más fácil para los ojos, especialmente cuando trabajas por la noche programando.",
                  isUser: false,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// Preview del estado de carga
@Preview()
Widget chatLoadingPreview() {
  return MaterialApp(
    theme: ThemeData.light(useMaterial3: true),
    home: Scaffold(
      backgroundColor: Colors.grey[100],
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 12),
                Text('Gemini está pensando...'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Este es el estado que ve el usuario\nmientras espera la respuesta de IA',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// PREVIEWS DE PHYSICS COMPONENTS
// =============================================================================

/// Preview de pelota de física estática
@Preview()
Widget physicsBallStaticPreview() {
  return MaterialApp(
    theme: ThemeData.light(useMaterial3: true),
    home: Scaffold(
      backgroundColor: Colors.white,
      body: const Center(
        child: PhysicsBall(
          ballX: 200,
          ballY: 150,
          ballRadius: 20,
          containerRadius: 100,
          centerX: 200,
          centerY: 200,
          ballColor: Colors.red,
        ),
      ),
    ),
  );
}

/// Preview de pelota en diferentes posiciones
@Preview()
Widget physicsBallPositionsPreview() {
  return MaterialApp(
    theme: ThemeData.light(useMaterial3: true),
    home: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            PhysicsBall(
              ballX: 150,
              ballY: 150,
              ballRadius: 15,
              containerRadius: 80,
              centerX: 150,
              centerY: 150,
              ballColor: Colors.red,
            ),
            PhysicsBall(
              ballX: 300,
              ballY: 180,
              ballRadius: 15,
              containerRadius: 80,
              centerX: 300,
              centerY: 150,
              ballColor: Colors.blue,
            ),
            PhysicsBall(
              ballX: 450,
              ballY: 120,
              ballRadius: 15,
              containerRadius: 80,
              centerX: 450,
              centerY: 150,
              ballColor: Colors.green,
            ),
          ],
        ),
      ),
    ),
  );
}

/// Preview de estadísticas de física
@Preview()
Widget physicsStatsPreview() {
  return MaterialApp(
    theme: ThemeData.light(useMaterial3: true),
    home: Scaffold(
      backgroundColor: Colors.grey[100],
      body: const Center(
        child: PhysicsStats(
          velocityX: 3.45,
          velocityY: -2.78,
          ballX: 156.7,
          ballY: 234.2,
        ),
      ),
    ),
  );
}

/// Preview de controles de física
@Preview()
Widget physicsControlsPreview() {
  return MaterialApp(
    theme: ThemeData.light(useMaterial3: true),
    home: Scaffold(
      backgroundColor: Colors.grey[100],
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Controles de Física',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            PhysicsControls(),
            SizedBox(height: 20),
            Text(
              'Chat • Reset • Rocket',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// PREVIEWS DE COMPONENTES PERSONALIZADOS
// =============================================================================

/// Widget de tarjeta informativa personalizada
class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const InfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Preview de tarjeta de información simple
@Preview()
Widget infoCardSimplePreview() {
  return MaterialApp(
    theme: ThemeData.light(useMaterial3: true),
    home: Scaffold(
      backgroundColor: Colors.grey[100],
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: InfoCard(
            title: "Física Realista",
            description:
                "Simulación completa con gravedad, colisiones y conservación de energía",
            icon: Icons.science,
            color: Colors.deepPurple,
          ),
        ),
      ),
    ),
  );
}

/// Preview de múltiples tarjetas
@Preview()
Widget infoCardsGridPreview() {
  return MaterialApp(
    theme: ThemeData.light(useMaterial3: true),
    home: Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: const [
            InfoCard(
              title: "Chat IA",
              description: "Asistente inteligente con Gemini",
              icon: Icons.chat_bubble,
              color: Colors.blue,
            ),
            InfoCard(
              title: "Física",
              description: "Simulación realista en tiempo real",
              icon: Icons.science,
              color: Colors.red,
            ),
            InfoCard(
              title: "Gráficos",
              description: "Visualización con fl_chart",
              icon: Icons.bar_chart,
              color: Colors.green,
            ),
            InfoCard(
              title: "Flutter",
              description: "Desarrollo multiplataforma",
              icon: Icons.flutter_dash,
              color: Colors.cyan,
            ),
          ],
        ),
      ),
    ),
  );
}

/// Preview comparativo de temas
@Preview()
Widget themeComparisonPreview() {
  return Row(
    children: [
      Expanded(
        child: MaterialApp(
          theme: ThemeData.light(useMaterial3: true),
          home: Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              title: const Text('Tema Claro'),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ChatBubble(
                message: ChatMessage(
                  text: "Tema claro activado",
                  isUser: false,
                ),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: MaterialApp(
          theme: ThemeData.dark(useMaterial3: true),
          home: Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
              title: const Text('Tema Oscuro'),
              backgroundColor: Colors.grey[800],
              foregroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ChatBubble(
                message: ChatMessage(
                  text: "Tema oscuro activado",
                  isUser: false,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

// Widget personalizado para demostrar previews de componentes simples
class PreviewCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const PreviewCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
