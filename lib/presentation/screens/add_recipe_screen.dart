import 'package:dotd/cubit/add_recipe_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddRecipeScreen extends StatelessWidget {
   AddRecipeScreen({Key? key}) : super(key: key);

  final _controllerTitle = TextEditingController();
  final _controllerSubtitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Recipe"),
      ),
      body: BlocListener<AddRecipeCubit, AddRecipeState>(
        listener: (context, state) {
          if(state is RecipeAdded){
            Navigator.pop(context);
            return;
          }else if(state is AddRecipeError){
            Fluttertoast.showToast(
                msg: state.error
            );
          }
        },
        child: Container(
                margin: const EdgeInsets.all(20.0),
                child: _body(context),
              ),
      )
    );
  }

  Widget _body(context){
    return Column(
      children: [
        TextField(
          controller: _controllerTitle,
          decoration: const InputDecoration(hintText: "Enter recipe title..."),
        ),
        const SizedBox(height: 10.0,),
        TextField(
          controller: _controllerSubtitle,
          decoration: const InputDecoration(hintText: "Enter recipe..."),
        ),
        const SizedBox(height: 15.0,),
        InkWell(
          onTap: (){
            final recipeTitle = _controllerTitle.text;
            final recipeRecipe = _controllerSubtitle.text;
            BlocProvider.of<AddRecipeCubit>(context).addRecipe(recipeTitle, recipeRecipe);
          },
            child: _addRecipeBtn(context)
        )
      ],
    );
  }

  Widget _addRecipeBtn(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: Center(
        child: BlocBuilder<AddRecipeCubit, AddRecipeState>(
          builder: (context, state) {
          if(state is AddingRecipe){
            return const SizedBox(
              height: 16.0,
                width: 16.0,
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
          }
          return const Text(
            "Add Recipe",
            style: TextStyle(
              color: Colors.white,
            ),
          );
          },
        ),
      ),

    );
  }
}