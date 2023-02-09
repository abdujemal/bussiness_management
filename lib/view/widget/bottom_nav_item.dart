import 'package:bussiness_management/view/controller/l_s_controller.dart';
import 'package:bussiness_management/view/controller/main_controller.dart';
import 'package:bussiness_management/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../injection.dart';

class BottomNavItem extends StatelessWidget {
  String label;
  IconData iconData;
  IconData activeIcon;
  int index;
  void Function() onTap;

  BottomNavItem(
      {Key? key,
      required this.activeIcon,
      required this.label,
      required this.iconData,
      required this.index,
      required this.onTap,})
      : super(key: key);

  LSController lsController = Get.put(di<LSController>());
  MainConntroller mainConntroller = Get.put(di<MainConntroller>());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        height: 70,
        width: 60,
        child: Center(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  mainConntroller.currentTabIndex.value == index
                      ? activeIcon
                      : iconData,
                  color: whiteColor,
                  size: 40,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  label,
                  style: TextStyle(color: whiteColor, fontSize: 13),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
