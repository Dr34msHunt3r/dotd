import 'package:dotd/cubit/ingredients_cubits/add_ingredient_cubit.dart';
import 'package:dotd/cubit/recipe_cubits/add_recipe_cubit.dart';
import 'package:dotd/data/models/ingredients.dart';
import 'package:dotd/data/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddRecipeScreen extends StatefulWidget {
  AddRecipeScreen({Key? key}) : super(key: key);

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();


}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _controllerRecipeTitle = TextEditingController();

  final _controllerRecipeSubtitle = TextEditingController();

  late int _count;
  late List<TextEditingController> _controller;
  @override
  void initState(){
    super.initState();
    _count = 0;
    _controller = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Recipe"),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<AddIngredientCubit, AddIngredientsState>(
              listener: (context, state) {
                if (state is IngredientsAdded) {
                  Navigator.pop(context);
                  return;
                }
              },
            ),
            BlocListener<AddRecipeCubit, AddRecipeState>(
              listener: (context, state) {
                if (state is RecipeAdded) {
                  Recipe recipe = (state as RecipeAdded).recipe;
                  List<Ingredient> ingredients = [];
                  _controller.forEach((element) {ingredients.add(Ingredient(recipeId: recipe.id, name: element.text, ));});

                  BlocProvider.of<AddIngredientCubit>(context).addIngredient(
                      ingredients);
                } else if (state is AddRecipeError) {
                  Fluttertoast.showToast(
                      msg: state.error
                  );
                }
              },
            ),
          ],
          child: SafeArea(
            child: _body(context),
          ),
        )
    );
  }

  Widget _body(context) {
    return ListView(
      padding: const EdgeInsets.all(25.0),
      children: [
        TextField(
          controller: _controllerRecipeTitle,
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(labelText: "Enter title"),
        ),
        const SizedBox(height: 10.0,),
        TextField(
          controller: _controllerRecipeSubtitle,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: const InputDecoration(labelText: "Enter recipe"),
        ),
        const SizedBox(height: 10.0,),
        ListView.builder(
          shrinkWrap: true,
            itemCount: _count,
            itemBuilder: (context, index){
            return TextField(
              controller: _controller[index],
              decoration: InputDecoration(labelText: "Enter ingredient no. ${(index+1).toString()}"),
            );
            }),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              _count++;
              _controller.add(TextEditingController());
            });
          },
          child: Column(
            children: [
              const Text('Add Ingredient'),
              const SizedBox(height: 15.0,),
              _addRecipeBtn(context)
            ],
          ),
        ),

      ],
    );
  }

  Widget _addRecipeBtn(context) {
    return Ink(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: InkWell(
        onTap: () {
          final recipeTitle = _controllerRecipeTitle.text;
          final recipeRecipe = _controllerRecipeSubtitle.text;
          BlocProvider.of<AddRecipeCubit>(context).addRecipe(
              recipeTitle, recipeRecipe);
        },
        child: BlocBuilder<AddRecipeCubit, AddRecipeState>(
          builder: (context, AddRecipeState) {
            return BlocBuilder<AddIngredientCubit, AddIngredientsState>(
              builder: (context, AddIngredientState) {
                if (AddRecipeState is AddingRecipe ||
                    AddIngredientState is AddingIngredients) {
                  return const Center(
                    child: SizedBox(
                        height: 16.0,
                        width: 16.0,
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white))
                    ),
                  );
                }
                return const Center(
                  child: Text(
                    "Add recipe",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}