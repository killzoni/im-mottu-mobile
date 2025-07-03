import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BasePage<T> extends StatelessWidget {
  final T _controller = Get.find<T>();

  BasePage({super.key});

  T get controller => _controller;
}
