import 'package:get/get.dart';
import 'package:sankaestay/rental/screen/intro_screen/loading_screen.dart';
import 'package:sankaestay/translate/app_translate.dart';
import 'package:sankaestay/translate/localization_controller.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Load translations FIRST
  await AppTranslations.loadTranslations();
  // Inject LocalizationController
  Get.put(LocalizationController());

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


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


