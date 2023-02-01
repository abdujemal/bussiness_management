import 'dart:io';

import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/data/model/user_model.dart';
import 'package:bussiness_management/domain/usecase/get_user_usecase.dart';
import 'package:bussiness_management/domain/usecase/set_user_usecase.dart';
import 'package:bussiness_management/domain/usecase/sign_in_with_email_password.dart';
import 'package:bussiness_management/domain/usecase/sign_out_usecase.dart';
import 'package:bussiness_management/domain/usecase/sign_up_with_email_password_usecase.dart';
import 'package:bussiness_management/view/Pages/initial_page.dart';
import 'package:bussiness_management/view/Pages/login_signin_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LSController extends GetxController {
  RxBool isLogin = true.obs;
  Rx<File> image = File("").obs;
  Rx<RequestState> emailState = RequestState.idle.obs;
  Rx<RequestState> logoutState = RequestState.idle.obs;
  Rx<RequestState> updateState = RequestState.idle.obs;

  Rx<UserModel> currentUser =
      UserModel(id: "", image: '', name: '', priority: '', email: '').obs;

  SignUpWithEmailPasswordUsecase signUpWithEmailPasswordUsecase;
  SignInWithEmailPasswordUSecase signInWithEmailPasswordUSecase;
  SignOutUsecase signOutUsecase;
  GetUserUsecase getUserUsecase;
  SetUserUsecase setUserUsecase;
  LSController(this.setUserUsecase, this.signOutUsecase, this.getUserUsecase,
      this.signUpWithEmailPasswordUsecase, this.signInWithEmailPasswordUSecase);

  updateUser(UserModel userModel) async {
    updateState.value = RequestState.loading;

    final res = await setUserUsecase.call(SetUserParams(userModel));

    res.fold((l) {
      updateState.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      updateState.value = RequestState.loaded;
      currentUser.value = userModel;
      toast("Successfully updated.", ToastType.success);
    });
  }

  logout() async {
    logoutState.value = RequestState.loading;

    final res = await signOutUsecase.call(const NoParameters());

    res.fold((l) {
      logoutState.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      logoutState.value = RequestState.loaded;
      Get.offAll(() => const LogInSignInPage());
    });
  }

  Future<Widget?> getUser() async {
    final res = await getUserUsecase.call(const NoParameters());

    res.fold((l) {
      Get.off(() => const LogInSignInPage());
    }, (r) {
      currentUser.value = r;
      Get.off(() => const InitialPage());
    });
  }

  signUpWithEmailnPassword(String email, String name, String password) async {
    emailState.value = RequestState.loading;
    final res = await signUpWithEmailPasswordUsecase.call(
        SignUpWithEmailPasswordParams(
            password,
            UserModel(
                id: null,
                image: null,
                name: name,
                priority: UserPriority.Shopkeeper,
                email: email),
            image.value));

    res.fold((l) {
      emailState.value = RequestState.error;
      toast(l.toString(), ToastType.error, isLong: true);
    }, (r) {
      emailState.value = RequestState.loaded;
      currentUser.value = r;
      Get.off(() => const InitialPage());
    });
  }

  signInWithEmailnPassword(String email, String password) async {
    emailState.value = RequestState.loading;
    final res = await signInWithEmailPasswordUSecase
        .call(SignInWithEmailPAsswordPArams(email, password));

    res.fold((l) {
      emailState.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      emailState.value = RequestState.loaded;
      currentUser.value = r;
      Get.off(() => const InitialPage());
    });
  }

  setIsLoading(bool val) {
    isLogin.value = val;
  }

  setImageFile(File file) {
    image.value = file;
  }
}
