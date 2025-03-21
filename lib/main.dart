import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sankaestay/rental/widgets/tenentwidgets/Bottom_navbar.dart';
import 'package:toastification/toastification.dart';

 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyA7TCd8sTaCPjCwvEIS1GnakDpXDzPFOuU",
            authDomain: "thesis-sangkaestay.firebaseapp.com",
            projectId: "thesis-sangkaestay",
            storageBucket: "thesis-sangkaestay.fi rebasestorage.app",
            messagingSenderId: "179320462747",
            appId: "1:179320462747:web:542d064b9c9a4204a1953e",
            measurementId: "G-H98L8W0EPK"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavBar(),
      ),
    );
  }
}
