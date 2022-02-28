import 'package:bussiness_management/Pages/LoginSignUp/login_signin_page.dart';
import 'package:bussiness_management/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bussiness Management',
      theme: ThemeData.dark().copyWith(
        primaryColor: mainColor,
      ),
      home: const LogInSignInPage()
    );
  }
}

