import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/presentation/base_page.dart';
import 'package:im_mottu_mobile/app/presentation/detail/detail_controller.dart';
import 'package:im_mottu_mobile/app/utils/observable_state.dart';

class DetailPage extends BasePage<DetailController> {
  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon ${controller.getPokemonName}"),
      ),
      body: SafeArea(
        child: Obx(
          () => ObservableState<PokemonEntity>(
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
                    onPressed: controller.getPokemonByName,
                    child: const Text("Tentar novamente"),
                  ),
                ],
              ),
            ),
            stateSuccess: (data) {
              if (data == null) {
                return const SizedBox.shrink();
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    if (data.image != null) ...{
                      Hero(
                        tag: data.image ?? "",
                        child: CachedNetworkImage(
                          imageUrl: data.image!,
                          height: Get.height * .2,
                          width: Get.width * .8,
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
                    },
                    const SizedBox(height: 10),
                    ListTile(
                      title: const Text("Nome"),
                      trailing: Text(data.name),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Altura"),
                      trailing: Text(data.height.toString()),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Peso"),
                      trailing: Text(data.weight.toString()),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
