import 'package:flutter/material.dart';
import 'dart:math' as math;

// Widget personalizado para mostrar la pelota de física
class PhysicsBall extends StatelessWidget {
  final double ballX;
  final double ballY;
  final double ballRadius;
  final double containerRadius;
  final double centerX;
  final double centerY;
  final Color ballColor;

  const PhysicsBall({
    super.key,
    required this.ballX,
    required this.ballY,
    this.ballRadius = 20.0,
    this.containerRadius = 150.0,
    this.centerX = 200.0,
    this.centerY = 200.0,
    this.ballColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        (centerX + containerRadius) * 2,
        (centerY + containerRadius) * 2,
      ),
      painter: BallPainter(
        ballX: ballX,
        ballY: ballY,
        ballRadius: ballRadius,
        containerRadius: containerRadius,
        centerX: centerX,
        centerY: centerY,
        ballColor: ballColor,
      ),
    );
  }
}

class BallPainter extends CustomPainter {
  final double ballX;
  final double ballY;
  final double ballRadius;
  final double containerRadius;
  final double centerX;
  final double centerY;
  final Color ballColor;

  BallPainter({
    required this.ballX,
    required this.ballY,
    required this.ballRadius,
    required this.containerRadius,
    required this.centerX,
    required this.centerY,
    required this.ballColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Dibujar el círculo contenedor
    canvas.drawCircle(Offset(centerX, centerY), containerRadius, paint);

    // Dibujar la pelota
    final ballPaint = Paint()
      ..color = ballColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(ballX, ballY), ballRadius, ballPaint);

    // Agregar brillo a la pelota
    final shinePaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(ballX - ballRadius * 0.3, ballY - ballRadius * 0.3),
      ballRadius * 0.3,
      shinePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Widget para mostrar estadísticas de física
class PhysicsStats extends StatelessWidget {
  final double velocityX;
  final double velocityY;
  final double ballX;
  final double ballY;

  const PhysicsStats({
    super.key,
    required this.velocityX,
    required this.velocityY,
    required this.ballX,
    required this.ballY,
  });

  @override
  Widget build(BuildContext context) {
    final speed = math.sqrt(velocityX * velocityX + velocityY * velocityY);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Estadísticas de Física',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildStatRow('Posición X', ballX.toStringAsFixed(1)),
            _buildStatRow('Posición Y', ballY.toStringAsFixed(1)),
            _buildStatRow('Velocidad X', velocityX.toStringAsFixed(2)),
            _buildStatRow('Velocidad Y', velocityY.toStringAsFixed(2)),
            _buildStatRow('Velocidad Total', speed.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Widget para controles de física
class PhysicsControls extends StatelessWidget {
  final VoidCallback? onReset;
  final VoidCallback? onRocket;
  final VoidCallback? onChat;

  const PhysicsControls({super.key, this.onReset, this.onRocket, this.onChat});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          onPressed: onChat,
          heroTag: "chat",
          backgroundColor: Colors.blue,
          child: const Icon(Icons.chat, color: Colors.white),
        ),
        FloatingActionButton(
          onPressed: onReset,
          heroTag: "reset",
          backgroundColor: Colors.orange,
          child: const Icon(Icons.refresh, color: Colors.white),
        ),
        FloatingActionButton(
          onPressed: onRocket,
          heroTag: "rocket",
          backgroundColor: Colors.red,
          child: const Icon(Icons.rocket_launch, color: Colors.white),
        ),
      ],
    );
  }
}
