import 'package:bussiness_management/injection.dart';
import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/notification_service.dart';
import 'package:bussiness_management/view/Pages/splash_screen.dart';
import 'package:bussiness_management/view/controller/get_bindings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await NotificationService().initNotification();
  await Firebase.initializeApp();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: GetBindings(),
        debugShowCheckedModeBanner: false,
        title: 'Zenbaba Furniture',
        theme: ThemeData.dark().copyWith(
          primaryColor: mainColor,
        ),
        home: const SplashScreen());
  }
}
