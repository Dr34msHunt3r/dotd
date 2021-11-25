import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {

  final baseUrl = "http://10.0.2.2:3000";
  // final baseUrl = "http://192.168.1.8:3000";

  Future<List<dynamic>> fetchRecipes() async {
    try{
      final response = await http.get(Uri.parse(baseUrl + "/recipes"));
      print(response.body);
      return jsonDecode(response.body) as List;
    }catch(e){
      print(e);
      return [];
    }
  }

  Future<Map> addRecipe(Map<String, String> recipeObj) async {
    try{
      final response = await http.post(Uri.parse(baseUrl + "/recipes"), body: recipeObj);
      print(response.body);
      return jsonDecode(response.body);
    }catch(e){
      print(e);
      return {};
    }
  }

  Future<bool> deleteRecipe(int id) async{
    try{
      await http.delete(Uri.parse(baseUrl + "/recipes/$id"));
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  putRecipe(Map<String, String> putObj, int id) async{
    try{
      await http.put(Uri.parse(baseUrl + "/recipes/$id"), body: putObj);
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

}