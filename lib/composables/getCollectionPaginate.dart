import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class GetCollectionPaginate {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String pathCollection;
  final List<Query> queryDocs;
  final Function(List<Map<String, dynamic>>)? callback;

  List<Map<String, dynamic>> documents = [];
  String? error;
  StreamSubscription<QuerySnapshot>? _subscription;

  GetCollectionPaginate({
    required this.pathCollection,
    required this.queryDocs,
    this.callback,
  }) {
    getData();
  }

  // Get collection reference
  CollectionReference get collectionRef =>
      _firestore.collection(pathCollection);

  // Get query snapshot with provided query conditions
  Query get querySnapshot => queryDocs.fold<Query>(
        collectionRef,
        (Query query, Query queryDoc) => queryDoc,
      );

  // Function to get previous page
  Future<List<Map<String, dynamic>>> previousPage(
      String page, int newLimited) async {
    try {
      final firstVisible =
          await _firestore.collection(pathCollection).doc(page).get();

      final newQuery =
          querySnapshot.endBeforeDocument(firstVisible).limitToLast(newLimited);

      await getDataWithQuery(newQuery);
      return documents;
    } catch (err) {
      error = err.toString();
      return [];
    }
  }

  // Function to get next page
  Future<List<Map<String, dynamic>>> nextPage(
      String page, int newLimited) async {
    try {
      final firstVisible =
          await _firestore.collection(pathCollection).doc(page).get();

      final newQuery =
          querySnapshot.startAfterDocument(firstVisible).limit(newLimited);

      await getDataWithQuery(newQuery);
      return documents;
    } catch (err) {
      error = err.toString();
      return [];
    }
  }

  // Get collection length from server
  Future<int> getCollectionLength(
      String collectionName, List<Query> conditions) async {
    try {
      final colRef = _firestore.collection(collectionName);
      final q = conditions.fold<Query>(
        colRef,
        (Query query, Query condition) => condition,
      );

      final res = await q.count().get();
      return res.count ?? 0;
    } catch (err) {
      error = err.toString();
      return 0;
    }
  }

  // Get data with specific query
  Future<void> getDataWithQuery(Query query) async {
    try {
      final snapshot = await query.get();
      documents = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {'id': doc.id, ...data};
      }).toList();

      if (callback != null) {
        callback!(documents);
      }
    } catch (err) {
      error = err.toString();
    }
  }

  // Listen to real-time updates
  void getData() {
    _subscription?.cancel();
    _subscription = querySnapshot.snapshots().listen(
      (snapshot) {
        documents = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {'id': doc.id, ...data};
        }).toList();

        if (callback != null) {
          callback!(documents);
        }
      },
      onError: (err) {
        error = err.toString();
      },
    );
  }

  // Clean up subscription when done
  void dispose() {
    _subscription?.cancel();
  }
}


// void main() async {
//   // Example usage of GetCollectionPaginate
//   List<Query> queries = [
//     FirebaseFirestore.instance.collection('your_collection').where('field', isEqualTo: 'value'),
//     // Add more queries as needed
//   ];

//   GetCollectionPaginate paginator = GetCollectionPaginate(
//     pathCollection: 'your_collection',
//     queryDocs: queries,
//     callback: (List<Map<String, dynamic>> documents) {
//       print('Documents fetched: $documents');
//     },
//   );

//   // Fetch next page of documents
//   List<Map<String, dynamic>> nextPageDocuments = await paginator.nextPage('documentId', 10);
//   print('Next page documents: $nextPageDocuments');

//   // Fetch previous page of documents
//   List<Map<String, dynamic>> previousPageDocuments = await paginator.previousPage('documentId', 10);
//   print('Previous page documents: $previousPageDocuments');

//   // Clean up when done
//   paginator.dispose();
// }