import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

typedef CollectionCallback = void Function(List<Map<String, dynamic>>);
typedef DocumentCallback = void Function(Map<String, dynamic>);

Future<StreamSubscription?> getCollectionQuery(
  String collectionName,
  List<Query<dynamic>>? whereDoc,
  dynamic callback, {
  String? docID,
  bool useSnapshot = false,
}) async {
  final collectionRef = FirebaseFirestore.instance.collection(collectionName);

  // Create a query based on whereDoc (if provided)
  Query queryRef = collectionRef;
  if (whereDoc != null) {
    queryRef =
        whereDoc.reduce((Query value, Query element) => value.where(element));
  }

  try {
    if (useSnapshot) {
      final subscription =
          queryRef.snapshots(includeMetadataChanges: true).listen(
        (snapshot) {
          final data = snapshot.docs
              .map((doc) => <String, dynamic>{
                    'id': doc.id,
                    ...(doc.data() as Map<String, dynamic>)
                  })
              .toList();
          if (callback != null) {
            (callback as CollectionCallback)(data);
          }
        },
      );

      return subscription;
    } else {
      final snapshot = await queryRef.get();
      final data = snapshot.docs
          .map((doc) => <String, dynamic>{
                'id': doc.id,
                ...(doc.data() as Map<String, dynamic>)
              })
          .toList();
      if (callback != null) {
        (callback as CollectionCallback)(data);
      }
    }

    if (docID != null) {
      final docRef = collectionRef.doc(docID);
      final documentSnapshot = await docRef.get();
      if (documentSnapshot.exists) {
        final data = <String, dynamic>{
          'id': documentSnapshot.id,
          ...(documentSnapshot.data() ?? {})
        };
        if (callback != null) {
          (callback as DocumentCallback)(data);
        }
        return null;
      } else {
        print("Document does not exist");
      }
    }
  } catch (error) {
    print("Error in getCollectionQuery: $error");
  }
  return null;
}


// 1. Basic Use Case (Fetching a Collection Once)

// getCollectionQuery("users", null, (List<Map<String, dynamic>> data) {
//   print("Fetched users: $data");
// });

// 2. 2. Fetch Collection with Real-time Updates

// StreamSubscription? subscription = await getCollectionQuery(
//   "users",
//   null,
//   (List<Map<String, dynamic>> data) {
//     print("Live user data: $data");
//   },
//   useSnapshot: true,
// );

