import 'package:dotd/constants/strings.dart';
import 'package:dotd/cubit/add_recipe_cubit.dart';
import 'package:dotd/cubit/edit_recipe_cubit.dart';
import 'package:dotd/cubit/ingredients_cubit.dart';
import 'package:dotd/cubit/recipes_cubit.dart';
import 'package:dotd/data/models/ingredients.dart';
import 'package:dotd/data/models/screen_arguments.dart';
import 'package:dotd/data/models/recipe.dart';
import 'package:dotd/data/network_services/ingredient_network_service.dart';
import 'package:dotd/data/network_services/recipe_network_service.dart';
import 'package:dotd/data/repositories/ingredient_repository.dart';
import 'package:dotd/data/repositories/recipe_repository.dart';
import 'package:dotd/presentation/screens/add_recipe_screen.dart';
import 'package:dotd/presentation/screens/details_recipe_screen.dart';
import 'package:dotd/presentation/screens/edit_recipe_screen.dart';
import 'package:dotd/presentation/screens/recipes_screen.dart';
import 'package:dotd/presentation/screens/settings_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {

  late RecipesCubit recipesCubit;
  late RecipeRepository recipe_repository;
  late IngredientsCubit ingredientsCubit;
  late IngredientRepository ingredient_repository;

  AppRouter(){
    recipe_repository = RecipeRepository(networkService: RecipeNetworkService());
    recipesCubit = RecipesCubit(recipe_repository: recipe_repository);
    ingredient_repository = IngredientRepository(networkService: IngredientNetworkService());
    ingredientsCubit = IngredientsCubit(ingredient_repository: ingredient_repository);
  }

  Route generateRoute(RouteSettings settings){
    switch(settings.name){
      case "/":
        return MaterialPageRoute(
            builder: (BuildContext context) {
              return MultiBlocProvider(providers: [
                BlocProvider.value(value: recipesCubit),
                // BlocProvider.value(value: ingredientsCubit),
                ],
                child: const RecipesScreen()
              );
            }
        );
      case DETAILS_RECIPE_ROUTE:
      // final argument = settings.arguments as ScreenArguments;
      final recipe = settings.arguments as Recipe;
        return MaterialPageRoute(builder: (_) => BlocProvider.value(
          value: ingredientsCubit,
          // child: DetailsRecipeScreen(recipe: argument.recipe, ingredients: argument.ingredient,),
          child: DetailsRecipeScreen(recipe: recipe),
        )
        );
      case EDIT_RECIPE_ROUTE:
        final recipe = settings.arguments as Recipe;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => EditRecipeCubit(
                repository: recipe_repository,
                recipesCubit: recipesCubit,
            ),
            child: EditRecipeScreen(recipe: recipe,),
          ),
        );
       case ADD_RECIPE_ROUTE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => AddRecipeCubit(
                repository: recipe_repository,
                recipesCubit: recipesCubit
            ),
            child: AddRecipeScreen(),
          ),
        );
       case SETTINGS_APP_ROUTE:
        return MaterialPageRoute(builder: (_) => const SettingsAppScreen());
      default:
        return MaterialPageRoute(builder: (_) => const RecipesScreen());
    }
  }
}