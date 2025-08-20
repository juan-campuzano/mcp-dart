import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hola a todos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BallPhysicsScreen(),
    );
  }
}

class BallPhysicsScreen extends StatefulWidget {
  const BallPhysicsScreen({super.key});

  @override
  State<BallPhysicsScreen> createState() => _BallPhysicsScreenState();
}

class _BallPhysicsScreenState extends State<BallPhysicsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  // Propiedades de la pelota
  double ballX = 200.0;
  double ballY = 200.0;
  double velocityX = 3.0;
  double velocityY = 2.0;
  final double ballRadius = 20.0;

  // Propiedades del círculo contenedor
  final double containerRadius = 150.0;
  double centerX = 200.0; // Valor inicial por defecto
  double centerY = 200.0; // Valor inicial por defecto

  // Físicas
  final double gravity = 0.2;
  final double friction = 0.98;
  final double restitution = 0.8; // Coeficiente de rebote

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _animationController.addListener(_updateBallPosition);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateBallPosition() {
    // Solo actualizar si tenemos las dimensiones de la pantalla
    if (centerX == 200.0 && centerY == 200.0) return;

    setState(() {
      // Aplicar gravedad
      velocityY += gravity;

      // Actualizar posición
      ballX += velocityX;
      ballY += velocityY;

      // Calcular distancia desde el centro del círculo contenedor
      double dx = ballX - centerX;
      double dy = ballY - centerY;
      double distance = math.sqrt(dx * dx + dy * dy);

      // Verificar colisión con el círculo contenedor
      if (distance + ballRadius >= containerRadius) {
        // Calcular el ángulo de colisión
        double angle = math.atan2(dy, dx);

        // Posicionar la pelota justo dentro del círculo
        ballX = centerX + (containerRadius - ballRadius) * math.cos(angle);
        ballY = centerY + (containerRadius - ballRadius) * math.sin(angle);

        // Calcular la velocidad normal y tangencial
        double normalX = math.cos(angle);
        double normalY = math.sin(angle);

        // Velocidad normal (componente hacia el centro)
        double normalVelocity = velocityX * normalX + velocityY * normalY;

        // Reflejar la velocidad normal
        velocityX -= 2 * normalVelocity * normalX * restitution;
        velocityY -= 2 * normalVelocity * normalY * restitution;

        // Aplicar fricción
        velocityX *= friction;
        velocityY *= friction;
      }
    });
  }

  void _resetBall() {
    // Solo resetear si tenemos las dimensiones de la pantalla
    if (centerX == 200.0 && centerY == 200.0) return;

    setState(() {
      ballX = centerX;
      ballY = centerY - 50;
      velocityX = (math.Random().nextDouble() - 0.5) * 6;
      velocityY = math.Random().nextDouble() * 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Hola a todos'),
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calcular el centro de la pantalla
          final newCenterX = constraints.maxWidth / 2;
          final newCenterY = constraints.maxHeight / 2;

          // Inicializar la posición de la pelota la primera vez
          if (centerX == 200.0 && centerY == 200.0) {
            centerX = newCenterX;
            centerY = newCenterY;
            ballX = centerX;
            ballY = centerY - 50;
          } else {
            centerX = newCenterX;
            centerY = newCenterY;
          }

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1e3c72), Color(0xFF2a5298)],
              ),
            ),
            child: CustomPaint(
              painter: BallPhysicsPainter(
                ballX: ballX,
                ballY: ballY,
                ballRadius: ballRadius,
                centerX: centerX,
                centerY: centerY,
                containerRadius: containerRadius,
              ),
              size: Size(constraints.maxWidth, constraints.maxHeight),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _resetBall,
            heroTag: "reset",
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                velocityX += (math.Random().nextDouble() - 0.5) * 12;
                velocityY -= math.Random().nextDouble() * 10;
              });
            },
            heroTag: "impulse",
            child: const Icon(Icons.rocket_launch),
          ),
        ],
      ),
    );
  }
}

class BallPhysicsPainter extends CustomPainter {
  final double ballX;
  final double ballY;
  final double ballRadius;
  final double centerX;
  final double centerY;
  final double containerRadius;

  BallPhysicsPainter({
    required this.ballX,
    required this.ballY,
    required this.ballRadius,
    required this.centerX,
    required this.centerY,
    required this.containerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Dibujar el círculo contenedor
    paint
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawCircle(Offset(centerX, centerY), containerRadius, paint);

    // Dibujar sombra del círculo contenedor
    paint
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(centerX, centerY), containerRadius, paint);

    // Dibujar sombra de la pelota
    paint
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(ballX + 2, ballY + 2), ballRadius, paint);

    // Dibujar la pelota con gradiente
    final ballGradient = RadialGradient(
      center: const Alignment(-0.3, -0.3),
      radius: 0.8,
      colors: [
        Colors.orange.shade300,
        Colors.red.shade600,
        Colors.red.shade800,
      ],
    );

    paint
      ..shader = ballGradient.createShader(
        Rect.fromCircle(center: Offset(ballX, ballY), radius: ballRadius),
      )
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(ballX, ballY), ballRadius, paint);

    // Dibujar brillo en la pelota
    paint
      ..shader = null
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(ballX - ballRadius * 0.3, ballY - ballRadius * 0.3),
      ballRadius * 0.3,
      paint,
    );

    // Dibujar centro del círculo contenedor
    paint
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(centerX, centerY), 3.0, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
