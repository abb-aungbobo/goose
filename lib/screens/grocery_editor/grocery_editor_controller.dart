import 'package:get/get.dart';
import 'package:goose/locator/locator.dart';
import 'package:goose/models/database/category.dart';
import 'package:goose/models/database/grocery_entity.dart';
import 'package:goose/services/grocery/grocery_service.dart';

class GroceryEditorController extends GetxController {
  final _groceryService = locator<GroceryService>();

  final state = const GroceryEditorState().obs;

  void clearError() {
    state.value = state.value.copyWith(error: null);
  }

  bool isInvalidName(String? name) {
    return name == null ||
        name.isEmpty ||
        name.trim().length <= 1 ||
        name.trim().length > 50;
  }

  bool isInvalidQuantity(String? quantity) {
    return quantity == null ||
        quantity.isEmpty ||
        int.tryParse(quantity) == null ||
        int.tryParse(quantity)! <= 0;
  }

  void setName(String name) {
    state.value = state.value.copyWith(name: name);
  }

  void setQuantity(int quantity) {
    state.value = state.value.copyWith(quantity: quantity);
  }

  void setCategory(Category category) {
    state.value = state.value.copyWith(category: category);
  }

  void addGrocery() async {
    state.value = state.value.copyWith(isLoading: true);
    try {
      final entity = GroceryEntity(
        id: null,
        name: state.value.name,
        quantity: state.value.quantity,
        category: state.value.category,
      );
      await _groceryService.add(entity: entity);
      state.value = state.value.copyWith(isLoading: false, isDone: true);
    } catch (e) {
      state.value = state.value.copyWith(isLoading: false, error: e);
    }
  }

  void updateGrocery(int id) async {
    state.value = state.value.copyWith(isLoading: true);
    try {
      final entity = GroceryEntity(
        id: id,
        name: state.value.name,
        quantity: state.value.quantity,
        category: state.value.category,
      );
      await _groceryService.update(entity: entity);
      state.value = state.value.copyWith(isLoading: false, isDone: true);
    } catch (e) {
      state.value = state.value.copyWith(isLoading: false, error: e);
    }
  }
}

class GroceryEditorState {
  final bool isLoading;
  final Object? error;
  final String name;
  final int quantity;
  final Category category;
  final bool isDone;

  const GroceryEditorState({
    this.isLoading = false,
    this.error,
    this.name = "",
    this.quantity = 1,
    this.category = Category.vegetables,
    this.isDone = false,
  });

  GroceryEditorState copyWith({
    bool? isLoading,
    Object? error,
    String? name,
    int? quantity,
    Category? category,
    bool? isDone,
  }) {
    return GroceryEditorState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      isDone: isDone ?? this.isDone,
    );
  }
}
