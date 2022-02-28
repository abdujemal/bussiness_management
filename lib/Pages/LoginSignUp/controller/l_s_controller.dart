import 'package:get/get.dart';

class LSController extends GetxController {
  RxBool isLogin = true.obs;
  setIsLoading(bool val) {
    isLogin.value = val;
  }
}
