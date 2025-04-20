import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class ChatbotService {
  final String apiKey =
      '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'; // Replace with your API key
  final String apiUrl = 'https://openrouter.ai/api/v1/chat/completions';
  final String siteUrl = '<YOUR_SITE_URL>'; // Replace with your site URL
  final String siteName = '<YOUR_SITE_NAME>'; // Replace with your site name

  // Create a logger instance for this class
  final Logger _logger = Logger('ChatbotService');

  Future<String> sendMessage(String message) async {
    final url = Uri.parse(apiUrl);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
      'HTTP-Referer': siteUrl,
      'X-Title': siteName,
    };

    final body = jsonEncode({
      'model': 'deepseek/deepseek-r1:free',
      'messages': [
        {'role': 'user', 'content': message}
      ],
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        _logger.warning('API Error: ${response.statusCode}, ${response.body}');
        return 'Error: ${response.statusCode}'; // Or handle the error as you see fit
      }
    } catch (e) {
      _logger.severe('Network Error: $e');
      return 'Network Error: $e';
    }
  }
}
