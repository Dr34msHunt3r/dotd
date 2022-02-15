import 'package:dotd/config/app_assets.dart';
import 'package:flutter/material.dart';
import 'dart:io';

Widget imageSourceDisplayer(String? imageUrl){
  if(imageUrl == AppAssets.defaultRecipeImage || imageUrl == null){
    return Image(image: AssetImage(AppAssets.defaultRecipeImage), fit: BoxFit.cover,);
  }else if(imageUrl.contains('http')){
    return Image.network(imageUrl, fit: BoxFit.cover,);
  }else{
    return Image.file(File(imageUrl), fit: BoxFit.cover,);
  }
}