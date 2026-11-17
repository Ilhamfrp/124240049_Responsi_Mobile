import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsi/models/library.dart';

import '../../controller/detail_controller.dart';
import '../../controller/library_controller.dart';
// import '../../model/favorite_show.dart';
import '../../models/game.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final DetailController controller = Get.find<DetailController>();
  final LibraryController favController = Get.find<LibraryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator(color: Colors.blue));
        }
        final game = controller.game;
        if (game == null) {
          return Center(child: Text(controller.errorMessage));
        }
        return _buildContent(game);
      }),
    );
  }

  Widget _buildContent(Game game) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: game.thumbnail == null
                  ? const Icon(Icons.movie, size: 120, color: Colors.grey)
                  : Image.network(
                      game.thumbnail!,
                      height: 380,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 80),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            game.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Rilis: ${game.releaseDate}'),
          Text('Publisher: ${game.publisher}'),
          Text('Developer: ${game.developer}'),
          Row(
            children: [
              // const Icon(Icons.star, size: 18, color: Colors.amber),
              // const SizedBox(width: 4),
              // Text(show.ratingText),
            ],
          ),
          const SizedBox(height: 8),
           Text(
          '${game.genres.isEmpty ? '-' : game.genres.join(', ')} • ${game.platform}',
           style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<Box<Library>>(
            valueListenable: Hive.box<Library>('library').listenable(),
            builder: (context, box, child) {
              final isFav = favController.isFavorite(game.id);
              return Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => favController.toggleFavorite(game),
                      icon: Icon(isFav ? Icons.check : Icons.add),
                      label: Text(
                        isFav ? 'Sudah di library' : 'Tambah ke library',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                
                ],
              );
            },
          ),
           const SizedBox(height: 20),
          const Text(
            'Screenshots',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: game.screenshots.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  game.screenshots[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Overview',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(game.description, style: const TextStyle(height: 1.5)),
        ],
      ),
    );
  }
}
