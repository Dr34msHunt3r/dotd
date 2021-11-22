import 'package:dotd/constants/strings.dart';
import 'package:dotd/cubit/recipes_cubit.dart';
import 'package:dotd/data/models/recipe.dart';
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
          builder: (context, state) {
            if (!(state is RecipesLoaded)) {
              return const Center(child: CircularProgressIndicator());
            }
            final recipes = (state as RecipesLoaded).recipes;

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
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, ADD_RECIPE_ROUTE),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: const [
                  Icon(Icons.add),
                  Center(
                      child: Text(
                    "Add recipe",
                    style: TextStyle(fontSize: 16),
                  )),
                ],
              ),
            )),
      ),
    );
  }

  Widget _recipe(Recipe recipe, context) {
    return Card(
        child: InkWell(
            onTap: () => Navigator.pushNamed(context, DETAILS_RECIPE_ROUTE, arguments: recipe),
            child: _recipeTile(recipe, context)));
  }

  Widget _recipeTile(Recipe recipe, context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Center(
            child: ListTile(
          title: Text(recipe.recipeTitle),
          subtitle: Text(recipe.recipeRecipe),
        )));
  }
}
