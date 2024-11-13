import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:goose/locator/locator.dart';
import 'package:goose/models/database/category.dart';
import 'package:goose/models/database/grocery_entity.dart';
import 'package:goose/screens/grocery_editor/grocery_editor_controller.dart';
import 'package:goose/ui_components/error_dialog/error_dialog.dart';

class GroceryEditorScreen extends StatefulWidget {
  final GroceryEntity? grocery;

  const GroceryEditorScreen({
    super.key,
    required this.grocery,
  });

  @override
  State<GroceryEditorScreen> createState() => _GroceryEditorScreenState();
}

class _GroceryEditorScreenState extends State<GroceryEditorScreen> {
  final _controller = locator<GroceryEditorController>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller.state.listen((state) {
      if (state.error != null) {
        showErrorDialog(context, error: state.error).then((_) {
          _controller.clearError();
        });
      }
      if (state.isDone) {
        context.pop();
      }
    });
    if (widget.grocery != null) {
      _controller.setName(widget.grocery!.name);
      _controller.setQuantity(widget.grocery!.quantity);
      _controller.setCategory(widget.grocery!.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => _buildForm(context, state: _controller.state.value)),
      ),
    );
  }

  Widget _buildForm(
    BuildContext context, {
    required GroceryEditorState state,
  }) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildNameTextFormField(state: state),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildQuantityTextFormField(state: state),
              const SizedBox(width: 8),
              _buildCategoryDropdownButtonFormField(state: state),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildResetButton(state: state),
              _buildDoneButton(state: state),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNameTextFormField({
    required GroceryEditorState state,
  }) {
    return TextFormField(
      maxLength: 50,
      decoration: const InputDecoration(
        label: Text("Name"),
      ),
      initialValue: state.name,
      validator: (value) {
        if (_controller.isInvalidName(value)) {
          return "Must be between 1 and 50 characters.";
        }
        return null;
      },
      onSaved: (value) {
        _controller.setName(value!);
      },
    );
  }

  Widget _buildQuantityTextFormField({
    required GroceryEditorState state,
  }) {
    return Expanded(
      child: TextFormField(
        decoration: const InputDecoration(
          label: Text("Quantity"),
        ),
        keyboardType: TextInputType.number,
        initialValue: state.quantity.toString(),
        validator: (value) {
          if (_controller.isInvalidQuantity(value)) {
            return "Must be a valid, positive number.";
          }
          return null;
        },
        onSaved: (value) {
          _controller.setQuantity(int.parse(value!));
        },
      ),
    );
  }

  Widget _buildCategoryDropdownButtonFormField({
    required GroceryEditorState state,
  }) {
    return Expanded(
      child: DropdownButtonFormField(
        value: state.category,
        items: [
          for (final category in Category.values)
            DropdownMenuItem(
              value: category,
              child: Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    color: category.color,
                  ),
                  const SizedBox(width: 8),
                  Text(category.title),
                ],
              ),
            ),
        ],
        onChanged: (value) {
          _controller.setCategory(value!);
        },
      ),
    );
  }

  Widget _buildResetButton({
    required GroceryEditorState state,
  }) {
    return TextButton(
      onPressed: state.isLoading
          ? null
          : () {
              _formKey.currentState!.reset();
            },
      child: const Text("Reset"),
    );
  }

  Widget _buildDoneButton({
    required GroceryEditorState state,
  }) {
    return ElevatedButton(
      onPressed: state.isLoading ? null : _saveGrocery,
      child: state.isLoading
          ? const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(),
            )
          : const Text("Done"),
    );
  }

  void _saveGrocery() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.grocery == null) {
        _controller.addGrocery();
      } else {
        _controller.updateGrocery(widget.grocery!.id!);
      }
    }
  }
}
