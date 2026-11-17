import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/game_contoller.dart';
import '../../route/app_rute.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final GameController controller = Get.find<GameController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hydra Games!')),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator(color: Colors.blue));
        }
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(controller.errorMessage),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(140, 44),
                  ),
                  onPressed: controller.retrieveData,
                  child: const Text('Coba lagi'),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: controller.games.length,
          itemBuilder: (context, index) {
            final game = controller.games[index];
            return ListTile(
              onTap: () => Get.toNamed(AppRoutes.detail, arguments: game.id),
              leading: game.thumbnail == null
                  ? const Icon(Icons.videogame_asset, size: 50)
                  : Image.network(
                      game.thumbnail!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
              title: Text(game.title),
              subtitle: Text(
                '${game.genres.isEmpty ? '-' : game.genres.join(', ')}\n${game.platform}',
              ),
              isThreeLine: true,
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54),
            );
          },
        );
      }),
    );
  }
}
