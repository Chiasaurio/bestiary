import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiClient {
  static GenerativeModel? _client;

  const GeminiClient._();

  static GenerativeModel get instance {
    _client ??= GenerativeModel(
        model: 'gemini-pro-vision', apiKey: dotenv.env['GEMINI_API_KEY']!);
    return _client!;
  }
}
