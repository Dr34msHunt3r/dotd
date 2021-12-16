import 'package:dotd/data/models/recipe_model.dart';
import 'package:dotd/data/models/ingredients_model.dart';

class ScreenArguments {
  final Recipe recipe;
  final List<Ingredient> ingredient;

  ScreenArguments({
    required this.recipe,
    required this.ingredient
});

}