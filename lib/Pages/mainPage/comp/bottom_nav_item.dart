import 'package:bussiness_management/Pages/mainPage/controller/main_controller.dart';
import 'package:bussiness_management/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavItem extends StatelessWidget {
  String label;
  IconData iconData;
  int index;

  BottomNavItem(
      {Key? key,
      required this.label,
      required this.iconData,
      required this.index})
      : super(key: key);

  MainConntroller mainConntroller = Get.put(MainConntroller());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        mainConntroller.setCurrentTabIndex(index);
      },
      child: Ink(
        height: 70,
        width: 60,
        child: Center(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(iconData,
                    color: mainConntroller.currentTabIndex.value == index
                        ? darkOrange
                        : mainColor),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  label,
                  style: TextStyle(
                      color: mainConntroller.currentTabIndex.value == index
                          ? darkOrange
                          : mainColor,
                      fontSize: 10),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
