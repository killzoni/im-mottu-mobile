import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/utils/data_manager.dart';

abstract class IGetPokemonUsecase {
  Future<DataManager<List<PokemonEntity>>> call({
    required int limit,
    required int offset,
  });
}