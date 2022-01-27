import 'package:dotd/analytics/event_reporter.dart';
import 'package:dotd/analytics/firebase_event_reporter.dart';
import 'package:dotd/repository/recipe_repository/recipe_repository.dart';
import 'package:dotd/screens/add_recipe_screen/add_recipe_cubit.dart';
import 'package:dotd/screens/add_recipe_screen/add_recipe_screen.dart';
import 'package:dotd/screens/details_recipe_screen/details_recipe_screen.dart';
import 'package:dotd/screens/edit_recipe_screen/edit_recipe_cubit.dart';
import 'package:dotd/screens/edit_recipe_screen/edit_recipe_screen.dart';
import 'package:dotd/screens/recipes_screen/recipes_cubit.dart';
import 'package:dotd/navigation/screen_arguments.dart';
import 'package:dotd/screens/recipes_screen/recipes_screen.dart';
import 'package:dotd/screens/settings_screen/settings_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/screen_name.dart';

class AppRouter {
  late RecipesCubit recipesCubit;
  final RecipeRepository recipeRepository = RecipeRepository();
  final FirebaseEventReporter firebaseEventReporter = FirebaseEventReporter();

  AppRouter(){
    recipesCubit = RecipesCubit(recipeRepository: recipeRepository, firebaseEventReporter: firebaseEventReporter);
  }

  Route generateRoute(RouteSettings settings){
    switch(settings.name){
      case ScreenName.HOME_ROUTE:
        firebaseEventReporter.reportScreenView(EventReporter.HOME_SCREEN_VIEWED);
        return MaterialPageRoute(
            builder: (BuildContext context) {
              return MultiBlocProvider(providers: [
                BlocProvider.value(value: recipesCubit),
                ],
                child: const RecipesScreen()
              );
            }
        );
      case ScreenName.DETAILS_RECIPE_ROUTE:
        firebaseEventReporter.reportScreenView(EventReporter.DETAILS_RECIPE_SCREEN_VIEWED);
        final argument = settings.arguments as ScreenArguments;
        return MaterialPageRoute(builder: (_) => BlocProvider.value(
          value: recipesCubit,
          child: DetailsRecipeScreen(recipe: argument.recipe!),
        )
        );
      case ScreenName.EDIT_RECIPE_ROUTE:
        firebaseEventReporter.reportScreenView(EventReporter.EDIT_RECIPE_SCREEN_VIEWED);
        final argument = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) => EditRecipeCubit(
                  repository: recipeRepository,
                  recipesCubit: recipesCubit,
                ),
              ),
            ],
            child: EditRecipeScreen(recipe: argument.recipe!),
          ),
        );
       case ScreenName.ADD_RECIPE_ROUTE:
         firebaseEventReporter.reportScreenView(EventReporter.ADD_RECIPE_SCREEN_VIEWED);
         return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                      create: (BuildContext context) => AddRecipeCubit(
                          repository: recipeRepository,
                          recipesCubit: recipesCubit
                      ),
              ),
            ],
            child: AddRecipeScreen(),
          ),
        );
       case ScreenName.SETTINGS_APP_ROUTE:
         firebaseEventReporter.reportScreenView(EventReporter.SETTINGS_SCREEN_VIEWED);
         return MaterialPageRoute(builder: (_) => const SettingsAppScreen());
      default:
        return MaterialPageRoute(builder: (_) => const RecipesScreen());
    }
  }
}