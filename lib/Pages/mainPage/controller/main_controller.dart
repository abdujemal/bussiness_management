import 'package:get/get.dart';

class MainConntroller extends GetxController {
  RxInt currentTabIndex = 0.obs;
  
  setCurrentTabIndex(int val) {
    currentTabIndex.value = val;
  }
}
