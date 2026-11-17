import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/game.dart';
class GameService {
  final String _baseUrl = 'https://www.freetogame.com/api';
  Future<List<Game>> fetchGames() async {
    final response = await http.get(Uri.parse('$_baseUrl/games'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Game.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load games');
    }
  }
  Future<Game> fetchGameDetail(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/game?id=$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Game.fromJson(data);
    } else {
      throw Exception('Failed to load game detail');
    }
  }
}
