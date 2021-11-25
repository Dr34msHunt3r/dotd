part of 'ingredients_cubit.dart';

@immutable
abstract class IngredientsState {}

class IngredientsInitial extends IngredientsState {}
class IngredientsLoaded extends IngredientsState {
  final List<Ingredient> ingredients;

  IngredientsLoaded({required this.ingredients});
}
