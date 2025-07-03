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
    // try {
    //   final Response response = await dio.get("/pokemon");
    //   if (response.statusCode == 200) {
    //     return DataManager.isSuccess(
    //         data: (response.data as List)
    //             .map((json) => PokemonModel.fromJson(json))
    //             .toList());
    //   }
    //
    //   return DataManager.isError(message: "Erro ao consultar os dados");
    // } on Exception catch (e) {
    //   //todo: pegar uma mensagem de erro da api
    //   return DataManager.isError(message: "Erro ao consultar os dados");
    // }

    await Future.delayed(const Duration(seconds: 2));
    return DataManager.isSuccess(
      data: List.generate(
        10,
        (index) => PokemonEntity(
          id: 10,
          name: "Teste $index",
          image:
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/35.png",
          height: 10,
          weight: 10,
        ),
      ).toList(),
    );
  }
}
