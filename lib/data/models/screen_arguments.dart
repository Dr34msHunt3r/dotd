import 'package:dotd/data/models/recipe.dart';
import 'package:dotd/data/models/ingredients.dart';

class ScreenArguments {
  final Recipe recipe;
  final List<Ingredient> ingredient;

  ScreenArguments({
    required this.recipe,
    required this.ingredient
});

}