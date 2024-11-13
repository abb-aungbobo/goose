import 'package:get/get.dart';
import 'package:goose/locator/locator.dart';
import 'package:goose/models/database/grocery_entity.dart';
import 'package:goose/services/grocery/grocery_service.dart';

class GroceriesController extends GetxController {
  final _groceryService = locator<GroceryService>();

  final state = const GroceriesState().obs;

  void clearError() {
    state.value = state.value.copyWith(error: null);
  }

  void getGroceries() async {
    state.value = state.value.copyWith(isLoading: true);
    try {
      final groceries = await _groceryService.getAll();
      state.value =
          state.value.copyWith(isLoading: false, groceries: groceries);
    } catch (e) {
      state.value = state.value.copyWith(isLoading: false, error: e);
    }
  }

  void deleteGrocery(GroceryEntity entity) async {
    try {
      await _groceryService.delete(entity: entity);
      getGroceries();
    } catch (e) {
      state.value = state.value.copyWith(error: e);
    }
  }
}

class GroceriesState {
  final bool isLoading;
  final Object? error;
  final List<GroceryEntity> groceries;

  const GroceriesState({
    this.isLoading = false,
    this.error,
    this.groceries = const [],
  });

  GroceriesState copyWith({
    bool? isLoading,
    Object? error,
    List<GroceryEntity>? groceries,
  }) {
    return GroceriesState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      groceries: groceries ?? this.groceries,
    );
  }
}
