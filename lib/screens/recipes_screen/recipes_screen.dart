import 'package:dotd/constants/strings.dart';
import 'package:dotd/extensions/flavor_config.dart';
import 'package:dotd/screens/recipes_screen/recipes_cubit.dart';
import 'package:dotd/api/model/recipe_model.dart';
import 'package:dotd/navigation/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RecipesCubit>(context).fetchRecipes();
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipes from ${FlavorConfig.instance.values.source}"),
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
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
            onTap: () => Navigator.pushNamed(context, DETAILS_RECIPE_ROUTE,
                arguments:  ScreenArguments(recipe: recipe)),
            child: _recipeTile(recipe, context)
        )
    );
  }

  Widget _recipeTile(Recipe recipe, context) {
    return Row(
      children: [
        SizedBox(
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), topLeft: Radius.circular(15.0)),
                child: Image(image: AssetImage(recipe.imageUrl)))
        ),
        Expanded(
          child: SizedBox(
              height: 100,
              child: Center(
                  child: ListTile(
                    title: Text(
                      recipe.recipeTitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    subtitle: Text(
                        recipe.recipeRecipe,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                    ),
                  )
              )
          ),
        ),
      ],
    );
  }
}
