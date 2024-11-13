import 'package:go_router/go_router.dart';
import 'package:goose/app_router/route_observer.dart';
import 'package:goose/models/database/grocery_entity.dart';
import 'package:goose/screens/groceries/groceries_screen.dart';
import 'package:goose/screens/grocery_editor/grocery_editor_screen.dart';

class RouteName {
  static const groceries = "groceries";
  static const groceryEditor = "grocery_editor";
}

class RoutePath {
  static const groceries = "/groceries";
  static const groceryEditor = "/grocery_editor";
}

final appRouter = GoRouter(
  routes: [
    GoRoute(
      name: RouteName.groceries,
      path: RoutePath.groceries,
      builder: (context, state) => const GroceriesScreen(),
    ),
    GoRoute(
      name: RouteName.groceryEditor,
      path: RoutePath.groceryEditor,
      builder: (context, state) {
        final grocery =
            state.extra == null ? null : state.extra as GroceryEntity;
        return GroceryEditorScreen(grocery: grocery);
      },
    ),
  ],
  initialLocation: RoutePath.groceries,
  observers: [routeObserver],
);
