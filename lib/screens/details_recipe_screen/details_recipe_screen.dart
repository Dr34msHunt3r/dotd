import 'package:dotd/api/services/dto/recipe_dto.dart';
import 'package:dotd/constants/strings.dart';
import 'package:dotd/navigation/screen_arguments.dart';
import 'package:flutter/material.dart';

class DetailsRecipeScreen extends StatelessWidget {
  const DetailsRecipeScreen({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(
            title: Text(recipe.recipeTitle),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context, EDIT_RECIPE_ROUTE,  arguments:  ScreenArguments(recipe: recipe));
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.edit),
                ),
              )
            ],
          ),
          body: SafeArea(child: _body(context)),
        );
  }

  Widget _body(context) {
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
                children:
                recipe.ingredients.map((e) => _ingredientsList(e, context))
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