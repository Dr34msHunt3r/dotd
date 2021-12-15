part of 'edit_ingredients_cubit.dart';

@immutable
abstract class EditIngredientsState {}

class EditIngredientsInitial extends EditIngredientsState {}
class EditIngredientsError extends EditIngredientsState {
  final String error;

  EditIngredientsError({required this.error});
}
class IngredientsEdited extends EditIngredientsState {}
