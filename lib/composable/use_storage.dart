import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class UseStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Maximum file size in bytes (2MB)
  static const int maxFileSize = 2 * 1024 * 1024;

  // Allowed image extensions
  static const List<String> allowedExtensions = ['jpeg', 'jpg', 'png'];

  Future<String?> uploadImage(String storagePath, File imageFile) async {
    try {
      // Validate file size
      if (imageFile.lengthSync() > maxFileSize) {
        throw Exception('File size exceeds 2MB limit');
      }

      // Validate file extension
      final extension =
          path.extension(imageFile.path).toLowerCase().replaceAll('.', '');
      if (!allowedExtensions.contains(extension)) {
        throw Exception(
            'Invalid file type. Only JPEG, JPG, and PNG files are allowed');
      }

      // Validate storage path
      if (!storagePath.startsWith('/user/profile') &&
          !storagePath.startsWith('/user/properties')) {
        throw Exception(
            'Invalid storage path. Must start with /user/profile or /user/properties');
      }

      // Create a reference to the file location
      final ref = _storage.ref().child(storagePath);

      // Upload the file
      await ref.putFile(imageFile);

      // Get the download URL
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }

  Future<void> removeImage(String storagePath) async {
    try {
      // Validate storage path
      if (!storagePath.startsWith('/user/profile') &&
          !storagePath.startsWith('/user/properties')) {
        throw Exception(
            'Invalid storage path. Must start with /user/profile or /user/properties');
      }

      // Create a reference to the file location
      final ref = _storage.ref().child(storagePath);

      // Check if file exists
      try {
        await ref.getMetadata();
        // If we get here, the file exists
        await ref.delete();
        print('Image deleted successfully');
      } catch (e) {
        if (e is FirebaseException && e.code == 'object-not-found') {
          print('Image does not exist in storage');
        } else {
          rethrow;
        }
      }
    } catch (e) {
      print('Error deleting image: $e');
      rethrow;
    }
  }
}

// Create a singleton instance
final useStorage = UseStorage();

/*
🪓 Usage Examples:

1️⃣. Profile Image (Single Image):
   - Path format: /user/profile/{userId}.jpg
   - Example:
     final profileImage = File('path/to/profile.jpg');
     try {
       final downloadUrl = await useStorage.uploadImage(
         '/user/profile/user123.jpg',
         profileImage
       );
       print('Profile image uploaded: $downloadUrl');
     } catch (e) {
       print('Profile upload failed: $e');
     }

3️⃣ Property Images (Multiple Images):
   - Path format: /user/properties/{propertyId}/{imageIndex}.jpg
   - Example:
     final propertyImages = [
       File('path/to/property1.jpg'),
       File('path/to/property2.jpg'),
       File('path/to/property3.jpg')
     ];
     
     try {
       final List<String> uploadedUrls = [];
       for (var i = 0; i < propertyImages.length; i++) {
         final downloadUrl = await useStorage.uploadImage(
           '/user/properties/property123/image$i.jpg',
           propertyImages[i]
         );
         uploadedUrls.add(downloadUrl!);
       }
       print('Property images uploaded: $uploadedUrls');
     } catch (e) {
       print('Property images upload failed: $e');
     }

4️⃣ Removing Images:
   // Remove profile image
   try {
     await useStorage.removeImage('/user/profile/user123.jpg');
   } catch (e) {
     print('Profile image deletion failed: $e');
   }

   // Remove property image
   try {
     await useStorage.removeImage('/user/properties/property123/image0.jpg');
   } catch (e) {
     print('Property image deletion failed: $e');
   }
*/
