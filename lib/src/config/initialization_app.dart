
import 'package:get/get.dart';
import 'package:wizard_guide/src/data/datasource/firebase_datasource.dart';
import 'package:wizard_guide/src/data/repositories/api_repository_impl.dart';

void injectDependencies() {
   // Inject Datasource
  Get.lazyPut(() => FirebaseDatasource(), fenix: true);

  // Inject Repositories
  Get.lazyPut(() => ApiRepositoryImpl(), fenix: true);
}