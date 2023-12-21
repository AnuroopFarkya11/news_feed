import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String apiKey = dotenv.env['API_KEY'] ?? '';
}
