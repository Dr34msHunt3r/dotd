import 'package:dotd/analytics/event_reporter.dart';
import 'package:dotd/analytics/firebase_event_reporter.dart';
import 'package:dotd/constants/strings.dart';
import 'package:dotd/cubit/recipe_cubits/add_recipe_cubit.dart';
import 'package:dotd/cubit/recipe_cubits/edit_recipe_cubit.dart';
import 'package:dotd/cubit/recipe_cubits/recipes_cubit.dart';
import 'package:dotd/data/models/screen_arguments.dart';
import 'package:dotd/data/network_services/recipe_drift_database/recipe_drift_database.dart';
import 'package:dotd/data/repositories/recipe_repository/recipe_repository.dart';
import 'package:dotd/presentation/screens/add_recipe_screen.dart';
import 'package:dotd/presentation/screens/details_recipe_screen.dart';
import 'package:dotd/presentation/screens/edit_recipe_screen.dart';
import 'package:dotd/presentation/screens/recipes_screen.dart';
import 'package:dotd/presentation/screens/settings_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late RecipesCubit recipesCubit;
  final RecipeRepository recipe_repository = RecipeRepository();
  final FirebaseEventReporter firebaseEventReporter = FirebaseEventReporter();

  AppRouter(){
    recipesCubit = RecipesCubit(recipe_repository: recipe_repository);
  }
  get appDatabase => AppDatabase();

  Route generateRoute(RouteSettings settings){
    switch(settings.name){
      case HOME_ROUTE:
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
      case DETAILS_RECIPE_ROUTE:
        firebaseEventReporter.reportScreenView(EventReporter.DETAILS_RECIPE_SCREEN_VIEWED);
        final argument = settings.arguments as ScreenArguments;
        return MaterialPageRoute(builder: (_) => BlocProvider.value(
          value: recipesCubit,
          child: DetailsRecipeScreen(recipe: argument.recipe!),
        )
        );
      case EDIT_RECIPE_ROUTE:
        firebaseEventReporter.reportScreenView(EventReporter.EDIT_RECIPE_SCREEN_VIEWED);
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
            child: EditRecipeScreen(recipe: argument.recipe!),
          ),
        );
       case ADD_RECIPE_ROUTE:
         firebaseEventReporter.reportScreenView(EventReporter.ADD_RECIPE_SCREEN_VIEWED);
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
         firebaseEventReporter.reportScreenView(EventReporter.SETTINGS_SCREEN_VIEWED);
         return MaterialPageRoute(builder: (_) => const SettingsAppScreen());
      default:
        return MaterialPageRoute(builder: (_) => const RecipesScreen());
    }
  }
}