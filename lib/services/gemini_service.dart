import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY no encontrada en el archivo .env');
    }
    _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  }

  /// Envía un mensaje a Gemini y obtiene la respuesta
  Future<String> sendMessage(String message) async {
    try {
      final content = [Content.text(message)];
      final response = await _model.generateContent(content);

      if (response.text != null) {
        return response.text!;
      } else {
        return 'No se pudo obtener una respuesta de Gemini.';
      }
    } catch (e) {
      return 'Error al comunicarse con Gemini: $e';
    }
  }

  /// Envía un mensaje con contexto sobre la aplicación
  Future<String> askAboutApp(String question) async {
    final contextualMessage =
        '''
    Eres un asistente para una aplicación Flutter que simula una pelota con físicas realistas.
    La aplicación tiene:
    - Una pelota que rebota dentro de un círculo
    - Gravedad que afecta el movimiento
    - Colisiones realistas con el borde del círculo
    - Un botón para resetear la pelota
    - Un botón cohete para dar impulso extra a la pelota
    
    Pregunta del usuario: $question
    
    Responde de manera útil y amigable sobre la aplicación.
    ''';

    return await sendMessage(contextualMessage);
  }

  /// Genera consejos sobre física o programación relacionados con la app
  Future<String> getPhysicsTips() async {
    final message = '''
    Dame 3 datos curiosos o consejos sobre física relacionados con simulaciones de pelotas rebotando.
    Hazlo de manera educativa pero divertida.
    ''';

    return await sendMessage(message);
  }

  /// Genera ideas para mejorar la aplicación
  Future<String> getImprovementIdeas() async {
    final message = '''
    Dame 3 ideas creativas para mejorar una aplicación de simulación de física con una pelota que rebota.
    Pueden ser nuevas características, efectos visuales, o mecánicas de juego.
    ''';

    return await sendMessage(message);
  }
}
