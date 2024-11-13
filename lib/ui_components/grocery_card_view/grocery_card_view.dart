import 'package:flutter/material.dart';
import 'package:goose/ui_components/grocery_card_view/grocery_card_view_model.dart';

class GroceryCardView extends StatelessWidget {
  final GroceryCardViewModel viewModel;
  final Function() onTap;

  const GroceryCardView({
    super.key,
    required this.viewModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(viewModel.name),
        leading: Container(
          width: 24,
          height: 24,
          color: viewModel.color,
        ),
        trailing: Text(viewModel.quantity),
      ),
    );
  }
}
