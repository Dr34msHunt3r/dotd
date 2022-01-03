import 'package:dotd/constants/strings.dart';
import 'package:dotd/cubit/recipe_cubits/add_recipe_cubit.dart';
import 'package:dotd/cubit/recipe_cubits/edit_recipe_cubit.dart';
import 'package:dotd/cubit/recipe_cubits/recipes_cubit.dart';
import 'package:dotd/data/models/screen_arguments.dart';
import 'package:dotd/data/network_services/analytics_services.dart';
import 'package:dotd/data/network_services/recipe_drift_database/recipe_drift_database.dart';
import 'package:dotd/data/network_services/recipe_network_service.dart';
import 'package:dotd/data/repositories/recipe_repository.dart';
import 'package:dotd/presentation/screens/add_recipe_screen.dart';
import 'package:dotd/presentation/screens/details_recipe_screen.dart';
import 'package:dotd/presentation/screens/edit_recipe_screen.dart';
import 'package:dotd/presentation/screens/recipes_screen.dart';
import 'package:dotd/presentation/screens/settings_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {

  late RecipesCubit recipesCubit;
  late RecipeRepository recipe_repository;

  AppRouter(){
    recipe_repository = RecipeRepository(networkService: RecipeNetworkService(), appDatabase: AppDatabase());
    recipesCubit = RecipesCubit(recipe_repository: recipe_repository);
  }

  get appDatabase => AppDatabase();

  Route generateRoute(RouteSettings settings){
    switch(settings.name){
      case "/":
        return MaterialPageRoute(
            builder: (BuildContext context) {
              return MultiBlocProvider(providers: [
                BlocProvider.value(value: recipesCubit),
                ],
                child: const RecipesScreen()
              );
            }
        );
      case DETAILS_RECIPE_ROUTE:
      final argument = settings.arguments as ScreenArguments;
        return MaterialPageRoute(builder: (_) => BlocProvider.value(
          value: recipesCubit,
          child: DetailsRecipeScreen(recipe: argument.recipe),
        )
        );
      case EDIT_RECIPE_ROUTE:
        final argument = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) => EditRecipeCubit(
                  repository: recipe_repository,
                  recipesCubit: recipesCubit,
                ),
              ),
            ],
            child: EditRecipeScreen(recipe: argument.recipe),
          ),
        );
       case ADD_RECIPE_ROUTE:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                      create: (BuildContext context) => AddRecipeCubit(
                          repository: recipe_repository,
                          recipesCubit: recipesCubit
                      ),
              ),
            ],
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