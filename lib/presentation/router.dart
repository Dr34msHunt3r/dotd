import 'package:dotd/constants/strings.dart';
import 'package:dotd/cubit/add_recipe_cubit.dart';
import 'package:dotd/cubit/recipes_cubit.dart';
import 'package:dotd/data/models/recipe.dart';
import 'package:dotd/data/network_service.dart';
import 'package:dotd/data/repository.dart';
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
  late Repository repository;

  AppRouter(){
    repository = Repository(networkService: NetworkService());
    recipesCubit = RecipesCubit(repository: repository);
  }

  Route generateRoute(RouteSettings settings){
    switch(settings.name){
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: recipesCubit,
            child: const RecipesScreen(),
          ),
        );
      case DETAILS_RECIPE_ROUTE:
        final recipe = settings.arguments as Recipe;
        return MaterialPageRoute(builder: (_) => DetailsRecipeScreen(recipe: recipe,));
      case EDIT_RECIPE_ROUTE:
        return MaterialPageRoute(builder: (_) => const EditRecipeScreen());
      case ADD_RECIPE_ROUTE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => AddRecipeCubit(
                repository: repository,
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