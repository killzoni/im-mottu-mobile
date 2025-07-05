import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/presentation/base_page.dart';
import 'package:im_mottu_mobile/app/presentation/home/home_controller.dart';
import 'package:im_mottu_mobile/app/utils/observable_state.dart';

class HomePage extends BasePage<HomeController> {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokemon"),
      ),
      body: SafeArea(
        child: Obx(
          () => ObservableState<List<PokemonEntity>>(
            state: controller.pokemonState.value,
            stateLoading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            stateError: (e) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(e.message ?? "Erro ao consultar os dados"),
                  TextButton(
                    onPressed: controller.getPokemon,
                    child: const Text("Tentar novamente"),
                  ),
                ],
              ),
            ),
            stateSuccess: (data) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        controller.filterByName(value);
                      },
                      decoration: InputDecoration(
                        labelText: 'Filtrar por nome',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Hero(
                            tag: data![index].image ?? "",
                            child: CachedNetworkImage(
                              imageUrl: data![index].image ?? "",
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                value: downloadProgress.progress,
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                              ),
                            ),
                          ),
                          title: Text(data![index].name),
                          onTap: () => controller.openDetailPage(data[index]),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
