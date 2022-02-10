import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

Future<String?> selectImageSource(ImageSource source, String? oldImage) async{
  try {
    final newImage = await ImagePicker().pickImage(source: source);
    if (newImage == null){
      return oldImage;
    }else{
      return newImage.path;
    }
  } catch (e) {
    throw Exception('Failed to pick image: ${e}');
  }
}

Future<File> saveNewImage(String imagePath) async{
  try {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    File image = File('${directory.path}/${name}');
    return File(imagePath).copy(image.path);
  } catch (e) {
    throw Exception('Failed to save new image: ${e}');
  }
}

Future<File> replaceImage(String imagePath, File? image) async{
  try {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(image!.path);
    image = File('${directory.path}/${name}');
    return File(imagePath).copy(image.path);
  } catch (e) {
    throw Exception('Failed to replace image: ${e}');
  }
}

Future<String?> setImage(String? path, String? oldImageUrl) async{
  try {
    if(path!=null && oldImageUrl!=null){
      imageCache!.clearLiveImages();
      imageCache!.clear();
      return (await replaceImage(path, File(oldImageUrl))).path;
    }else if(path!=null && oldImageUrl==null){
      return (await saveNewImage(path)).path;
    }
  } catch (e) {
    throw Exception('Failed to preset image: ${e}');
  }
}