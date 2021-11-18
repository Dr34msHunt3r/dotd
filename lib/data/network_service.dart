import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {

  final baseUrl = "http://10.0.2.2:3000";

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

}