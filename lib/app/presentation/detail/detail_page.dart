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
        title: Text("Pokémon ${controller.getPokemonName}"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () => ObservableState<PokemonEntity>(
            state: controller.pokemonState.value,
            stateLoading: () =>
                const Center(child: CircularProgressIndicator()),
            stateError: (e) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(e.message ?? "Erro ao consultar os dados"),
                  const SizedBox(height: 10),
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

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Hero(
                      tag: data.image ?? "",
                      child: CachedNetworkImage(
                        imageUrl: data.image!,
                        height: Get.height * 0.25,
                        fit: BoxFit.contain,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error, size: 48),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle("Tipo"),
                    _buildChipList(data.types),
                    const SizedBox(height: 16),
                    _buildSectionTitle("Habilidades"),
                    _buildChipList(data.abilities),
                    const Divider(height: 32),
                    _buildDetailTile("Nome", data.name),
                    _buildDetailTile("Altura", "${data.height}"),
                    _buildDetailTile("Peso", "${data.weight}"),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildChipList(List<String>? items) {
    if (items == null || items.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      children: items.map((item) => Chip(label: Text(item))).toList(),
    );
  }

  Widget _buildDetailTile(String title, String value) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title),
          trailing: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
