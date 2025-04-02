import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  // Create a single instance of FirebaseStorage
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload image and return its URL
  Future<String> uploadImage(String path, File imageFile) async {
    try {
      // Create reference to the storage path
      final ref = _storage.ref().child(path);

      // Upload the file
      await ref.putFile(imageFile);

      // Get and return the download URL
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }

  // Remove image from storage
  Future<void> removeImage(String path) async {
    try {
      // Create reference to the storage path
      final ref = _storage.ref().child(path);

      // Get metadata to check if file exists
      final metadata = await ref.getMetadata();

      // If file exists (size > 0), delete it
      if (metadata.size != null && metadata.size! > 0) {
        await ref.delete();
        print('Image deleted successfully');
      } else {
        print('Image does not exist in storage');
      }
    } catch (e) {
      print('Error deleting image: $e');
      rethrow;
    }
  }
}

// // How to use it:
// void exampleUsage() async {
//   final storage = StorageService();
  
//   try {
//     // Upload example
//     File imageFile = File('path/to/your/image.jpg');
//     String downloadUrl = await storage.uploadImage('images/myphoto.jpg', imageFile);
//     print('Image uploaded at: $downloadUrl');

//     // Delete example
//     await storage.removeImage('images/myphoto.jpg');
//   } catch (e) {
//     print('Error: $e');
//   }
// }




// final storage = StorageService();

// // Upload an image
// String url = await storage.uploadImage('users/profile.jpg', imageFile);

// // Delete an image
// await storage.removeImage('users/profile.jpg');