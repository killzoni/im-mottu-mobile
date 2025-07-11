import 'package:dio/dio.dart';
import 'package:im_mottu_mobile/app/data/datasource/get_pokemon_datasource.dart';
import 'package:im_mottu_mobile/app/data/models/pokemon_model.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/utils/data_manager.dart';

class GetPokemonDatasource implements IGetPokemonDatasource {
  final Dio dio;

  GetPokemonDatasource({required this.dio});

  @override
  Future<DataManager<List<PokemonEntity>>> call({
    required int limit,
    required int offset,
  }) async {
    try {
      final Response response =
          await dio.get("/pokemon?limit=$limit&offset=$offset");
      if (response.statusCode == 200) {
        final dynamic data = response.data["results"];
        final int count = response.data["count"];

        return DataManager.isSuccess(
            totalItems: count,
            data: (data as List).map((json) {
              json = addImageInResponse(json);
              return PokemonModel.fromJsonNameAndImage(json);
            }).toList());
      }

      return DataManager.isError(message: "Erro ao consultar os dados");
    } on DioException catch (_) {
      return DataManager.isError(message: "Erro ao consultar os dados");
    }
  }

  Map<String, dynamic> addImageInResponse(Map<String, dynamic> json) {
    final int imageId = _extractIdFromUrl(json["url"] ?? "");
    json.addAll(
      {
        "sprites": {
          "front_default":
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$imageId.png",
        }
      },
    );

    return json;
  }

  int _extractIdFromUrl(String url) {
    final Uri uri = Uri.parse(url);
    final List<String> segments = uri.pathSegments;

    if (segments.isNotEmpty) {
      final lastSegment = segments.where((s) => s.isNotEmpty).last;
      return int.tryParse(lastSegment) ?? -1;
    }

    return -1;
  }
}
