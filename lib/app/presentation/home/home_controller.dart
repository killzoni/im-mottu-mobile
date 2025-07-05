import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/app_router.dart';
import 'package:im_mottu_mobile/app/data/datasource/cache.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/domain/usecases/get_pokemon_usecase.dart';
import 'package:im_mottu_mobile/app/utils/data_manager.dart';
import 'package:im_mottu_mobile/app/utils/state_page.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeController extends GetxController {
  final IGetPokemonUsecase getPokemonUsecase;
  final ICache cache;

  final Rx<StatePage<List<PokemonEntity>>> pokemonState = Rx(StateLoading());

  final int pageSize = 10;
  int totalItems = 0;

  final PagingController<int, PokemonEntity> pagingController =
      PagingController(
    firstPageKey: 0,
    invisibleItemsThreshold: 2,
  );

  HomeController({
    required this.getPokemonUsecase,
    required this.cache,
  });

  @override
  void onInit() {
    pagingController.addPageRequestListener((offset) {
      _getPokemon(offset);
    });
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  Future<void> _getPokemon(int offset) async {
    final DataManager<List<PokemonEntity>> dataManager =
        await getPokemonUsecase(
      offset: offset,
      limit: pageSize,
    );

    _handlePagination(dataManager, offset);
  }

  Future<void> _handlePagination(
    DataManager<List<PokemonEntity>> dataManager,
    int currentOffset,
  ) async {
    if (dataManager.isSuccess) {
      totalItems = dataManager.totalItems;

      final isLastPage = currentOffset + pageSize >= totalItems;

      if (isLastPage) {
        pagingController.appendLastPage(dataManager.data!);
      } else {
        final nextOffset = currentOffset + pageSize;
        pagingController.appendPage(dataManager.data!, nextOffset);
      }

      return;
    }

    pagingController.error =
        dataManager.messageError ?? "Desculpa, aconteceu um erro";
  }

  void openDetailPage(PokemonEntity pokemon) {
    AppRouter.goToDetail(pokemon);
  }

  Future<void> filterByName(String value) async {
    if (value.isEmpty) {
      final List<PokemonEntity> data = await cache.getListPokemon();
      pokemonState.value = StateSuccess(data: data);
      return;
    }

    if (pokemonState.value is StateSuccess) {
      final List<PokemonEntity> data =
          (pokemonState.value as StateSuccess).data;
      final List<PokemonEntity> filterData = data
          .where((pokemon) =>
              pokemon.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
      pokemonState.value = StateSuccess(data: filterData);
    }
  }
}
