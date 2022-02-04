// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      recipeTitle: json['recipeTitle'] as String,
      recipeRecipe: json['recipeRecipe'] as String,
      imageUrl: json['imageUrl'] as String,
      favourite: json['favourite'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'recipeTitle': instance.recipeTitle,
      'recipeRecipe': instance.recipeRecipe,
      'imageUrl': instance.imageUrl,
      'favourite': instance.favourite,
      'ingredients': instance.ingredients,
      'id': instance.id,
    };

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      name: json['name'] as String,
      recipeId: json['recipeId'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'recipeId': instance.recipeId,
      'id': instance.id,
    };
