import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/domain/repositories/get_pokemon_detail_repository.dart';
import 'package:im_mottu_mobile/app/domain/usecases/get_pokemon_detail_usecase.dart';
import 'package:im_mottu_mobile/app/domain/usecases/get_pokemon_usecase.dart';
import 'package:im_mottu_mobile/app/utils/data_manager.dart';

import '../../domain/repositories/get_pokemon_repository.dart';

class GetPokemonDetailUsecase implements IGetPokemonDetailUsecase {
  final IGetPokemonDetailRepository repository;

  GetPokemonDetailUsecase({required this.repository});

  @override
  Future<DataManager<PokemonEntity>> call({required String name}) async {
    return repository(name: name);
  }
}
