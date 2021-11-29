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

}