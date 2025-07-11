import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/presentation/base_page.dart';
import 'package:im_mottu_mobile/app/presentation/splash/splash_controller.dart';

class SplashPage extends BasePage<SplashController> {
  SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/splash.png",
        fit: BoxFit.cover,
        height: Get.height,
        width: Get.width,
      ),
    );
  }
}
