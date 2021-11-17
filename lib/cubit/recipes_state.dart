part of 'recipes_cubit.dart';

@immutable
abstract class RecipesState {}

class RecipesInitial extends RecipesState {}
class RecipesLoaded extends RecipesState {
  final List<Recipe> recipes;

  RecipesLoaded({required this.recipes});
}
