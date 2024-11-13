import 'package:get_it/get_it.dart';
import 'package:goose/database/database_client.dart';
import 'package:goose/screens/groceries/groceries_controller.dart';
import 'package:goose/screens/grocery_editor/grocery_editor_controller.dart';
import 'package:goose/services/grocery/grocery_service.dart';
import 'package:goose/services/grocery/grocery_service_impl.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  _registerDatabaseClient();
  _registerServices();
  _registerControllers();
}

void _registerDatabaseClient() {
  locator.registerLazySingleton<DatabaseClient>(() => DatabaseClient());
}

void _registerServices() {
  locator.registerFactory<GroceryService>(() => GroceryServiceImpl());
}

void _registerControllers() {
  locator.registerFactory<GroceriesController>(() => GroceriesController());
  locator.registerFactory<GroceryEditorController>(
      () => GroceryEditorController());
}
