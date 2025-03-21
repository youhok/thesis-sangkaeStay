import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

typedef QueryCallback<T> = void Function(List<T> data);

class PaginatedQueryResult<T> {
  final Function() getData;
  final String? error;
  final Future<List<T>> Function(String page, int newLimit) previousPage;
  final Future<List<T>> Function(String page, int newLimit) nextPage;
  final Future<int> Function(
          String collectionName, List<Query<dynamic>> conditions)
      getCollectionLength;

  PaginatedQueryResult({
    required this.getData,
    this.error,
    required this.previousPage,
    required this.nextPage,
    required this.getCollectionLength,
  });
}

PaginatedQueryResult<T> getCollectionPaginate<T>({
  required String collectionName,
  required List<Query<dynamic>> queryDocs,
  QueryCallback<T>? callback,
}) {
  String? error;
  List<T> documents = [];
  late Query querySnapshot;
  StreamSubscription? subscription;

  querySnapshot =
      queryDocs.reduce((Query query, Query next) => query.where(next));

  Future<void> getData() async {
    subscription?.cancel();
    subscription = querySnapshot.snapshots(includeMetadataChanges: true).listen(
      (snapshot) {
        documents = snapshot.docs.map((doc) {
          final docData = doc.data() as Map<String, dynamic>;
          return {'id': doc.id, ...docData} as T;
        }).toList();

        if (callback != null) {
          callback(documents);
        }
      },
      onError: (err) {
        error = err.toString();
      },
    );
  }

  Future<List<T>> previousPage(String page, int newLimit) async {
    try {
      final firstVisible = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(page)
          .get();

      querySnapshot =
          queryDocs.reduce((Query query, Query next) => query.where(next));
      querySnapshot =
          querySnapshot.endBeforeDocument(firstVisible).limitToLast(newLimit);

      await getData();
      return documents;
    } catch (err) {
      error = err.toString();
      return [];
    }
  }

  Future<List<T>> nextPage(String page, int newLimit) async {
    try {
      final firstVisible = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(page)
          .get();

      querySnapshot =
          queryDocs.reduce((Query query, Query next) => query.where(next));
      querySnapshot =
          querySnapshot.startAfterDocument(firstVisible).limit(newLimit);

      await getData();
      return documents;
    } catch (err) {
      error = err.toString();
      return [];
    }
  }

  Future<int> getCollectionLength(
      String collectionName, List<Query<dynamic>> conditions) async {
    final colRef = FirebaseFirestore.instance.collection(collectionName);
    final q = conditions.reduce((Query query, Query next) => query.where(next));
    final res = await q.count().get();
    return res.count ?? 0;
  }

  getData();

  return PaginatedQueryResult<T>(
    getData: getData,
    error: error,
    previousPage: previousPage,
    nextPage: nextPage,
    getCollectionLength: getCollectionLength,
  );
}

// �� Usage Examples

// 🌐 Web Examples
// 1️⃣ Basic Pagination Setup (Web)
/*
final paginatedQuery = getCollectionPaginate<Map<String, dynamic>>(
  collectionName: 'products',
  queryDocs: [
    FirebaseFirestore.instance.collection('products').orderBy('price'),
    FirebaseFirestore.instance.collection('products').limit(10),
  ],
  callback: (data) {
    print('Updated products: $data');
  },
);

// Get next page
final nextPageData = await paginatedQuery.nextPage('lastDocId', 10);

// Get previous page
final prevPageData = await paginatedQuery.previousPage('firstDocId', 10);

// Get total count
final totalCount = await paginatedQuery.getCollectionLength(
  'products',
  [FirebaseFirestore.instance.collection('products').orderBy('price')],
);
*/

// 2️⃣ Advanced Query with Filters (Web)
/*
final paginatedQuery = getCollectionPaginate<Map<String, dynamic>>(
  collectionName: 'users',
  queryDocs: [
    FirebaseFirestore.instance.collection('users').where('age', isGreaterThan: 18),
    FirebaseFirestore.instance.collection('users').orderBy('name'),
    FirebaseFirestore.instance.collection('users').limit(20),
  ],
  callback: (data) {
    print('Filtered users: $data');
  },
);
*/

// 3️⃣ Real-time Updates with Pagination (Web)
/*
final paginatedQuery = getCollectionPaginate<Map<String, dynamic>>(
  collectionName: 'orders',
  queryDocs: [
    FirebaseFirestore.instance.collection('orders').where('status', isEqualTo: 'pending'),
    FirebaseFirestore.instance.collection('orders').orderBy('createdAt', descending: true),
    FirebaseFirestore.instance.collection('orders').limit(15),
  ],
  callback: (data) {
    print('Real-time orders update: $data');
  },
);

// Clean up subscription when done
// paginatedQuery.subscription?.cancel();
*/

// ------------------------------------------------------------------

