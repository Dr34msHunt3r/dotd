import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotd/data/models/ingredients_model.dart';
import 'package:dotd/data/repositories/ingredient_repository.dart';
import 'package:meta/meta.dart';

import 'ingredients_cubit.dart';

part 'add_ingredient_state.dart';

class AddIngredientCubit extends Cubit<AddIngredientsState> {
  AddIngredientCubit({required this.ingredientsCubit, required this.repository}) : super(AddIngredientsInitial());

  final IngredientRepository repository;
  final IngredientsCubit ingredientsCubit;

  void addIngredient(List<Ingredient> ingredients) {
    // TODO: add error for empty fields

    emit(AddingIngredients());
    Timer(const Duration(seconds: 2), () {
      repository.addIngredients(ingredients).then((ingredients) {
        if(ingredients != null){
          ingredientsCubit.addIngredient(ingredients);
          emit(IngredientsAdded());
        }
      });
    });
  }
}
