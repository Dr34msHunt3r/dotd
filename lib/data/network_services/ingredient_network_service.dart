import 'dart:convert';

import 'package:http/http.dart' as http;

class IngredientNetworkService {

  final baseUrl = "http://10.0.2.2:3000";
  // final baseUrl = "http://192.168.1.8:3000";

  Future<List<dynamic>> fetchIngredients() async {
    try{
      final response = await http.get(Uri.parse(baseUrl + "/ingredients"));
      print(response.body);
      return jsonDecode(response.body) as List;
    }catch(e){
      print(e);
      return [];
    }
  }

  Future<Map> addIngredient(Map<String, String> ingredientObj, recipeId) async {
    try{
      final response = await http.post(Uri.parse(baseUrl + "/recipes/$recipeId/ingredients"), body: ingredientObj);
      print(response.body);
      return jsonDecode(response.body);
    }catch(e){
      print(e);
      return {};
    }
  }

  Future<bool> deleteIngredient(int id) async{
    try{
      await http.delete(Uri.parse(baseUrl + "/ingredients/$id"));
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  putIngredient(Map<String, String> putIngredientObj, int id) async{
    try{
      await http.put(Uri.parse(baseUrl + "/ingredients/$id"), body: putIngredientObj);
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

}