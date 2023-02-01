import 'package:bussiness_management/view/Pages/calender_page.dart';
import 'package:bussiness_management/view/Pages/cutomers_page.dart';
import 'package:bussiness_management/view/Pages/expenses_page.dart';
import 'package:bussiness_management/view/Pages/items_page.dart';
import 'package:bussiness_management/view/Pages/main_page.dart';
import 'package:bussiness_management/view/Pages/stock_page.dart';
import 'package:bussiness_management/view/Pages/users_page.dart';
import 'package:bussiness_management/view/controller/l_s_controller.dart';
import 'package:bussiness_management/view/widget/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../controller/main_controller.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  MainConntroller mainConntroller = Get.find<MainConntroller>();
  LSController lsController = Get.find<LSController>();

  List<Widget> tabs = [
    const MainPage(),
    const ExpensesPage(),
    const ItemsPage(),
    const StockPage(),
    const CalenderPage(),
    const CustomersPage(),
    const UsersPage(),
  ];

  List<Widget> tabs2 = [
    const MainPage(),
    const ItemsPage(),
    const StockPage(),
    const CalenderPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
        controller: mainConntroller.z.value,
        borderRadius: 24,
        style: DrawerStyle.defaultStyle,
        showShadow: true,
        shadowLayer1Color: backgroundColor,
        shadowLayer2Color: backgroundColor,
        menuScreenWidth: 200,
        boxShadow: [
          BoxShadow(
              color: primaryColor.withAlpha(15),
              blurRadius: 30,
              spreadRadius: 30,
              offset: const Offset(0, 4))
        ],
        openCurve: Curves.fastOutSlowIn,
        slideWidth: MediaQuery.of(context).size.width * 0.6,
        duration: const Duration(milliseconds: 500),
        angle: 0.0,
        menuBackgroundColor: mainBgColor,
        mainScreen: GetBuilder<MainConntroller>(
            builder: (controller) =>
            lsController.currentUser.value.priority == UserPriority.Admin?
             tabs[controller.mainIndex.value]:
             tabs2[controller.mainIndex.value]),
        menuScreen: const MyDrawer());
  }
}
