import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentResult {
  final Future<bool> Function(Map<String, dynamic> formDoc) addDoc;
  final Future<bool> Function(String id, Map<String, dynamic> formDoc) setDoc;
  final Future<bool> Function(String id) removeDoc;
  final Future<bool> Function(String id, Map<String, dynamic> formDoc)
      updateDoc;

  DocumentResult({
    required this.addDoc,
    required this.setDoc,
    required this.removeDoc,
    required this.updateDoc,
  });
}

DocumentResult useDocument(String collectionName) {
  final collectionRef = FirebaseFirestore.instance.collection(collectionName);

  Future<bool> addDoc(Map<String, dynamic> formDoc) async {
    try {
      await collectionRef.add(formDoc);
      return true;
    } catch (err) {
      print("Failed to add document: $err");
      return false;
    }
  }

  Future<bool> setDoc(String id, Map<String, dynamic> formDoc) async {
    try {
      await collectionRef.doc(id).set(formDoc);
      return true;
    } catch (err) {
      print("Failed to set document: $err");
      return false;
    }
  }

  Future<bool> removeDoc(String id) async {
    try {
      await collectionRef.doc(id).delete();
      return true;
    } catch (err) {
      print("Failed to delete document: $err");
      return false;
    }
  }

  Future<bool> updateDoc(String id, Map<String, dynamic> formDoc) async {
    try {
      await collectionRef.doc(id).update(formDoc);
      return true;
    } catch (err) {
      print("Failed to update document: $err");
      return false;
    }
  }

  return DocumentResult(
    addDoc: addDoc,
    setDoc: setDoc,
    removeDoc: removeDoc,
    updateDoc: updateDoc,
  );
}

// 🎯 Usage Examples

// 1️⃣ Basic Document Operations
/*
final document = useDocument('users');

// Add a new document
final success = await document.addDoc({
  'name': 'John Doe',
  'email': 'john@example.com',
  'age': 30,
});

// Set a document with specific ID
final setSuccess = await document.setDoc('user123', {
  'name': 'Jane Doe',
  'email': 'jane@example.com',
});

// Update a document
final updateSuccess = await document.updateDoc('user123', {
  'age': 31,
});

// Delete a document
final deleteSuccess = await document.removeDoc('user123');
*/

// 2️⃣ User Profile Management Example
/*
class UserProfile extends StatefulWidget {
  final String userId;
  
  UserProfile({required this.userId});
  
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _document = useDocument('users');
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    
    // Using getCollection from get_collection.dart to fetch user data
    await getCollectionQuery<Map<String, dynamic>>(
      collectionName: 'users',
      docID: widget.userId,
      callback: (data) {
        if (data.isNotEmpty) {
          final userData = data.first;
          _nameController.text = userData['name'] ?? '';
          _bioController.text = userData['bio'] ?? '';
        }
        setState(() => _isLoading = false);
      },
    );
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      final success = await _document.updateDoc(widget.userId, {
        'name': _nameController.text,
        'bio': _bioController.text,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile')),
        );
      }
      
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _bioController,
            decoration: InputDecoration(labelText: 'Bio'),
            maxLines: 3,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your bio';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: _updateProfile,
            child: Text('Update Profile'),
          ),
        ],
      ),
    );
  }
}
*/

// 3️⃣ Todo Item Management Example
/*
class TodoItem extends StatefulWidget {
  final String todoId;
  
  TodoItem({required this.todoId});
  
  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  final _document = useDocument('todos');
  bool _isCompleted = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTodoData();
  }

  Future<void> _loadTodoData() async {
    await getCollectionQuery<Map<String, dynamic>>(
      collectionName: 'todos',
      docID: widget.todoId,
      callback: (data) {
        if (data.isNotEmpty) {
          setState(() {
            _isCompleted = data.first['completed'] ?? false;
            _isLoading = false;
          });
        }
      },
    );
  }

  Future<void> _toggleComplete() async {
    setState(() => _isLoading = true);
    
    final success = await _document.updateDoc(widget.todoId, {
      'completed': !_isCompleted,
      'completedAt': !_isCompleted ? FieldValue.serverTimestamp() : null,
    });

    if (success) {
      setState(() => _isCompleted = !_isCompleted);
    }
    
    setState(() => _isLoading = false);
  }

  Future<void> _deleteTodo() async {
    setState(() => _isLoading = true);
    
    final success = await _document.removeDoc(widget.todoId);
    
    if (success) {
      // Navigate back or update UI
      Navigator.pop(context);
    }
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return ListTile(
      leading: Checkbox(
        value: _isCompleted,
        onChanged: (_) => _toggleComplete(),
      ),
      title: Text('Todo Item'),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: _deleteTodo,
      ),
    );
  }
}
*/
