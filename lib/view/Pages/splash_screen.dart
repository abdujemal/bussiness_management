import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/notification_service.dart';
import 'package:bussiness_management/view/controller/l_s_controller.dart';
import 'package:bussiness_management/view/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LSController lsController = Get.find<LSController>();
  MainConntroller mainConntroller = Get.find<MainConntroller>();
  @override
  void initState() {
    super.initState();
    lsController.getUser();
    // mainConntroller.getCustomers();
    mainConntroller.getExpenses(
      quantity: numOfDocToGet,
      status: ExpenseState.unpayed,
    );
    mainConntroller.getExpenses(
      quantity: numOfDocToGet,
      status: ExpenseState.payed,
    );
    mainConntroller.getItems();
    mainConntroller.getOrders(
      quantity: numOfDocToGet,
      status: OrderStatus.Pending,
    );
    mainConntroller.getOrders(
      quantity: numOfDocToGet,
      status: OrderStatus.Delivered,
    );
    // mainConntroller.getProducts();
    mainConntroller.getUsers();
    mainConntroller.getExpenseChart();
    mainConntroller.getOrderChart();
    mainConntroller.getCustomers();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/loginBackground.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                height: 200,
              ),
              const SizedBox(
                height: 15,
              ),
              CircularProgressIndicator(
                color: primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
