part of 'add_ingredient_cubit.dart';

@immutable
abstract class AddIngredientState {}

class AddIngredientInitial extends AddIngredientState {}
class AddIngredientError extends AddIngredientState {
  final String error;

  AddIngredientError({required this.error});
}

class AddingIngredient extends AddIngredientState {}
class IngredientAdded extends AddIngredientState {}
