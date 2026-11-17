import 'package:get/get.dart';
import 'package:responsi/controller/game_contoller.dart';

import '../controller/detail_controller.dart';
import '../controller/library_controller.dart';
import '../controller/game_contoller.dart';
import '../view/detail_page.dart';
import '../view/login_page.dart';
import '../view/main_page.dart';
import 'app_rute.dart';
class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameController>(() => GameController());
    Get.lazyPut<LibraryController>(() => LibraryController());
  }
}
class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController());
  }
}
class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.detail,
      page: () => DetailPage(),
      binding: DetailBinding(),
    ),
  ];
}
