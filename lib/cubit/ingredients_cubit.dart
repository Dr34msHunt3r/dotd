import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotd/data/models/ingredient.dart';
import 'package:dotd/data/repositories/ingredient_repository.dart';
import 'package:meta/meta.dart';

part 'ingredients_state.dart';

class IngredientsCubit extends Cubit<IngredientsState> {
  IngredientsCubit({required this.ingredient_repository}) : super(IngredientsInitial());

  final IngredientRepository ingredient_repository;

  void fetchIngredients() {
    Timer(const Duration(seconds: 1), (){
      ingredient_repository.fetchIngredients().then((ingredients) {
        emit(IngredientsLoaded(ingredients: ingredients));
      });
    });
  }
}
