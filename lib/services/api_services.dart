import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke.dart';

class ApiService {
  static const String baseUrl = "https://official-joke-api.appspot.com";

  // Метод за добивање на рандом шега
  static Future<Joke> fetchRandomJoke() async {
    final url = Uri.parse('https://official-joke-api.appspot.com/random_joke');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Joke.fromJson(data); // Конвертирање во објект од тип Joke
    } else {
      throw Exception('Failed to load random joke');
    }
  }

  // Метод за добивање на типови на шеги
  static Future<List<String>> fetchJokeTypes() async {
    final response = await http.get(Uri.parse('$baseUrl/types'));
    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    } else {
      throw Exception('Не може да се вчитаат типови на шеги');
    }
  }
  static Future<List<Joke>> fetchJokesByType(String type) async {
  final url = Uri.parse('https://official-joke-api.appspot.com/jokes/$type/ten');
  final response = await http.get(url);

  if (response.statusCode == 200) {
  final List<dynamic> data = jsonDecode(response.body);
  return data.map((json) => Joke.fromJson(json)).toList();
  } else {
  throw Exception('Failed to load jokes');
  }
  }
  }
