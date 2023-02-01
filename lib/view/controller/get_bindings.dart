import 'package:bussiness_management/view/controller/l_s_controller.dart';
import 'package:bussiness_management/view/controller/main_controller.dart';
import 'package:get/get.dart';

import '../../injection.dart';

class GetBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => di<LSController>());
    Get.lazyPut(() => di<MainConntroller>());
  }
}
