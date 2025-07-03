import 'package:dio/dio.dart';
import 'package:im_mottu_mobile/app/data/datasource/get_pokemon_datasource.dart';
import 'package:im_mottu_mobile/app/data/models/pokemon_model.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/utils/data_manager.dart';

class GetPokemonDatasource implements IGetPokemonDatasource {
  final Dio dio;

  GetPokemonDatasource({required this.dio});

  @override
  Future<DataManager<List<PokemonEntity>>> call() async {
    try {
      final Response response = await dio.get("/pokemon");
      if (response.statusCode == 200) {
        dynamic data = response.data["results"];

        return DataManager.isSuccess(
            data: (data as List)
                .map((json) => PokemonModel.fromJsonOnlyName(json))
                .toList());
      }

      return DataManager.isError(message: "Erro ao consultar os dados");
    } on DioException catch (_) {
      return DataManager.isError(message: "Erro ao consultar os dados");
    }
  }
}
