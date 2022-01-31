import 'package:auto_route/auto_route.dart';
import 'package:dotd/api/services/dto/recipe_dto.dart';
import 'package:dotd/config/app_assets.dart';
import 'package:dotd/extensions/flavor_config.dart';
import 'package:dotd/navigation/auto_router.gr.dart';
import 'package:dotd/screens/recipes_screen/recipes_cubit.dart';
import 'package:dotd/widgets/crash_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class RecipesScreen extends StatelessWidget{
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RecipesCubit>(context).fetchRecipes();
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipes from  ${FlavorConfig.instance.values.source}"),
        actions: [
          InkWell(
            onTap: () => context.router.push(SettingsAppScreen()),
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
              recipes = (RecipesState).recipes;
            } else if (RecipesState is RecipesEmpty){
              recipes = (RecipesState).recipes;
              return Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ListView(
                          padding: const EdgeInsets.all(10.0),
                          children: [
                            _addRecipe(context, context.router),
                            Image(image: AssetImage(AppAssets.emptyRecipeListImage)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: crashButton(context),
                        ),
                      ]
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ListView(
                        padding: const EdgeInsets.all(10.0),
                        children: [
                          _addRecipe(context, context.router),
                          Column(
                            children: recipes.map((e) => _recipe(e, context, context.router)).toList(),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: crashButton(context),
                      ),
                    ]
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _addRecipe(context, router) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () => router.push(AddRecipeScreen()),
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

  Widget _recipe(Recipe recipe, context, router) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
            onTap: () => router.push(DetailsRecipeScreen(recipe: recipe, recipeId: recipe.id!)),
            child: _recipeTile(recipe, context)
        )
    );
  }

  Widget _recipeTile(Recipe recipe, context) {
    return Row(
      children: [
        SizedBox(
            height: 100,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), topLeft: Radius.circular(15.0)),
                child: recipe.imageUrl == AppAssets.defaultRecipeImage
                    ?  Image(image: AssetImage(recipe.imageUrl), fit: BoxFit.cover,)
                    : Image.file(File(recipe.imageUrl), fit: BoxFit.cover,)
            )
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
