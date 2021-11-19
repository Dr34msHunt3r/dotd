import 'package:dotd/data/models/recipe.dart';
import 'package:flutter/material.dart';

class EditRecipeScreen extends StatelessWidget {
  EditRecipeScreen({Key? key, required this.recipe}) : super(key: key);

  final _controllerTitle = TextEditingController();
  final _controllerRecipe = TextEditingController();

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    _controllerTitle.text = recipe.recipeTitle;
    _controllerRecipe.text = recipe.recipeRecipe;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Recipe"),
      ),
      body: SafeArea(
        child: _body(context),
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
          autocorrect: true, style:
        const TextStyle(fontSize: 20),
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
    return Material(
      child: Ink(
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10.0)
        ),
        child: InkWell(
          onTap: () {},
          child: const Center(
             child: Text(
                "Save changes",
                style: TextStyle(
                color: Colors.white,
                ),
              ),
          ),
        ),
      ),
    );
  }
}