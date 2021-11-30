import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dotd/data/repositories/ingredient_repository.dart';
import 'package:meta/meta.dart';

import 'ingredients_cubit.dart';

part 'add_ingredient_state.dart';

class AddIngredientCubit extends Cubit<AddIngredientState> {
  AddIngredientCubit({required this.ingredientsCubit, required this.repository}) : super(AddIngredientInitial());

  final IngredientRepository repository;
  final IngredientsCubit ingredientsCubit;

  void addIngredient(String name, String recipeId) {
    // TODO: that's feature that will be available when ingredients will be really required
    // if (name.isEmpty){
    //   emit(AddIngredientError(error: "ingredients are missing"));
    //   return;
    // }

    emit(AddingIngredient());
    Timer(const Duration(seconds: 2), () {
      repository.addIngredient(name, recipeId).then((ingredient) {
        if(ingredient != null){
          ingredientsCubit.addIngredient(ingredient, recipeId);
          emit(IngredientAdded());
        }
      });
    });
  }
}
