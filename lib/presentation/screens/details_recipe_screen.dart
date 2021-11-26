import 'package:dotd/constants/strings.dart';
import 'package:dotd/cubit/ingredients_cubit.dart';
import 'package:dotd/cubit/recipes_cubit.dart';
import 'package:dotd/data/models/ingredients.dart';
import 'package:dotd/data/models/recipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsRecipeScreen extends StatelessWidget {
  const DetailsRecipeScreen({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  // final List<Ingredient> ingredients;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<IngredientsCubit>(context).fetchIngredients(recipe.id);


    return BlocBuilder<IngredientsCubit, IngredientsState>(
      builder: (context, IngredientsState) {
        List<Ingredient> ingredients = [];
        if (IngredientsState is IngredientsLoaded){
          ingredients = (IngredientsState as IngredientsLoaded).ingredients.toList();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(recipe.recipeTitle),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context, EDIT_RECIPE_ROUTE, arguments: recipe);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.edit),
                ),
              )
            ],
          ),
          body: SafeArea(child: _body(context, ingredients)),
        );
      },
    );
  }

  Widget _body(context, ingredients) {
    List<Ingredient> ingredientsList = ingredients;
    return ListView(
      children: [
        Image(image: AssetImage('assets/default/recipe_default_image.png')),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Recipe:", style: TextStyle(fontSize: 20),),
              const SizedBox(height: 10.0,),
              Text(recipe.recipeRecipe, style: const TextStyle(fontSize: 16),),
              const SizedBox(height: 15.0,),
              Text("Ingredients:", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ingredientsList.map((e) => _ingredientsList(e, context))
                    .toList(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _ingredientsList(Ingredient ingredient, context) {
    return Text(ingredient.name);
  }
}