import 'package:sankaestay/rental/screen/intro_screen/loading_screen.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize App Check with debug provider for development
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  );

  // Get the debug token and print it
  final debugToken = await FirebaseAppCheck.instance.getToken(true);
  print('Debug App Check Token: $debugToken');

  // Configure Firebase Auth settings
  await FirebaseAuth.instance.setSettings(
    appVerificationDisabledForTesting: true, // Only for testing
    phoneNumber: null,
    smsCode: null,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoadingScreen(),
      ),
    );
  }
}
