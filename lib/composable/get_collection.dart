import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

typedef QueryCallback<T> = void Function(List<T> data);

Future<StreamSubscription?> getCollectionQuery<T>({
  required String collectionName,
  List<Query<dynamic>>? whereDoc,
  QueryCallback<T>? callback,
  String? docID,
  bool useSnapshot = false,
}) async {
  final collectionRef = FirebaseFirestore.instance.collection(collectionName);

  // Create a query based on whereDoc (if provided)
  Query queryRef = collectionRef;
  if (whereDoc != null) {
    queryRef = whereDoc.reduce((Query query, Query next) => query.where(next));
  }

  try {
    if (useSnapshot) {
      final subscription =
          queryRef.snapshots(includeMetadataChanges: true).listen(
        (snapshot) {
          final data = snapshot.docs.map((doc) {
            final docData = doc.data() as Map<String, dynamic>;
            return {'id': doc.id, ...docData} as T;
          }).toList();

          if (callback != null) {
            callback(data);
          }
        },
        onError: (error) {
          print('Error in getCollectionQuery snapshot: $error');
        },
      );
      return subscription;
    } else {
      final snapshot = await queryRef.get();
      final data = snapshot.docs.map((doc) {
        final docData = doc.data() as Map<String, dynamic>;
        return {'id': doc.id, ...docData} as T;
      }).toList();

      if (callback != null) {
        callback(data);
      }
    }

    if (docID != null) {
      final docRef =
          FirebaseFirestore.instance.collection(collectionName).doc(docID);

      final documentSnapshot = await docRef.get();

      if (documentSnapshot.exists) {
        final docData = documentSnapshot.data() as Map<String, dynamic>;
        final data = {'id': documentSnapshot.id, ...docData} as T;

        if (callback != null) {
          callback([data]);
        }

        return null;
      } else {
        print('Document does not exist');
      }
    }
  } catch (error) {
    print('Error in getCollectionQuery: $error');
  }

  return null;
}


// 🪓Usage

// 1️⃣ Listening to a Firestore Collection in Real-Time

// StreamSubscription? subscription = await getCollectionQuery<Map<String, dynamic>>(
//   collectionName: 'users',
//   useSnapshot: true, // Enable real-time updates
//   callback: (data) {
//     print('Updated user list: $data');
//   },
// );

// // Later, cancel the subscription when no longer needed
// subscription?.cancel();


// 2️⃣ Fetching Data Once (Without Real-Time Updates)

// await getCollectionQuery<Map<String, dynamic>>(
//   collectionName: 'products',
//   callback: (data) {
//     print('Fetched product list: $data');
//   },
// );

// 3️⃣ Querying with Filters (Where Conditions)

// Query usersAbove18 = FirebaseFirestore.instance.collection('users').where('age', isGreaterThan: 18);

// await getCollectionQuery<Map<String, dynamic>>(
//   collectionName: 'users',
//   whereDoc: [usersAbove18], // Apply filters
//   callback: (data) {
//     print('Users above 18: $data');
//   },
// );

// 4️⃣ Fetching a Specific Document by ID

// await getCollectionQuery<Map<String, dynamic>>(
//   collectionName: 'orders',
//   docID: 'order123',
//   callback: (data) {
//     if (data.isNotEmpty) {
//       print('Fetched order details: ${data.first}');
//     } else {
//       print('Order not found.');
//     }
//   },
// );
