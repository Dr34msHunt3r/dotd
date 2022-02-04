import 'package:auto_route/annotations.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:dotd/analytics/event_reporter.dart';
import 'package:dotd/analytics/firebase_event_reporter.dart';
import 'package:dotd/config/app_assets.dart';
import 'package:dotd/database/custom_rest_api/services/dto/recipe_dto.dart';
import 'package:dotd/navigation/auto_router.gr.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class DetailsRecipeScreen extends StatelessWidget {
  const DetailsRecipeScreen({Key? key, @PathParam() required this.recipeId, required this.recipe}) : super(key: key);

  final Recipe recipe;
  final String recipeId;

  @override
  Widget build(BuildContext context) {
    FirebaseEventReporter _firebaseEventReporter = FirebaseEventReporter();
    _firebaseEventReporter.reportScreenView(EventReporter.DETAILS_RECIPE_SCREEN_VIEWED);
        return Scaffold(
          appBar: AppBar(
            title: Text(recipe.recipeTitle),
            actions: [
              InkWell(
                onTap: () {
                  context.router.push(EditRecipeScreen(recipe: recipe, recipeId: recipe.id!));
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
        Stack(
            alignment: Alignment.bottomRight,
          children: [
            recipe.imageUrl == AppAssets.defaultRecipeImage ?  Image(image: AssetImage(recipe.imageUrl), fit: BoxFit.cover,) : Image.file(File(recipe.imageUrl), fit: BoxFit.cover,),
          ]
        ),
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