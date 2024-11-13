import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:goose/app_router/app_router.dart';
import 'package:goose/app_router/route_observer.dart';
import 'package:goose/locator/locator.dart';
import 'package:goose/models/database/grocery_entity.dart';
import 'package:goose/screens/groceries/groceries_controller.dart';
import 'package:goose/ui_components/error_dialog/error_dialog.dart';
import 'package:goose/ui_components/grocery_card_view/grocery_card_view.dart';
import 'package:goose/ui_components/loading_indicator/loading_indicator.dart';

class GroceriesScreen extends StatefulWidget {
  const GroceriesScreen({super.key});

  @override
  State<GroceriesScreen> createState() => _GroceriesScreenState();
}

class _GroceriesScreenState extends State<GroceriesScreen> with RouteAware {
  final _controller = locator<GroceriesController>();

  @override
  void initState() {
    super.initState();
    _controller.state.listen((state) {
      if (state.error != null) {
        showErrorDialog(context, error: state.error).then((_) {
          _controller.clearError();
        });
      }
    });
    _controller.getGroceries();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    _controller.getGroceries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Goose"),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(RouteName.groceryEditor, extra: null);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(
        () => Stack(
          children: [
            if (_controller.state.value.groceries.isEmpty) _buildEmpty(context),
            if (_controller.state.value.groceries.isNotEmpty)
              _buildList(context, state: _controller.state.value),
            if (_controller.state.value.isLoading) const LoadingIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_grocery_store,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 4),
          const Text("No groceries yet!"),
        ],
      ),
    );
  }

  Widget _buildList(
    BuildContext context, {
    required GroceriesState state,
  }) {
    return ListView.builder(
      itemCount: state.groceries.length,
      itemBuilder: (context, index) {
        final grocery = state.groceries[index];
        return Dismissible(
          key: Key(grocery.id!.toString()),
          child: GroceryCardView(
            viewModel: grocery.toGroceryCardViewModel(),
            onTap: () {
              context.pushNamed(RouteName.groceryEditor, extra: grocery);
            },
          ),
          onDismissed: (direction) {
            _controller.deleteGrocery(grocery);
          },
        );
      },
    );
  }
}
