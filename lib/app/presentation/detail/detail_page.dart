import 'package:flutter/material.dart';
import 'package:im_mottu_mobile/app/presentation/base_page.dart';
import 'package:im_mottu_mobile/app/presentation/detail/detail_controller.dart';

class DetailPage extends BasePage<DetailController> {
  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon ${controller.pokemon.name}"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(controller.pokemon.image),
            Text("Nome: ${controller.pokemon.name}"),
            Text("Altura: ${controller.pokemon.height}"),
            Text("Peso: ${controller.pokemon.weight}"),
          ],
        ),
      ),
    );
  }
}
