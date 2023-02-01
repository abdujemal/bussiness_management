import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/view/controller/l_s_controller.dart';
import 'package:bussiness_management/view/widget/sl_btn.dart';
import 'package:bussiness_management/view/widget/sl_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  // const Login({ Key? key }) : super(key: key);

  TextEditingController emailTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  LSController lsController = Get.find<LSController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _key,
          child: Column(
            children: [
              SLInput(
                inputColor: textColor,
                controller: emailTC,
                keyboardType: TextInputType.emailAddress,
                title: 'Email',
                hint: 'abc@website.com',
              ),
              const SizedBox(
                height: 40,
              ),
              SLInput(
                inputColor: textColor,
                title: "Password",
                hint: "*******",
                isObscure: true,
                keyboardType: TextInputType.visiblePassword,
                controller: passwordTC,
              ),
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
        Obx(() {
          return lsController.emailState.value == RequestState.loading
              ? CircularProgressIndicator(
                  color: primaryColor,
                )
              : SLBtn(
                  text: "Log In",
                  onTap: () {
                    if (_key.currentState!.validate()) {
                      lsController.signInWithEmailnPassword(
                          emailTC.text, passwordTC.text);
                    }
                  },
                );
        }),
      ],
    );
  }
}
