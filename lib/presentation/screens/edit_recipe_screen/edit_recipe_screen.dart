import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dotd/analytics/event_reporter.dart';
import 'package:dotd/analytics/firebase_event_reporter.dart';
import 'package:dotd/config/app_assets.dart';
import 'package:dotd/extensions/recipe_image_file_manager.dart';
import 'package:dotd/repository/recipe_repository/model/dto/recipe_dto.dart';
import 'package:dotd/presentation/screens/edit_recipe_screen/edit_recipe_cubit.dart';
import 'package:dotd/presentation/widgets/recipe_image_section/recipe_image_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';


class EditRecipeScreen extends StatefulWidget{
  const EditRecipeScreen({Key? key, required this.recipe, @PathParam() required this.recipeId}) : super(key: key);

  final Recipe recipe;
  final String recipeId;

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();

}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final _controllerTitle = TextEditingController();
  final _controllerRecipe = TextEditingController();

  late int _count;
  List<TextEditingController> _controller = [];

  String? imageUrl;
  String? oldImageUrl;

  @override
  void initState(){
    super.initState();
    if(widget.recipe.imageUrl != AppAssets.defaultRecipeImage) {
      imageUrl = widget.recipe.imageUrl;
      oldImageUrl = imageUrl;
    }
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
    FirebaseEventReporter _firebaseEventReporter = FirebaseEventReporter();
    _firebaseEventReporter.reportScreenView(EventReporter.EDIT_RECIPE_SCREEN_VIEWED);
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
      children: [
        RecipesImageSection(
            imageUrl: imageUrl,
            onImageChanged: (ImageSource source) async{
              final newImage = await selectImageSource(source, this.imageUrl);
              setState(() {
                this.imageUrl = newImage;
              });
            }
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
        onTap: () async{
          List<Ingredient> updatedIngredients = [];
          _controller.forEach((element) {if(element.text !="") updatedIngredients.add(Ingredient(name: element.text));});
          final Recipe updatedRecipe = Recipe(
              recipeTitle: _controllerTitle.text,
              recipeRecipe: _controllerRecipe.text,
              imageUrl: widget.recipe.imageUrl,
              imageCacheUrl: imageUrl,
              favourite: widget.recipe.favourite,
              ingredients: updatedIngredients,
              id: widget.recipe.id
          );
          BlocProvider.of<EditRecipeCubit>(context).updateRecipe(updatedRecipe);
        },
        child: BlocBuilder<EditRecipeCubit, EditRecipeState>(
          builder: (context, state) {
            if(state is EditingRecipe){
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