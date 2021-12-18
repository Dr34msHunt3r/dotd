import 'dart:convert';

import 'package:dotd/data/network_services/http_service.dart';
import 'package:http/http.dart' as https;

class RecipeNetworkService {

  final HttpService http = HttpService();
  final baseUrl = "http://10.0.2.2:3000";

  Future<List<dynamic>> fetchRecipes() async {
    try{
      final response = await http.getRequest("/recipes/get");
      if(response.statusCode ==200){}else{
        print(response.statusCode);
      }
      return jsonDecode(response.data) as List;
    }catch(e){
      print(e);
      return [];
    }
  }

  Future<Map<String, dynamic>> addRecipe(String recipeObj) async {
    try{
      final response = await https.post(Uri.parse(baseUrl + "/recipes/add"), body: {"recipe":recipeObj});
      return jsonDecode(response.body);
    }catch(e){
      print(e);
      return {};
    }
  }

  Future<bool> deleteRecipe(String id) async{
    try{
      await https.delete(Uri.parse(baseUrl + "/recipes/delete:id"), body: {"id": id});
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> putRecipe(String putObj) async{
    try{
      await https.put(Uri.parse(baseUrl + "/recipes/put:id"), body: {"recipe": putObj});
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

}