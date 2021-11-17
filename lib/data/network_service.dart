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

}