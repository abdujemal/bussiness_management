import 'package:bussiness_management/Pages/LoginSignUp/comp/login.dart';
import 'package:bussiness_management/Pages/LoginSignUp/comp/signup.dart';
import 'package:bussiness_management/Pages/LoginSignUp/comp/sl_btn.dart';
import 'package:bussiness_management/Pages/LoginSignUp/comp/sl_input.dart';
import 'package:bussiness_management/Pages/LoginSignUp/controller/l_s_controller.dart';
import 'package:bussiness_management/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInSignInPage extends StatefulWidget {
  const LogInSignInPage({Key? key}) : super(key: key);

  @override
  _LogInSignInPageState createState() => _LogInSignInPageState();
}

class _LogInSignInPageState extends State<LogInSignInPage> {
  LSController lsController = Get.put(LSController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 90,),
                Image.asset(
                  "assets/logo.png",
                  width: 140,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Business Management",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: textColor),
                ),
                const SizedBox(
                  height: 50,
                ),
                Obx((() => lsController.isLogin.value ? Login() : SignUp())),
                SizedBox(height: 40,),
                Text(
                  "New to this app.",
                  style: TextStyle(color: textColor, fontSize: 12),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                    onTap: () {
                      if (lsController.isLogin.value) {
                        lsController.setIsLoading(false);
                      } else {
                        lsController.setIsLoading(true);
                      }
                    },
                    child: Obx(()=> Text(
                      lsController.isLogin.value ?
                      "Create an Account":
                      "Already have an account",
                      style: TextStyle(
                          color: whiteColor, fontWeight: FontWeight.bold),
                    ))),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
