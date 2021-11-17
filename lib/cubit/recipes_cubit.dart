import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotd/data/models/recipe.dart';
import 'package:dotd/data/repository.dart';
import 'package:meta/meta.dart';

part 'recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  RecipesCubit({required this.repository}) : super(RecipesInitial());

  final Repository repository;

  void fetchRecipes() {
    Timer(const Duration(seconds: 1), (){
      repository.fetchRecipes().then((recipes) {
        emit(RecipesLoaded(recipes: recipes));
      });
    });
  }
}
