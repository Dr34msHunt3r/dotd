import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageCloudStorage {

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

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
  Future<bool> deleteFile(String filePath) async{
    try {
      await storage.refFromURL(filePath).delete();
      return true;
    } on Exception catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }
}