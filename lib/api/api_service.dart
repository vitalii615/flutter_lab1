import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_project_lab1/api/models_league_standings.dart'; 

class FootballApiService {
  static const String _baseUrl = 'https://api.football-data.org/v4';
  static const String _apiKey = '2f8087e110c1427aaeb2db1c94183b46';

  static Future<TableLigaChempions> fetchStandings() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/competitions/CL/standings'),
      headers: {
        'X-Auth-Token': _apiKey,
      },
    );

    if (response.statusCode == 200) {
      // Парс JSON і передача в модель TableLigaChempions
      final Map<String, dynamic> data = json.decode(response.body) as Map<String, dynamic>;
      return TableLigaChempions.fromJson(data);
    } else {
      // Якщо помилка, кидаємо виключення
      throw Exception('Failed to load standings: ${response.statusCode}');
    }
  }
}
