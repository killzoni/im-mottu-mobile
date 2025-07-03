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
                    if (data.image != null) ... {
                      Image.network(data.image!),
                    },
                    Text("Nome: ${data.name}"),
                    Text("Altura: ${data.height}"),
                    Text("Peso: ${data.weight}"),
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
