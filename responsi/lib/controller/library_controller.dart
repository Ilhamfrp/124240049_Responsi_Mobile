import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/library.dart';
import '../models/game.dart';
class LibraryController extends GetxController {
  Box<Library> get _box => Hive.box<Library>('library');
  bool isFavorite(int id) => _box.values.any((fav) => fav.id == id);
  Future<void> toggleFavorite(Game game) async {
    final index = _box.values.toList().indexWhere((fav) => fav.id == game.id);

    if (index == -1) {
      await _box.add(
        Library(
          id: game.id,
          name: game.title,
          image: game.thumbnail,
          rating: game.ratingText,
        ),
      );
      Get.snackbar('library', '${game.title} ditambahkan ke library',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      await _box.deleteAt(index);
      Get.snackbar('library', '${game.title} dihapus dari library',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
  Future<void> removeAt(int index) async {
    await _box.deleteAt(index);
  }
}
