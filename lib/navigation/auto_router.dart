import 'package:auto_route/auto_route.dart';
import 'package:dotd/base/home_page.dart';
import 'package:dotd/screens/add_recipe_screen/add_recipe_screen.dart';
import 'package:dotd/screens/details_recipe_screen/details_recipe_screen.dart';
import 'package:dotd/screens/draw_meal_screen/draw_meal_screen.dart';
import 'package:dotd/screens/edit_recipe_screen/edit_recipe_screen.dart';
import 'package:dotd/screens/recipes_screen/recipes_screen.dart';
import 'package:dotd/screens/settings_screen/settings_app.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: [
  AutoRoute(
      path: '/',
      page: HomePage,
    children: [
      AutoRoute(
          path: 'recipes',
          name: 'RecipesRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: '',
              page: RecipesScreen,
            ),
            AutoRoute(
                path: 'add-recipe',
                page: AddRecipeScreen
            ),
            AutoRoute(
              path: 'details:recipeId',
              page: DetailsRecipeScreen
            ),
            AutoRoute(
                path: 'edit:recipeId',
                page: EditRecipeScreen
            ),
            AutoRoute(
                path: 'settings',
                page: SettingsAppScreen
            )
          ]
      ),
      AutoRoute(
        path: 'draw-meal',
        name: 'DrawMealRouter',
        page: EmptyRouterPage,
        children: [
          AutoRoute(
            path: '',
            page: DrawMealScreen,
          )
        ]
      )
    ]
  )
])
class $AppRouter {}