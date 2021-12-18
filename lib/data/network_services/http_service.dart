import 'dart:convert';

import 'package:dio/dio.dart';

class HttpService {
  late Dio _dio;

  final baseUrl = "http://10.0.2.2:3000";

  HttpService(){
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));
    initializeInterceptors();
  }

  Future<Response> getRequest(String endPoint) async {
    Response response;
    try{
      response = await _dio.get(endPoint);
    }on DioError catch(e){
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  Future<Response> postRequest(String endPoint, String recipeObj) async {
    Response response;
    try{
      response = await _dio.post(endPoint, data: {"recipe": recipeObj});
    }on DioError catch(e){
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  initializeInterceptors(){
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, errorInterceptorHandler){
        print(error.message);
      },
      onRequest: (request, RequestInterceptorHandler){
        print("${request.method} ${request.path}");
      },
      onResponse: (response, ResponseInterceptorHandler){
        print(response.data);
      },
    ));
  }
}