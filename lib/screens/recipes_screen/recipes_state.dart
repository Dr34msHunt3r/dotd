part of 'recipes_cubit.dart';

@immutable
abstract class RecipesState {
  get recipes => null;
}

class RecipesInitial extends RecipesState {}
class RecipesLoaded extends RecipesState {
  final List<Recipe> recipes;

  RecipesLoaded({required this.recipes});
}
class RecipesEmpty extends RecipesState {
  final List<Recipe> recipes;

  RecipesEmpty({required this.recipes});
}
