import 'package:bloc/bloc.dart';
import 'package:dotd/data/models/ingredients_model.dart';
import 'package:dotd/data/repositories/ingredient_repository.dart';
import 'package:meta/meta.dart';

import 'ingredients_cubit.dart';

part 'edit_ingredients_state.dart';

class EditIngredientsCubit extends Cubit<EditIngredientsState> {
  EditIngredientsCubit({required this.repository, required this.ingredientsCubit}) : super(EditIngredientsInitial());

  final IngredientRepository repository;
  final IngredientsCubit ingredientsCubit;

  void updateIngredients(List<Ingredient> ingredients, List<Ingredient> updatedIngredients, String recipeId) {

    if(updatedIngredients.length >= ingredients.length){
      for(var i=0; i < updatedIngredients.length; i++){
        if(i < ingredients.length){
          if(updatedIngredients[i].name != ''){
            ingredients[i].name = updatedIngredients[i].name;
          }else{
            ingredients.removeAt(i);
            updatedIngredients.removeAt(i);
            i--;
          }
        }else if(i >= ingredients.length && updatedIngredients[i].name != ''){
          ingredients.add(updatedIngredients[i]);
        }
      }
    }else{
      for(var i=0; i < ingredients.length ; i++){
        if(i < updatedIngredients.length){
          if(updatedIngredients[i].name != ''){
            ingredients[i].name = updatedIngredients[i].name;
          }else{
            ingredients.removeAt(i);
            updatedIngredients.removeAt(i);
            i--;
          }
        }else if(i >= updatedIngredients.length){
          ingredients.removeAt(i);
          i--;
        }
      }
    }
    repository.updateIngredients(ingredients, recipeId).then((newIngredients) {
      if(newIngredients != null) {
        ingredientsCubit.updateIngredientsList(ingredients, newIngredients, recipeId);
        emit(IngredientsEdited());
      }
    });
  }
}
