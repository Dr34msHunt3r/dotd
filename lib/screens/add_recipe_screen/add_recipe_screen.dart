import 'dart:io';
import 'package:dotd/analytics/event_reporter.dart';
import 'package:dotd/analytics/firebase_event_reporter.dart';
import 'package:dotd/config/app_assets.dart';
import 'package:dotd/database/custom_rest_api/services/dto/recipe_dto.dart';
import 'package:dotd/extensions/recipe_image_file_manager.dart';
import 'package:dotd/screens/add_recipe_screen/add_recipe_cubit.dart';
import 'package:dotd/widgets/recipe_image_section/recipe_image_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

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

  String? imageUrl;
  File? oldImage;

  @override
  void initState(){
    super.initState();
    _count = 0;
    _controller = [];
  }

  @override
  Widget build(BuildContext context) {
    FirebaseEventReporter _firebaseEventReporter = FirebaseEventReporter();
    _firebaseEventReporter.reportScreenView(EventReporter.ADD_RECIPE_SCREEN_VIEWED);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Recipe"),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<AddRecipeCubit, AddRecipeState>(
              listener: (context, state) {
                if (state is RecipeAdded) {
                  Navigator.pop(context);
                  return;
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
          ),
        ),
      ]
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
        onTap: () async{
          final List<Ingredient> newIngredients = [];
          _controller.forEach((element) {if(element.text !="") newIngredients.add(Ingredient(name: element.text));});
          final Recipe newRecipe = Recipe(
              recipeTitle: _controllerRecipeTitle.text,
              recipeRecipe: _controllerRecipeSubtitle.text,
              imageUrl: AppAssets.defaultRecipeImage,
              imageCacheUrl: imageUrl,
              favourite: "false",
              ingredients: newIngredients,
          );
          BlocProvider.of<AddRecipeCubit>(context).addRecipe(newRecipe);
        },
        child: BlocBuilder<AddRecipeCubit, AddRecipeState>(
          builder: (context, AddRecipeState) {
            if (AddRecipeState is AddingRecipe) {
              return const Center(
                child: SizedBox(
                    height: 16.0,
                    width: 16.0,
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white)
                    )
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
        ),
      ),
    );
  }
}