part of 'add_ingredient_cubit.dart';

@immutable
abstract class AddIngredientsState {}

class AddIngredientsInitial extends AddIngredientsState {}
class AddIngredientsError extends AddIngredientsState {
  final String error;

  AddIngredientsError({required this.error});
}

class AddingIngredients extends AddIngredientsState {}
class IngredientsAdded extends AddIngredientsState {}
