import 'package:bussiness_management/Pages/mainPage/comp/bottom_nav.dart';
import 'package:bussiness_management/Pages/mainPage/controller/main_controller.dart';
import 'package:bussiness_management/Pages/mainPage/tabs/Home/home_page.dart';
import 'package:bussiness_management/Pages/mainPage/tabs/Order/order_page.dart';
import 'package:bussiness_management/Pages/mainPage/tabs/Products/product_page.dart';
import 'package:bussiness_management/Pages/mainPage/tabs/wallet/wallet_page.dart';
import 'package:bussiness_management/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> tabBodies = [
    const HomePage(),
    const OrderPage(),
    const WalletPage(),
    const ProductPage()
  ];

  MainConntroller mainConntroller = Get.put(MainConntroller());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomNav(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.add,
            size: 40,
            color: mainColor,
          ),
          backgroundColor: whiteColor,
        ),
        body: Obx(()=>tabBodies[mainConntroller.currentTabIndex.value]),
      ),
    );
  }
}
