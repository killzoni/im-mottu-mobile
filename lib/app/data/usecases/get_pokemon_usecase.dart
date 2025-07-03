import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/domain/usecases/get_pokemon_usecase.dart';
import 'package:im_mottu_mobile/app/utils/data_manager.dart';

import '../../domain/repositories/get_pokemon_repository.dart';

class GetPokemonUsecase implements IGetPokemonUsecase {
  final IGetPokemonRepository repository;

  GetPokemonUsecase({required this.repository});

  @override
  Future<DataManager<List<PokemonEntity>>> call() async {
    return repository();
  }
}
