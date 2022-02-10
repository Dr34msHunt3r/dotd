import 'dart:io';

import 'package:dotd/database/custom_rest_api/services/dto/recipe_dto.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageCloudStorage {

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  // CollectionReference recipeImages = FirebaseFirestore.instance.collection('recipe');

  Recipe testObject() {
    return new Recipe(
        id: 'testerId-02',
        ingredients: [],
        imageUrl: "/data/user/0/com.example.dotd.app4/app_flutter/image_picker8435844863520007922.jpg",
        // imageUrl: 'assets/default/recipe_default_image.jpg',
        favourite: '',
        recipeRecipe: 'Test Object',
        recipeTitle: 'Test Object'
    );
  }

  // Future<void> addRecipeImage(String imageUrl, String recipeId) async{
  //   return File(imageUrl).readAsBytes()
  //     // rootBundle
  //     //   .load(imageUrl)
  //       .then((bytes) => bytes.buffer.asUint8List())
  //       .then((convertedImage) {
  //       return recipeImages
  //         .doc(recipeId)
  //         .set({
  //           'imageInfo' : Blob(convertedImage),
  //           'recipeId' : recipeId
  //         });
  //       })
  //       .then((value) => print("Image Added"))
  //       .catchError((error) => throw Exception("Failed to add image: $error"));
  // }

  // Future<void> loadRecipeImages() async {
  //   try {
  //     final List list = [];
  //     final result = await recipeImages
  //         .get();
  //     final data = result.docs;
  //     // print(data);
  //     data.forEach((element) {
  //       final _element = element.data();
  //       if(_element!=null)
  //       list.add(_element);
  //     });
  //     //TODO: zwrócić listę obrazów
  //     print(list[0]['imageInfo']);
  //   } on Exception catch (e) {
  //     throw Exception('Failed to update image: $e');
  //   }
  // }
//TODO: recipe.id i recipe.image
//   Future<void> updateRecipeImage() async {
//     return rootBundle
//         .load('assets/default/empty_list.jpg')
//         .then((bytes) => bytes.buffer.asUint8List())
//         .then((avatar) {
//       return recipeImages
//           .doc('1')
//           .update({"imageInfo": Blob(avatar)});
//     })
//         .then((value) => print("Image Updated"))
//         .catchError((error) => throw Exception("Failed to update image: $error"));
//   }

  // Future<void> deleteRecipeImage(String recipeId) async {
  //   return recipeImages
  //       .doc(recipeId)
  //       .delete()
  //       .then((value) => print("Image's Property Deleted"))
  //       .catchError((error) => throw Exception("Failed to delete image's property: $error"));
  // }

  Future<void> listExample() async {
    final List images = [];
    firebase_storage.ListResult result =
    await firebase_storage.FirebaseStorage.instance.ref().listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      images.add(ref);
      print('Found file: $ref');
    });

    result.prefixes.forEach((firebase_storage.Reference ref) {
      print('Found directory: $ref');
    });
    print(images[0]);
  }

  Future<String?> uploadFile(String filePath, String recipeId) async {
    File file = File(filePath);
    try {
      await storage
          .ref(recipeId)
          .putFile(file);
      return await storage
          .ref(recipeId)
          .getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}