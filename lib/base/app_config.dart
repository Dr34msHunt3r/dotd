import 'package:dotd/analytics/firebase_event_reporter.dart';
import 'package:dotd/config/app_colors.dart';
import 'package:dotd/navigation/auto_router.gr.dart' as router;
import 'package:dotd/repository/recipe_repository/recipe_repository.dart';
import 'package:dotd/screens/add_recipe_screen/add_recipe_cubit.dart';
import 'package:dotd/screens/edit_recipe_screen/edit_recipe_cubit.dart';
import 'package:dotd/screens/recipes_screen/recipes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dotd/extensions/value_to_color.dart';
import 'firebase_remote_config.dart';

class DoTDConfig extends StatelessWidget {
  DoTDConfig({Key? key, required this.config, required this.appRoute}) : super(key: key);
  final router.AppRouter appRoute;
  final FirebaseRemoteConfig config;

  final RecipeRepository recipeRepository = RecipeRepository();
  final FirebaseEventReporter firebaseEventReporter = FirebaseEventReporter();

  @override
  Widget build(BuildContext context) {
    final RecipesCubit recipesCubit = RecipesCubit(recipeRepository: recipeRepository, firebaseEventReporter: firebaseEventReporter);
    final primaryColor = config.appThemeConfigDto.primaryColor?.toColor() ?? AppColors.primaryColor;
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: recipesCubit),
          BlocProvider(
            create: (BuildContext context) => EditRecipeCubit(
              repository: recipeRepository,
              recipesCubit: recipesCubit,
            ),
          ),
          BlocProvider(
            create: (BuildContext context) => AddRecipeCubit(
                repository: recipeRepository,
                recipesCubit: recipesCubit
            ),
          ),
        ],
        child: MaterialApp.router(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                color: primaryColor??AppColors.primaryColor
            ),
          ),
          debugShowCheckedModeBanner: false,
          routerDelegate: appRoute.delegate(),
          routeInformationParser: appRoute.defaultRouteParser(),
        )
    );
  }

}