import 'package:dotd/constants/strings.dart';
import 'package:dotd/cubit/ingredients_cubit.dart';
import 'package:dotd/cubit/recipes_cubit.dart';
import 'package:dotd/data/models/ingredients.dart';
import 'package:dotd/data/models/recipe.dart';
import 'package:dotd/data/models/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RecipesCubit>(context).fetchRecipes();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipes"),
        actions: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, SETTINGS_APP_ROUTE),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<RecipesCubit, RecipesState>(
          builder: (context, RecipesState) {
            if (!(RecipesState is RecipesLoaded || RecipesState is RecipesEmpty)) {
              return const Center(child: CircularProgressIndicator());
            }
            var recipes = [];
            if (RecipesState is RecipesLoaded){
              recipes = (RecipesState as RecipesLoaded).recipes;
            } else if (RecipesState is RecipesEmpty){
              recipes = (RecipesState as RecipesEmpty).recipes;
              return ListView(
                padding: const EdgeInsets.all(10.0),
                children: [
                  _addRecipe(context),
                  Image(image: AssetImage('assets/default/empty_list.png')),
                ],
              );
            }

            return ListView(
              padding: const EdgeInsets.all(10.0),
              children: [
                _addRecipe(context),
                Column(
                  children: recipes.map((e) => _recipe(e, context)).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _addRecipe(context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, ADD_RECIPE_ROUTE),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Icon(Icons.add, color: Colors.blue),
                  Center(
                      child: Text(
                    "Add recipe",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  )),
                ],
              ),
            )),
      ),
    );
  }

  Widget _recipe(Recipe recipe, context) {
    // BlocProvider.of<IngredientsCubit>(context).fetchIngredients(recipe.id);
    // print(recipe.id);
    // return BlocBuilder<IngredientsCubit, IngredientsState>(
    //   builder: (context, IngredientsState) {
    //     List<Ingredient> ingredients = [];
    //     if (IngredientsState is IngredientsLoaded){
    //       ingredients = (IngredientsState as IngredientsLoaded).ingredients;
    //     }

         return Card(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            ),
            child: InkWell(
                // onTap: () => Navigator.pushNamed(context, DETAILS_RECIPE_ROUTE, arguments:  ScreenArguments(recipe: recipe, ingredient: ingredients)),
                onTap: () => Navigator.pushNamed(context, DETAILS_RECIPE_ROUTE, arguments: recipe),

                child: _recipeTile(recipe, context)));
    //   },
    // );
  }

  Widget _recipeTile(Recipe recipe, context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), topLeft: Radius.circular(15.0)),
                child: Image(image: AssetImage(recipe.imagePath)))
        ),
        SizedBox(
            width: 280,
            height: 100,
            child: Center(
                child: ListTile(
                  title: Text(recipe.recipeTitle),
                  subtitle: Text(recipe.recipeRecipe),
                )
            )
        ),
      ],
    );
  }
}
