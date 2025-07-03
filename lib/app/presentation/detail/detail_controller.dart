import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';

class DetailController extends GetxController {
  final PokemonEntity pokemon = Get.arguments["pokemon"];
}
