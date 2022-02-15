// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i9;

import '../base/home_page.dart' as _i1;
import '../repository/recipe_repository/model/dto/recipe_dto.dart' as _i10;
import '../screens/add_recipe_screen/add_recipe_screen.dart' as _i4;
import '../screens/details_recipe_screen/details_recipe_screen.dart' as _i5;
import '../screens/draw_meal_screen/draw_meal_screen.dart' as _i8;
import '../screens/edit_recipe_screen/edit_recipe_screen.dart' as _i6;
import '../screens/recipes_screen/recipes_screen.dart' as _i3;
import '../screens/settings_screen/settings_app.dart' as _i7;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.HomePage(key: args.key));
    },
    RecipesRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    DrawMealRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    RecipesScreen.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.RecipesScreen());
    },
    AddRecipeScreen.name: (routeData) {
      final args = routeData.argsAs<AddRecipeScreenArgs>(
          orElse: () => const AddRecipeScreenArgs());
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.AddRecipeScreen(key: args.key));
    },
    DetailsRecipeScreen.name: (routeData) {
      final args = routeData.argsAs<DetailsRecipeScreenArgs>();
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.DetailsRecipeScreen(
              key: args.key, recipeId: args.recipeId, recipe: args.recipe));
    },
    EditRecipeScreen.name: (routeData) {
      final args = routeData.argsAs<EditRecipeScreenArgs>();
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.EditRecipeScreen(
              key: args.key, recipe: args.recipe, recipeId: args.recipeId));
    },
    SettingsAppScreen.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.SettingsAppScreen());
    },
    DrawMealScreen.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.DrawMealScreen());
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeRoute.name, path: '/', children: [
          _i2.RouteConfig(RecipesRouter.name,
              path: 'recipes',
              parent: HomeRoute.name,
              children: [
                _i2.RouteConfig(RecipesScreen.name,
                    path: '', parent: RecipesRouter.name),
                _i2.RouteConfig(AddRecipeScreen.name,
                    path: 'add-recipe', parent: RecipesRouter.name),
                _i2.RouteConfig(DetailsRecipeScreen.name,
                    path: 'details:recipeId', parent: RecipesRouter.name),
                _i2.RouteConfig(EditRecipeScreen.name,
                    path: 'edit:recipeId', parent: RecipesRouter.name),
                _i2.RouteConfig(SettingsAppScreen.name,
                    path: 'settings', parent: RecipesRouter.name)
              ]),
          _i2.RouteConfig(DrawMealRouter.name,
              path: 'draw-meal',
              parent: HomeRoute.name,
              children: [
                _i2.RouteConfig(DrawMealScreen.name,
                    path: '', parent: DrawMealRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i2.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({_i9.Key? key, List<_i2.PageRouteInfo>? children})
      : super(HomeRoute.name,
            path: '/',
            args: HomeRouteArgs(key: key),
            initialChildren: children);

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.EmptyRouterPage]
class RecipesRouter extends _i2.PageRouteInfo<void> {
  const RecipesRouter({List<_i2.PageRouteInfo>? children})
      : super(RecipesRouter.name, path: 'recipes', initialChildren: children);

  static const String name = 'RecipesRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class DrawMealRouter extends _i2.PageRouteInfo<void> {
  const DrawMealRouter({List<_i2.PageRouteInfo>? children})
      : super(DrawMealRouter.name,
            path: 'draw-meal', initialChildren: children);

  static const String name = 'DrawMealRouter';
}

/// generated route for
/// [_i3.RecipesScreen]
class RecipesScreen extends _i2.PageRouteInfo<void> {
  const RecipesScreen() : super(RecipesScreen.name, path: '');

  static const String name = 'RecipesScreen';
}

/// generated route for
/// [_i4.AddRecipeScreen]
class AddRecipeScreen extends _i2.PageRouteInfo<AddRecipeScreenArgs> {
  AddRecipeScreen({_i9.Key? key})
      : super(AddRecipeScreen.name,
            path: 'add-recipe', args: AddRecipeScreenArgs(key: key));

  static const String name = 'AddRecipeScreen';
}

class AddRecipeScreenArgs {
  const AddRecipeScreenArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'AddRecipeScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.DetailsRecipeScreen]
class DetailsRecipeScreen extends _i2.PageRouteInfo<DetailsRecipeScreenArgs> {
  DetailsRecipeScreen(
      {_i9.Key? key, required String recipeId, required _i10.Recipe recipe})
      : super(DetailsRecipeScreen.name,
            path: 'details:recipeId',
            args: DetailsRecipeScreenArgs(
                key: key, recipeId: recipeId, recipe: recipe),
            rawPathParams: {'recipeId': recipeId});

  static const String name = 'DetailsRecipeScreen';
}

class DetailsRecipeScreenArgs {
  const DetailsRecipeScreenArgs(
      {this.key, required this.recipeId, required this.recipe});

  final _i9.Key? key;

  final String recipeId;

  final _i10.Recipe recipe;

  @override
  String toString() {
    return 'DetailsRecipeScreenArgs{key: $key, recipeId: $recipeId, recipe: $recipe}';
  }
}

/// generated route for
/// [_i6.EditRecipeScreen]
class EditRecipeScreen extends _i2.PageRouteInfo<EditRecipeScreenArgs> {
  EditRecipeScreen(
      {_i9.Key? key, required _i10.Recipe recipe, required String recipeId})
      : super(EditRecipeScreen.name,
            path: 'edit:recipeId',
            args: EditRecipeScreenArgs(
                key: key, recipe: recipe, recipeId: recipeId),
            rawPathParams: {'recipeId': recipeId});

  static const String name = 'EditRecipeScreen';
}

class EditRecipeScreenArgs {
  const EditRecipeScreenArgs(
      {this.key, required this.recipe, required this.recipeId});

  final _i9.Key? key;

  final _i10.Recipe recipe;

  final String recipeId;

  @override
  String toString() {
    return 'EditRecipeScreenArgs{key: $key, recipe: $recipe, recipeId: $recipeId}';
  }
}

/// generated route for
/// [_i7.SettingsAppScreen]
class SettingsAppScreen extends _i2.PageRouteInfo<void> {
  const SettingsAppScreen() : super(SettingsAppScreen.name, path: 'settings');

  static const String name = 'SettingsAppScreen';
}

/// generated route for
/// [_i8.DrawMealScreen]
class DrawMealScreen extends _i2.PageRouteInfo<void> {
  const DrawMealScreen() : super(DrawMealScreen.name, path: '');

  static const String name = 'DrawMealScreen';
}
