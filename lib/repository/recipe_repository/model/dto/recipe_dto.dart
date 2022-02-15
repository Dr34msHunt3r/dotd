import 'package:json_annotation/json_annotation.dart';

part 'recipe_dto.g.dart';

@JsonSerializable()
class Recipe {

  Recipe({
  required this.recipeTitle,
  required this.recipeRecipe,
  required this.imageUrl,
    this.imageCacheUrl,
  required this.favourite,
  required this.ingredients,
    this.id
  });

  final String recipeTitle;
  final String recipeRecipe;
  final String imageUrl;
  @JsonKey(ignore: true)
  final String? imageCacheUrl;
  final String favourite;
  final List<Ingredient> ingredients;
  final String? id;

  factory Recipe.fromJson(Map<String,dynamic> json) =>
      _$RecipeFromJson(json);
  Map<String,dynamic> toJson() => _$RecipeToJson(this);
}

@JsonSerializable()
class Ingredient {

  Ingredient({
    required this.name,
    this.recipeId,
    this.id
  });

  String name;
  String? recipeId;
  String? id;

  factory Ingredient.fromJson(Map<String,dynamic> json) =>
      _$IngredientFromJson(json);
  Map<String,dynamic> toJson() => _$IngredientToJson(this);
}

String getImageUrl(String? imageUrl){
  if(imageUrl == null){
    return "assets/default/recipe_default_image.jpg";
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