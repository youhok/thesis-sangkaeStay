import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(String path, File imageFile) async {
    try {
      final ref = _storage.ref().child(path);

      // Upload the file
      await ref.putFile(imageFile);

      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }

  Future<void> removeImage(String path) async {
    try {
      final ref = _storage.ref().child(path);

      final metadata = await ref.getMetadata();

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