import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrl {
  // Get the base URL from the loaded .env file.
  static final String _baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  // Construct the full API endpoints from the base URL.
  static String loginApi = "$_baseUrl/auth/login";
  static String messagesGetApi = "$_baseUrl/messages";
}
