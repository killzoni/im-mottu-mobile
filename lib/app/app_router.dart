import 'package:get/get.dart';

abstract class AppRouter {
  static const String home = "/home";
  static const String detail = "/detail";

  Future<T> goToHome<T>() async {
    return await Get.toNamed(home);
  }

  Future<T> goToDetail<T>() async {
    return await Get.toNamed(detail);
  }
}
