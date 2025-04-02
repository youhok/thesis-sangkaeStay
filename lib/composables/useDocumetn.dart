import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final String collectionName;
  late final CollectionReference collectionRef;

  FirestoreService(this.collectionName) {
    collectionRef = FirebaseFirestore.instance.collection(collectionName);
  }

  Future<bool> addDocument(Map<String, dynamic> document) async {
    try {
      await collectionRef.add(document);
      return true;
    } catch (e) {
      print('Failed to add data: $e');
      return false;
    }
  }

  Future<bool> setDocument(String id, Map<String, dynamic> document) async {
    try {
      await collectionRef.doc(id).set(document);
      return true;
    } catch (e) {
      print('Failed to set data: $e');
      return false;
    }
  }

  Future<bool> removeDocument(String id) async {
    try {
      await collectionRef.doc(id).delete();
      return true;
    } catch (e) {
      print('Failed to delete data: $e');
      return false;
    }
  }

  Future<bool> updateDocument(String id, Map<String, dynamic> document) async {
    try {
      await collectionRef.doc(id).update(document);
      return true;
    } catch (e) {
      print('Error updating document: $e');
      return false;
    }
  }
}


// void main() async {
//   // Create an instance of FirestoreService for a specific collection
//   FirestoreService firestoreService = FirestoreService('your_collection_name');

//   // Example document
//   Map<String, dynamic> newDocument = {
//     'name': 'John Doe',
//     'age': 30,
//     'email': 'john.doe@example.com'
//   };

//   // Adding a document
//   bool addResult = await firestoreService.addDocument(newDocument);
//   print('Add result: $addResult');

//   // Setting a document with a specific ID
//   bool setResult = await firestoreService.setDocument('specific_doc_id', newDocument);
//   print('Set result: $setResult');

//   // Updating a document
//   Map<String, dynamic> updatedData = {
//     'age': 31
//   };
//   bool updateResult = await firestoreService.updateDocument('specific_doc_id', updatedData);
//   print('Update result: $updateResult');

//   // Removing a document
//   bool removeResult = await firestoreService.removeDocument('specific_doc_id');
//   print('Remove result: $removeResult');
// }