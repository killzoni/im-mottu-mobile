import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/domain/entities/pokemon_entity.dart';
import 'package:im_mottu_mobile/app/presentation/base_page.dart';
import 'package:im_mottu_mobile/app/presentation/home/home_controller.dart';
import 'package:im_mottu_mobile/app/utils/observable_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends BasePage<HomeController> {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokemon"),
      ),
      body: SafeArea(
        child: Column(
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
              child: PagedListView<int, PokemonEntity>(
                pagingController: controller.pagingController,
                padding: EdgeInsets.zero,
                builderDelegate: PagedChildBuilderDelegate<PokemonEntity>(
                  transitionDuration: const Duration(milliseconds: 500),
                  animateTransitions: true,
                  newPageProgressIndicatorBuilder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  firstPageErrorIndicatorBuilder: (context) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(controller.pagingController.error),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              controller.pagingController.refresh();
                            },
                            child: const Text("Tentar novamente"),
                          ),
                        ],
                      ),
                    );
                  },
                  noItemsFoundIndicatorBuilder: (context) {
                    return const SizedBox();
                  },
                  itemBuilder: (context, pokemonEntity, index) {
                    return ListTile(
                      leading: Hero(
                        tag: pokemonEntity.image ?? "",
                        child: CachedNetworkImage(
                          imageUrl: pokemonEntity.image ?? "",
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
                      title: Text(pokemonEntity.name),
                      onTap: () => controller.openDetailPage(pokemonEntity),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
