// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      recipeTitle: json['recipeTitle'] as String,
      recipeRecipe: json['recipeRecipe'] as String,
      imageUrl: json['imageUrl'] as String,
      favourite: json['favourite'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'recipeTitle': instance.recipeTitle,
      'recipeRecipe': instance.recipeRecipe,
      'imageUrl': instance.imageUrl,
      'favourite': instance.favourite,
      'id': instance.id,
    };
