import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/app_binding.dart';
import 'package:im_mottu_mobile/app/app_router.dart';
import 'package:im_mottu_mobile/app/presentation/detail/detail_binding.dart';
import 'package:im_mottu_mobile/app/presentation/detail/detail_page.dart';
import 'package:im_mottu_mobile/app/presentation/home/home_binding.dart';
import 'package:im_mottu_mobile/app/presentation/home/home_page.dart';

class BaseApp extends StatefulWidget {
  const BaseApp({super.key});

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mottu Mobile',
      initialRoute: AppRouter.home,
      getPages: [
        GetPage(
          name: AppRouter.home,
          page: () => HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: AppRouter.detail,
          page: () => DetailPage(),
          binding: DetailBinding(),
        ),
      ],
      initialBinding: AppBinding(),
      defaultTransition: Transition.rightToLeft,
    );
  }
}
