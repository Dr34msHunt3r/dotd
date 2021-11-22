import 'package:dotd/constants/strings.dart';
import 'package:dotd/data/models/recipe.dart';
import 'package:flutter/cupertino.dart';
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
            onTap: (){
              Navigator.pushNamed(context, EDIT_RECIPE_ROUTE, arguments: recipe);
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

  Widget _body(context){
    return ListView(
      padding: const EdgeInsets.all(25.0),
      children: [
        const SizedBox(height: 100.0,),
        const Text("Place for future image here :)", style: TextStyle(fontSize: 20),),
        const SizedBox(height: 100.0,),
        const Text("Recipe:", style: TextStyle(fontSize: 20),),
        const SizedBox(height: 10.0,),
        Text(recipe.recipeRecipe, style: const TextStyle(fontSize: 16),)
      ],
    );
  }
}