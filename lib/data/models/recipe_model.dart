import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class Recipe {

  Recipe({
  required this.recipeTitle,
  required this.recipeRecipe,
  required this.imageUrl,
  required this.favourite,
  required this.id
  });

  String recipeTitle;
  String recipeRecipe;
  String imageUrl;
  String favourite;
  String id;

  factory Recipe.fromJson(Map<String,dynamic> json) =>
      _$RecipeFromJson(json);
  Map<String,dynamic> toJson() => _$RecipeToJson(this);
}

String getImageUrl(String? imageUrl){
  if(imageUrl == null){
    return "assets/default/recipe_default_image.png";
  }else{
    return imageUrl.toString();
  }
}

String getFavourite(String? favourite){
  if(favourite == null){
    return "false";
  }else{
    return favourite.toString();
  }
}

String getId(String? id){
  if(id == null){
    return "";
  }else{
    return id.toString();
  }
}