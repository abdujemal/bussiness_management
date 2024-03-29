import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/data/model/expense_model.dart';
import 'package:bussiness_management/view/Pages/add_expense.dart';
import 'package:bussiness_management/view/controller/main_controller.dart';
import 'package:bussiness_management/view/widget/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../widget/date_item.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  MainConntroller mainConntroller = Get.find<MainConntroller>();

  int selectedTabIndex = 1;

  ScrollController controller = ScrollController();

  int pageNum = 2;

  @override
  void initState() {
    super.initState();
    controller.addListener(handleScrolling);
  }

  void handleScrolling() {
    if (controller.offset >= controller.position.maxScrollExtent) {
      if (mainConntroller.getExpensesStatus.value != RequestState.loading) {
        mainConntroller.getExpenses(
            quantity: numOfDocToGet,
            status: ExpenseState.list[selectedTabIndex],
            isNew: false);
        pageNum = pageNum + 1;
        print("${mainConntroller.pendingOrders.length} expenses");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: title("Expenses"),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/menu icon.svg',
            color: whiteColor,
            height: 21,
          ),
          onPressed: () {
            mainConntroller.z.value.open!();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const AddExpense());
            },
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              mainConntroller.getExpenses(
                quantity: numOfDocToGet,
                status: ExpenseState.unpayed,
              );
              mainConntroller.getExpenses(
                quantity: numOfDocToGet,
                status: ExpenseState.payed,
              );
            },
            icon: const Icon(
              Icons.refresh_rounded,
              size: 30,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.black54,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                ExpenseState.list.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTabIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 30,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: selectedTabIndex != index
                            ? Colors.transparent
                            : backgroundColor),
                    child: Text(
                      ExpenseState.list[index],
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              List<dynamic> expenses = [];
              DateTime now = DateTime.now();
              String today = "";
              String day = "${now.day}";
              String month = "${now.month}";

              if (now.month < 10) {
                month = '0${now.month}';
              }
              if (now.day < 10) {
                day = '0${now.day}';
              }
              today = "${now.year}-$month-$day";
              String currentDate = "";

              for (ExpenseModel expeseModel in selectedTabIndex == 0
                  ? mainConntroller.payedExpenses
                  : mainConntroller.unPayedExpenses) {
                if (currentDate != expeseModel.date) {
                  if (today == expeseModel.date) {
                    expenses.add("Today");
                    currentDate = expeseModel.date;
                  } else {
                    expenses.add(expeseModel.date.replaceAll("-", "/"));
                    currentDate = expeseModel.date;
                  }
                }
                expenses.add(expeseModel);
              }

            
              if (selectedTabIndex == 0 &&
                  mainConntroller.payedExpenses.isEmpty) {
                return const Center(
                  child: Text("No Expenses."),
                );
              }
              if (selectedTabIndex == 1 &&
                  mainConntroller.unPayedExpenses.isEmpty) {
                return const Center(
                  child: Text("No Expenses."),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        if (expenses[index].runtimeType.toString() == "String") {
                          return DateItem(
                            date: expenses[index],
                            style: expenses[index] == "Unpayed Expenses"
                                ? TextStyle(color: primaryColor, fontSize: 18)
                                : null,
                          );
                        } else {
                          return ExpenseCard(
                            isPayed:
                                expenses[index].expenseStatus == ExpenseState.payed,
                            expenseModel: expenses[index],
                          );
                        }
                      },
                    ),
                  ),
                  mainConntroller.getExpensesStatus.value == RequestState.loading ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ):SizedBox()
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
