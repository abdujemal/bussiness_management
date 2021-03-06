import 'package:bussiness_management/Pages/LoginSignUp/comp/sl_btn.dart';
import 'package:bussiness_management/Pages/LoginSignUp/comp/sl_input.dart';
import 'package:bussiness_management/Pages/mainPage/main_page.dart';
import 'package:bussiness_management/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  // const Login({ Key? key }) : super(key: key);

  TextEditingController emailTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _key,
          child: Column(
            children: [
              SLInput(
                controller: emailTC,
                keyboardType: TextInputType.emailAddress,
                title: 'Email',
                hint: 'abc@website.com',
              ),
              const SizedBox(
                height: 40,
              ),
              SLInput(
                  title: "Password",
                  hint: "*******",
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordTC),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: GestureDetector(
            onTap: () {},
            child: Text(
              "Forget password?",
              style: TextStyle(color: textColor),
            ),
          ),
        ),
        const SizedBox(
          height: 45,
        ),
        SLBtn(
          text: "Log In",
          onTap: () {
            if (_key.currentState!.validate()) {
              Get.to(()=>const MainPage());
            }
          },
        ),
      ],
    );
  }
}
