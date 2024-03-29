import 'package:bussiness_management/injection.dart';
import 'package:bussiness_management/view/Pages/home_tab.dart';
import 'package:bussiness_management/view/Pages/order_tab.dart';
import 'package:bussiness_management/view/Pages/products_tab.dart';
import 'package:bussiness_management/view/Pages/budget_tab.dart';
import 'package:bussiness_management/view/controller/l_s_controller.dart';
import 'package:bussiness_management/view/controller/main_controller.dart';
import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/view/widget/add_dialogue.dart';
import 'package:bussiness_management/view/widget/order_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../widget/bottom_nav.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  List<Widget> tabBodies = [
    const HomeTab(),
    const OrderTab(),
    const BudgetTab(),
    const ProductTab()
  ];

  MainConntroller mainConntroller = Get.put(di<MainConntroller>());
  LSController lsController = Get.put(di<LSController>());

  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this, );
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: BottomNav(controller: tabController!),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          if (lsController.currentUser.value.priority !=
              UserPriority.Delivery) {
            mainConntroller.toggleAddDialogue();
          } else {
            toast("You can't add any thing.", ToastType.error);
          }
        },
        child: Card(
          color: whiteColor,
          shape: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Obx(() {
              return Icon(
                mainConntroller.isAddDialogueOpen.value
                    ? FontAwesomeIcons.times
                    : FontAwesomeIcons.plus,
                size: 30,
                color: primaryColor,
              );
            }),
          ),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            TabBarView(controller: tabController, children: tabBodies),
            // tabBodies[mainConntroller.currentTabIndex.value],
            AnimatedPositioned(
              curve: Curves.decelerate,
              bottom: mainConntroller.isAddDialogueOpen.value ? 50 : -280,
              right: MediaQuery.of(context).size.width / 2 - 115,
              duration: const Duration(seconds: 1),
              child: const AddDialogue(),
            )
          ],
        ),
      ),
    );
  }
}
