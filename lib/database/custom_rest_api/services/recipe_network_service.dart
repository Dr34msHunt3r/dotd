import 'package:dio/dio.dart';

class RecipeNetworkService {

  var dio = Dio();

  final baseUrl = "http://10.0.2.2:3000";

  Future<List<dynamic>> fetchRecipes() async {
    try{
      final response = await dio.get(baseUrl+"/recipes/get");
      if(response.statusCode ==200){}else{
        print(response.statusCode);
      }
      print(response.data);
      return response.data;
    }catch(e){
      print(e);
      return [];
    }
  }

  Future<Map<String, dynamic>> addRecipe(String recipeObj) async {
    try{
      final response = await dio.post(baseUrl + "/recipes/add", data: {"recipe":recipeObj});
      return response.data;
    }catch(e){
      throw Exception('Adding recipe failed: ${e}');
    }
  }

  Future<bool> deleteRecipe(String id) async{
    try{
      await dio.delete(baseUrl + "/recipes/delete:id", data: {"id": id});
      return true;
    }catch(e){
      throw Exception('Deleting recipe failed: ${e}');
    }
  }

  Future<bool> putRecipe(String putObj) async{
    try{
      await dio.put(baseUrl + "/recipes/put:id", data: {"recipe": putObj});
      return true;
    }catch(e){
      throw Exception('Updating recipe failed: ${e}');
    }
  }

}