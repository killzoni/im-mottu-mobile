import 'package:get/get.dart';
import 'package:im_mottu_mobile/app/data/repositories/repositories_binding.dart';
import 'package:im_mottu_mobile/app/data/usecases/usecase_binding.dart';
import 'package:im_mottu_mobile/app/infra/datasource/datasources_binding.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    UsecaseBinding().dependencies();
    RepositoriesBinding().dependencies();
    DatasourcesBinding().dependencies();
  }
}
