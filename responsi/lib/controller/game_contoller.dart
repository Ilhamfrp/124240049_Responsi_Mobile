import 'package:get/get.dart';

import '../models/game.dart';
import '../service/game_service.dart';
class GameController extends GetxController {
  final GameService _gameService = GameService();
  final RxList<Game> _games = <Game>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  List<Game> get games => _games;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  @override
  void onInit() {
    retrieveData();
    super.onInit();
  }
  Future<void> retrieveData() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final data = await _gameService.fetchGames();
      _games.assignAll(data);
    } catch (e) {
      _errorMessage.value = 'Gagal memuat game. Cek koneksi internet kamu.';
    } finally {
      _isLoading.value = false;
    }
  }
}
