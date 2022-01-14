import 'package:dotd/screens/edit_recipe_screen/edit_recipe_cubit.dart';
import 'package:dotd/api/model/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditRecipeScreen extends StatefulWidget {
  const EditRecipeScreen({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final _controllerTitle = TextEditingController();
  final _controllerRecipe = TextEditingController();

  late int _count;
  List<TextEditingController> _controller = [];

  @override
  void initState(){
    super.initState();
    _controllerTitle.text = widget.recipe.recipeTitle;
    _controllerRecipe.text = widget.recipe.recipeRecipe;
    if(widget.recipe.ingredients.isEmpty){
      _count = 0;
      _controller = [];
    }else{
      _count = widget.recipe.ingredients.length;
      for(var i=0; i < _count; i++){
        _controller.add(TextEditingController());
        _controller[i].text = widget.recipe.ingredients[i].name;
      }
    }

  }

  @override
  Widget build(BuildContext context) {

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
                  BlocProvider.of<EditRecipeCubit>(context).deleteRecipe(widget.recipe);
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
        Text("Recipe:"),
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
        const SizedBox(height: 25.0,),
        Text("Ingredients:"),
        _ingredientsList(context),
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
              SizedBox(height: 25,),
              const Text('Add Ingredient'),
              const SizedBox(height: 15.0,),
              _editRecipeBtn(context)
            ],
          ),
        ),
      ],
    );
  }

  Widget _ingredientsList(context){
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _count,
        itemBuilder: (context, index){
          return Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller[index],
                  decoration: InputDecoration(labelText: "Enter ingredient no. ${(index+1).toString()}"),
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    _controller.removeAt(index);
                    _count--;
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.delete),
                ),
              )
            ],
          );
        });
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
          List<Ingredient> updatedIngredients = [];
          _controller.forEach((element) {if(element.text !="") updatedIngredients.add(Ingredient(name: element.text));});
          final Recipe updatedRecipe = Recipe(
              recipeTitle: _controllerTitle.text,
              recipeRecipe: _controllerRecipe.text,
              imageUrl: widget.recipe.imageUrl,
              favourite: widget.recipe.favourite,
              ingredients: updatedIngredients,
              id: widget.recipe.id
          );
          BlocProvider.of<EditRecipeCubit>(context).updateRecipe(widget.recipe, updatedRecipe);
        },
        child: BlocBuilder<EditRecipeCubit, EditRecipeState>(
          builder: (context, state) {
            if(state is RecipeEdited){
              return const Center(
                child: SizedBox(
                    height: 16.0,
                    width: 16.0,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                ),
              );
            }
            return const Center(
              child: Text(
                "Save changes",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }


}