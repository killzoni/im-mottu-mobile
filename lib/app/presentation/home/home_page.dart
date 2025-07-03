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
              return ListView.builder(
                itemCount: data?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(data![index].image),
                    title: Text("Nome: ${data[index].name}"),
                    onTap: () => controller.openDetailPage(data[index]),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
