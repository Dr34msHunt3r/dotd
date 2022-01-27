import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

Future<File?> selectImageSource(ImageSource source, File? oldImage) async{
  try {
    final newImage = await ImagePicker().pickImage(source: source);
    if (newImage == null){
      return oldImage;
    }else{
      return File(newImage.path);
    }
  } catch (e) {
    throw Exception('Failed to pick image: ${e}');
  }
}

Future<File> saveNewImage(String imagePath, File? image) async{
  try {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    image = File('${directory.path}/${name}');
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

Future<File?> setImage(String? path, File? oldImage) async{
  try {
    if(path!=null && oldImage!=null){
      imageCache!.clearLiveImages();
      imageCache!.clear();
      return await replaceImage(path, oldImage);
    }else if(path!=null && oldImage==null){
      return await saveNewImage(path, oldImage);
    }
  } catch (e) {
    throw Exception('Failed to preset image: ${e}');
  }
}