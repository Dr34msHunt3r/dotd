import 'dart:convert';

import 'package:http/http.dart' as http;

class RecipeNetworkService {

  final baseUrl = "http://10.0.2.2:3000";
  // final baseUrl = "http://192.168.1.8:3000";

  Future<List<dynamic>> fetchRecipes() async {
    try{
      final response = await http.get(Uri.parse(baseUrl + "/recipes/get"));
      print(response.body);
      return jsonDecode(response.body) as List;
    }catch(e){
      print(e);
      return [];
    }
  }

  Future<Map<String, dynamic>> addRecipe(String recipeObj) async {
    try{
      final response = await http.post(Uri.parse(baseUrl + "/recipes/add"), body: {"recipe": recipeObj});
      return jsonDecode(response.body);
    }catch(e){
      print(e);
      return {};
    }
  }

  Future<bool> deleteRecipe(String id) async{
    try{
      await http.delete(Uri.parse(baseUrl + "/recipes/delete:id"), body: {"id": id});
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> putRecipe(String putObj) async{
    try{
      await http.put(Uri.parse(baseUrl + "/recipes/put:id"), body: {"recipe": putObj});
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

}