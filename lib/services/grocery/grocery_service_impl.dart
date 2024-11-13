import 'package:goose/database/database_client.dart';
import 'package:goose/locator/locator.dart';
import 'package:goose/models/database/grocery_entity.dart';
import 'package:goose/services/grocery/grocery_service.dart';

class GroceryServiceImpl implements GroceryService {
  final _databaseClient = locator<DatabaseClient>();

  @override
  Future<List<GroceryEntity>> getAll() => _databaseClient.getGroceries();

  @override
  Future<GroceryEntity> add({required GroceryEntity entity}) =>
      _databaseClient.addGrocery(entity);

  @override
  Future<GroceryEntity> update({required GroceryEntity entity}) =>
      _databaseClient.updateGrocery(entity);

  @override
  Future<GroceryEntity> delete({required GroceryEntity entity}) =>
      _databaseClient.deleteGrocery(entity);
}