// 📱 Mobile Examples
// 1️⃣ Social Media Feed with Infinite Scroll
/*
class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late PaginatedQueryResult<Map<String, dynamic>> _feedQuery;
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _posts = [];
  bool _isLoading = false;
  String? _lastDocumentId;

  @override
  void initState() {
    super.initState();
    _setupFeed();
    _scrollController.addListener(_onScroll);
  }

  void _setupFeed() {
    _feedQuery = getCollectionPaginate<Map<String, dynamic>>(
      collectionName: 'posts',
      queryDocs: [
        FirebaseFirestore.instance.collection('posts').orderBy('createdAt', descending: true),
        FirebaseFirestore.instance.collection('posts').limit(10),
      ],
      callback: (data) {
        setState(() {
          _posts = data;
          _isLoading = false;
        });
      },
    );
  }

  Future<void> _loadMorePosts() async {
    if (_isLoading || _posts.isEmpty) return;
    
    setState(() => _isLoading = true);
    _lastDocumentId = _posts.last['id'];
    await _feedQuery.nextPage(_lastDocumentId!, 10);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      _loadMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _posts.length + 1,
      itemBuilder: (context, index) {
        if (index == _posts.length) {
          return _isLoading
              ? Center(child: CircularProgressIndicator())
              : SizedBox.shrink();
        }
        return PostCard(post: _posts[index]);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _feedQuery.subscription?.cancel();
    super.dispose();
  }
}
*/

// 2️⃣ Product Catalog with Filters and Pagination
/*
class ProductCatalogScreen extends StatefulWidget {
  @override
  _ProductCatalogScreenState createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  late PaginatedQueryResult<Map<String, dynamic>> _productQuery;
  List<Map<String, dynamic>> _products = [];
  String _selectedCategory = 'all';
  int _currentPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _setupProductQuery();
  }

  void _setupProductQuery() {
    List<Query<dynamic>> queryDocs = [
      FirebaseFirestore.instance.collection('products').orderBy('name'),
      FirebaseFirestore.instance.collection('products').limit(20),
    ];

    if (_selectedCategory != 'all') {
      queryDocs.insert(
        0,
        FirebaseFirestore.instance.collection('products').where('category', isEqualTo: _selectedCategory),
      );
    }

    _productQuery = getCollectionPaginate<Map<String, dynamic>>(
      collectionName: 'products',
      queryDocs: queryDocs,
      callback: (data) {
        setState(() {
          _products = data;
          _isLoading = false;
        });
      },
    );
  }

  Future<void> _loadNextPage() async {
    if (_isLoading || _products.isEmpty) return;
    
    setState(() => _isLoading = true);
    await _productQuery.nextPage(_products.last['id'], 20);
    _currentPage++;
  }

  Future<void> _loadPreviousPage() async {
    if (_isLoading || _currentPage <= 1) return;
    
    setState(() => _isLoading = true);
    await _productQuery.previousPage(_products.first['id'], 20);
    _currentPage--;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: _currentPage > 1 ? _loadPreviousPage : null,
          ),
          Text('Page $_currentPage'),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: _loadNextPage,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: _products[index]);
              },
            ),
    );
  }

  @override
  void dispose() {
    _productQuery.subscription?.cancel();
    super.dispose();
  }
}
*/

// 3️⃣ Chat Messages with Real-time Updates
/*
class ChatScreen extends StatefulWidget {
  final String chatId;
  
  ChatScreen({required this.chatId});
  
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late PaginatedQueryResult<Map<String, dynamic>> _messageQuery;
  List<Map<String, dynamic>> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  bool _hasMoreMessages = true;

  @override
  void initState() {
    super.initState();
    _setupMessageQuery();
    _scrollController.addListener(_onScroll);
  }

  void _setupMessageQuery() {
    _messageQuery = getCollectionPaginate<Map<String, dynamic>>(
      collectionName: 'chats/${widget.chatId}/messages',
      queryDocs: [
        FirebaseFirestore.instance
            .collection('chats/${widget.chatId}/messages')
            .orderBy('timestamp', descending: true),
        FirebaseFirestore.instance
            .collection('chats/${widget.chatId}/messages')
            .limit(20),
      ],
      callback: (data) {
        setState(() {
          _messages = data;
          _isLoading = false;
        });
      },
    );
  }

  Future<void> _loadMoreMessages() async {
    if (_isLoading || !_hasMoreMessages || _messages.isEmpty) return;
    
    setState(() => _isLoading = true);
    final lastMessageId = _messages.last['id'];
    final newMessages = await _messageQuery.nextPage(lastMessageId, 20);
    
    if (newMessages.isEmpty) {
      setState(() => _hasMoreMessages = false);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels <= 0) {
      _loadMoreMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              itemCount: _messages.length + 1,
              itemBuilder: (context, index) {
                if (index == _messages.length) {
                  return _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox.shrink();
                }
                return MessageBubble(message: _messages[index]);
              },
            ),
          ),
          MessageInput(
            onSend: (message) {
              // Send message implementation
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageQuery.subscription?.cancel();
    super.dispose();
  }
}
*/
