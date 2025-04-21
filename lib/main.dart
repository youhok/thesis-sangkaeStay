// ignore_for_file: unused_local_variable
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:sankaestay/rental/screen/intro_screen/loading_screen.dart';
import 'package:sankaestay/translate/app_translate.dart';
import 'package:sankaestay/translate/localization_controller.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:shared_preferences/shared_preferences.dart';


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


  // Load translations FIRST
  await AppTranslations.loadTranslations();
  // Inject LocalizationController
  Get.put(LocalizationController());

  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: Obx(() {
        final localeController = Get.find<LocalizationController>();
        final selectedLanguage = localeController.selectedLanguage.value;

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: AppTranslations(),
          locale: Locale(selectedLanguage),
          fallbackLocale: const Locale('en'),
          home: LoadingScreen(),
        );
      }),
    );
  }
}


