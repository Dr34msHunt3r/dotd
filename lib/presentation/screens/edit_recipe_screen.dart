import 'package:dotd/cubit/edit_recipe_cubit.dart';
import 'package:dotd/data/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../router.dart';

class EditRecipeScreen extends StatelessWidget {
  EditRecipeScreen({Key? key, required this.recipe}) : super(key: key);

  final _controllerTitle = TextEditingController();
  final _controllerRecipe = TextEditingController();

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    // TODO: find out why can not edit TextField while _controller.text is set
    // _controllerTitle.text = recipe.recipeTitle;
    // _controllerRecipe.text = recipe.recipeRecipe;

    return BlocListener<EditRecipeCubit, EditRecipeState>(
      listener: (context, state) {
        if (state is RecipeEdited){
          Navigator.of(context).popUntil((route) => route.isFirst);
        }else if(state is EditRecipeError){
          Fluttertoast.showToast(msg: state.error);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Edit Recipe"),
            actions: [
              InkWell(
                onTap: (){
                  BlocProvider.of<EditRecipeCubit>(context).deleteRecipe(recipe);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.delete),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: _body(context),
          ),
      ),
    );
  }

  Widget _body(context){
    return ListView(
      padding: const EdgeInsets.all(30.0),
      children: [
        const SizedBox(height: 100.0,),
        const Text("Edit your future image here :)   📝️️", style: TextStyle(fontSize: 20),),
        const SizedBox(height: 100.0,),
        TextField(
          controller: _controllerTitle,
          autocorrect: true,
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(labelText: "Enter title"),
        ),
        const SizedBox(height: 25.0,),
        TextField(
          controller: _controllerRecipe,
          autocorrect: true,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: const InputDecoration(labelText: "Enter recipe"),
        ),
        const SizedBox(height: 100.0,),
        _editRecipeBtn(context)
      ],
    );
  }

  Widget _editRecipeBtn(context){
    return Ink(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: InkWell(
        onTap: () {
          Recipe updatedRecipe = Recipe(recipeTitle: _controllerTitle.text, recipeRecipe: _controllerRecipe.text, id: recipe.id);
          BlocProvider.of<EditRecipeCubit>(context).updateRecipe(recipe, updatedRecipe);
        },
        child: const Center(
           child: Text(
              "Save changes",
              style: TextStyle(
              color: Colors.white,
              ),
            ),
        ),
      ),
    );
  }
}