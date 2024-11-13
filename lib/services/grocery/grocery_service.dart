import 'package:goose/models/database/grocery_entity.dart';

abstract class GroceryService {
  Future<List<GroceryEntity>> getAll();
  Future<GroceryEntity> add({required GroceryEntity entity});
  Future<GroceryEntity> update({required GroceryEntity entity});
  Future<GroceryEntity> delete({required GroceryEntity entity});
}
