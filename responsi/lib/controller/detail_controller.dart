import 'package:get/get.dart';

import '../models/game.dart';
import '../service/game_service.dart';
class DetailController extends GetxController {
  final GameService _gameService = GameService();

  final Rxn<Game> _game = Rxn<Game>();
  final RxBool _isLoading = true.obs;
  final RxString _errorMessage = ''.obs;

  Game? get game => _game.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    final int gameId = Get.arguments as int;
    fetchDetail(gameId);
    super.onInit();
  }

  Future<void> fetchDetail(int id) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      _game.value = await _gameService.fetchGameDetail(id);
    } catch (e) {
      _errorMessage.value = 'Gagal memuat detail.';
    } finally {
      _isLoading.value = false;
    }
  }
}
