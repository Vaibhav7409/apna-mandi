import 'dart:convert';
import 'package:http/http.dart' as http;

class MandiService {
  // Replace with the actual API URL from data.gov.in
  final String apiUrl = 'https://api.data.gov.in/resource/YOUR_RESOURCE_ID';
  final String apiKey = 'YOUR_API_KEY'; // Add your API key here

  Future<List<dynamic>> fetchMandiPrices(String location) async {
    final response = await http.get(
      Uri.parse('$apiUrl?api-key=$apiKey&format=json&filters[location]=$location'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['records']; // Adjust based on API response format
    } else {
      throw Exception('Failed to load mandi prices');
    }
  }
}
