import 'package:goose/models/database/category.dart';
import 'package:goose/ui_components/grocery_card_view/grocery_card_view_model.dart';

class GroceryEntity {
  final int? id;
  final String name;
  final int quantity;
  final Category category;

  const GroceryEntity({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  factory GroceryEntity.fromJson(Map<String, dynamic> json) {
    return GroceryEntity(
      id: (json["id"] as num).toInt(),
      name: json["name"] as String,
      quantity: (json["quantity"] as num).toInt(),
      category: Category.fromRawValue(json["category"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "quantity": quantity,
      "category": category.rawValue,
    };
  }

  GroceryEntity copyWith({
    int? id,
    String? name,
    int? quantity,
    Category? category,
  }) {
    return GroceryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
    );
  }
}

extension GroceryEntityToGroceryCardViewModel on GroceryEntity {
  GroceryCardViewModel toGroceryCardViewModel() {
    return GroceryCardViewModel(
      name: name,
      color: category.color,
      quantity: quantity.toString(),
    );
  }
}
