import 'package:dio/dio.dart';
import 'package:im_mottu_mobile/app/data/datasource/get_pokemon_detail_datasource.dart';
import 'package:im_mottu_mobile/app/data/models/pokemon_model.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/utils/data_manager.dart';

class GetPokemonDetailDatasource implements IGetPokemonDetailDatasource {
  final Dio dio;

  GetPokemonDetailDatasource({required this.dio});

  @override
  Future<DataManager<PokemonEntity>> call({String? name}) async {
    try {
      final Response response = await dio.get("/pokemon/$name");
      if (response.statusCode == 200) {
        return DataManager.isSuccess(
          data: PokemonModel.fromJson(response.data),
        );
      }

      return DataManager.isError(message: "Erro ao consultar os dados");
    } on DioException catch (_) {
      return DataManager.isError(message: "Erro ao consultar os dados");
    }
  }
}
