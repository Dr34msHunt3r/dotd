import 'package:bloc/bloc.dart';
import 'package:dotd/data/repositories/ingredient_repository.dart';
import 'package:meta/meta.dart';

import 'ingredients_cubit.dart';

part 'edit_ingredients_state.dart';

class EditIngredientsCubit extends Cubit<EditIngredientsState> {
  EditIngredientsCubit({required this.repository, required this.ingredientsCubit}) : super(EditIngredientsInitial());

  final IngredientRepository repository;
  final IngredientsCubit ingredientsCubit;
}
