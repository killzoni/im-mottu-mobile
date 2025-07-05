import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';

abstract class AppRouter {
  static const String splash = "/splash";
  static const String home = "/home";
  static const String detail = "/detail";

  static Future<T> goToSplash<T>() async {
    return await Get.toNamed(splash);
  }

  static Future<T> goToHome<T>() async {
    return await Get.offAndToNamed(home);
  }

  static Future<T> goToDetail<T>(PokemonEntity pokemon) async {
    return await Get.toNamed(
      detail,
      arguments: {
        "pokemon": pokemon,
      },
    );
  }
}
