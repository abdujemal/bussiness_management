import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/data/model/cutomer_model.dart';
import 'package:bussiness_management/data/model/expense_chart_model.dart';
import 'package:bussiness_management/data/model/line_chart_model.dart';
import 'package:bussiness_management/data/model/order_chart_model.dart';
import 'package:bussiness_management/view/Pages/expenses_page.dart';
import 'package:bussiness_management/view/controller/main_controller.dart';
import 'package:bussiness_management/view/widget/expense_card.dart';
import 'package:bussiness_management/view/widget/order_item.dart';
import 'package:bussiness_management/view/widget/sample_line_chart.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

import '../controller/l_s_controller.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin<HomeTab> {
  MainConntroller mainConntroller = Get.find<MainConntroller>();

  LSController lsController = Get.find<LSController>();

  List<String> graphType = [
    "Week",
    "Year",
  ];

  List<String> weekDays = [
    "Mon",
    "Tues",
    "Wed",
    "Thurs",
    "Fri",
    "Sat",
    "Sun",
  ];

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  int selectedGraphType = 1;

  List<LineChartModel> data = [];

  double totalExpense = 0;

  double totalIncome = 0;

  double bigestPrice = 0;

  int numOfMale = 0;
  int numOfFemale = 0;

  var colorList = [
    Colors.green,
    primaryColor,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.orange,
    Colors.purple,
    Colors.brown,
    Colors.black,
    Colors.white,
    Colors.indigo,
    Colors.lime
  ];

  List<Map<String, dynamic>> locations = [];

  var ringChatData = <String, double>{};

  int totalCustomer = 0;

  @override
  void initState() {
    calculateForMonth();
    calculateCustomers();
    super.initState();
  }

  calculateCustomers() {
    for (String source in CustomerSource.list) {
      int numOfCustomers = 0;
      numOfFemale = 0;
      numOfMale = 0;
      for (CustomerModel customer in mainConntroller.customers) {
        if (customer.source == source) {
          numOfCustomers++;
        }

        if (customer.gender == Gender.Female) {
          numOfFemale++;
        } else if (customer.gender == Gender.Male) {
          numOfMale++;
        }
      }
      ringChatData.addAll({source: numOfCustomers.toDouble()});
    }
    locations = [];
    List<Map<String, dynamic>> newLocations = [];

    for (String kk in KK.list) {
      int numOfCustomers = 0;
      totalCustomer = 0;
      for (CustomerModel customer in mainConntroller.customers) {
        if (customer.kk == kk) {
          numOfCustomers++;
        }
        totalCustomer++;
      }
      newLocations.add({"kk": kk, "num": numOfCustomers});
    }
    setState(() {
      locations.addAll(newLocations);
    });
  }

  calculateForWeek() {
    totalExpense = 0;
    totalIncome = 0;
    bigestPrice = 0;
    data = [];

    List<DateTime> displayDays = DateTime.now().datesOfWeek();

    List<ExpenseChartModel> expenses =
        mainConntroller.expensesChart.where((ExpenseChartModel model) {     
      return displayDays.contains(DateTime.parse(model.date));
    }).toList();

    List<OrderChartModel> orders =
        mainConntroller.ordersChart.where((OrderChartModel model) {
      return displayDays.contains(DateTime.parse(model.date));
    }).toList();

    for (String day in weekDays) {
      double expensePrice = 0;
      double incomePrice = 0;

      for (ExpenseChartModel expenseModel in expenses) {
        if (day == weekDays[DateTime.parse(expenseModel.date).weekday - 1] &&
            DateTime.parse(expenseModel.date).month == DateTime.now().month &&
            DateTime.parse(expenseModel.date).year == DateTime.now().year) {
          expensePrice += expenseModel.price;
          totalExpense += expenseModel.price;
        }
      }
      for (OrderChartModel orderModel in orders) {
        if (day == weekDays[DateTime.parse(orderModel.date).weekday - 1] &&
            DateTime.now().month == DateTime.parse(orderModel.date).month &&
            DateTime.parse(orderModel.date).year == DateTime.now().year) {
          incomePrice += orderModel.price;
          totalIncome += orderModel.price;
        }
      }
      if (bigestPrice < incomePrice) {
        bigestPrice = incomePrice;
      }
      if (bigestPrice < expensePrice) {
        bigestPrice = expensePrice;
      }
      data.add(
        LineChartModel(
          title: day,
          leftVal: incomePrice,
          rightVal: expensePrice,
        ),
      );
    }
  }

  calculateForMonth() {
    totalExpense = 0;
    totalIncome = 0;
    bigestPrice = 0;
    data = [];
    for (String month in months) {
      double expensePrice = 0;
      double incomePrice = 0;
      for (ExpenseChartModel expenseModel in mainConntroller.expensesChart) {
        if (month == months[DateTime.parse(expenseModel.date).month - 1] &&
            DateTime.parse(expenseModel.date).year == DateTime.now().year) {
          expensePrice += expenseModel.price;
          totalExpense += expenseModel.price;
        }
      }
      for (OrderChartModel orderModel in mainConntroller.ordersChart) {
        if (month == months[DateTime.parse(orderModel.date).month - 1] &&
            DateTime.parse(orderModel.date).year == DateTime.now().year) {
          incomePrice += orderModel.price;
          totalIncome += orderModel.price;
        }
      }
      if (bigestPrice < incomePrice) {
        bigestPrice = incomePrice;
      }
      if (bigestPrice < expensePrice) {
        bigestPrice = expensePrice;
      }
      data.add(
        LineChartModel(
          title: month.substring(0, 3),
          leftVal: incomePrice,
          rightVal: expensePrice,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: title("Home"),
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
            onPressed: () async {
              mainConntroller.getExpenseChart();
              mainConntroller.getOrderChart();
              mainConntroller.getCustomers();
              calculateCustomers();
            },
            icon: const Icon(
              Icons.refresh,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            if (lsController.currentUser.value.priority == UserPriority.Admin)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black54,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    graphType.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGraphType = index;
                          if (graphType[index] == "Week") {
                            calculateForWeek();
                          } else {
                            calculateForMonth();
                          }
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
                            color: selectedGraphType != index
                                ? Colors.transparent
                                : backgroundColor),
                        child: Text(
                          graphType[index],
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            if (lsController.currentUser.value.priority == UserPriority.Admin)
              Obx(
                () {
                  if (graphType[selectedGraphType] == "Week") {
                    calculateForWeek();
                  } else {
                    calculateForMonth();
                  }

                  if (mainConntroller.getExpensesStatus.value ==
                      RequestState.loading) {
                    return Center(
                      child: SizedBox(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      ),
                    );
                  }
                  return SampleLineChart(
                    data: data,
                    biggetPrice: bigestPrice,
                    totalExpense: totalExpense,
                    totalIncome: totalIncome,
                  );
                },
              ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 270,
              padding: const EdgeInsets.only(
                  top: 5, left: 15, right: 15, bottom: 20),
              decoration: BoxDecoration(
                  color: mainBgColor, borderRadius: BorderRadius.circular(40)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          "Recent order",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          mainConntroller.currentTabIndex.value = 1;
                        },
                        child: const Text("See all"),
                      ),
                    ],
                  ),
                  Obx(() {
                    if (mainConntroller.getOrdersStatus.value ==
                        RequestState.loading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }
                    return mainConntroller.pendingOrders.isEmpty
                        ? const SizedBox(
                            height: 100,
                            child: Center(
                              child: Text("No Pending Orders."),
                            ),
                          )
                        : Column(
                            children: List.generate(
                              mainConntroller.pendingOrders.length == 1 ? 1 : 2,
                              (index) => OrderItem(
                                orderModel:
                                    mainConntroller.pendingOrders[index],
                                isDelivery: mainConntroller
                                        .pendingOrders[index].deliveryOption ==
                                    DeliveryOption.delivery,
                                isFinished: mainConntroller
                                        .pendingOrders[index].status ==
                                    OrderStatus.Delivered,
                              ),
                            ),
                          );
                  })
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (lsController.currentUser.value.priority == UserPriority.Admin)
              Container(
                width: double.infinity,
                height: 270,
                padding: const EdgeInsets.only(
                    top: 5, left: 15, right: 15, bottom: 20),
                decoration: BoxDecoration(
                  color: mainBgColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Text(
                            "Recent Transaction",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const ExpensesPage());
                          },
                          child: const Text("See all"),
                        ),
                      ],
                    ),
                    Obx(() {
                      if (mainConntroller.getExpensesStatus.value ==
                          RequestState.loading) {
                        return Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        );
                      }
                      return mainConntroller.payedExpenses.isEmpty
                          ? const SizedBox(
                              height: 100,
                              child: Center(
                                child: Text("No Transactions."),
                              ),
                            )
                          : Column(
                              children: List.generate(
                                mainConntroller.payedExpenses.length == 1
                                    ? 1
                                    : 2,
                                (index) => ExpenseCard(
                                  isPayed: mainConntroller
                                          .payedExpenses[index].expenseStatus ==
                                      ExpenseState.payed,
                                  expenseModel:
                                      mainConntroller.payedExpenses[index],
                                ),
                              ),
                            );
                    })
                  ],
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            if (lsController.currentUser.value.priority == UserPriority.Admin)
              Container(
                width: double.infinity,
                height: 480,
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 20),
                decoration: BoxDecoration(
                    color: mainBgColor,
                    borderRadius: BorderRadius.circular(40)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Text(
                        "Customer Source",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: PieChart(
                          dataMap: ringChatData,
                          baseChartColor: backgroundColor,
                          colorList: colorList,
                          initialAngleInDegree: 0,
                          chartType: ChartType.ring,
                          legendOptions: const LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.right,
                            showLegends: true,
                            legendShape: BoxShape.circle,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: false,
                            showChartValuesInPercentage: false,
                            showChartValuesOutside: false,
                            decimalPlaces: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            if (lsController.currentUser.value.priority == UserPriority.Admin)
              Container(
                width: double.infinity,
                height: 270,
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 20),
                decoration: BoxDecoration(
                    color: mainBgColor,
                    borderRadius: BorderRadius.circular(40)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Text(
                        "Gender",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Icon(
                              FontAwesomeIcons.male,
                              color: Color.fromARGB(255, 41, 101, 169),
                              size: 120,
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(193, 0, 0, 0),
                                  blurRadius: 30,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Male",
                              style: TextStyle(
                                color: textColor,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "$numOfMale",
                              style: const TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(
                              FontAwesomeIcons.female,
                              color: Color.fromARGB(255, 248, 133, 171),
                              size: 120,
                              shadows: [
                                Shadow(
                                  color: Color.fromARGB(193, 0, 0, 0),
                                  blurRadius: 30,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Female",
                              style: TextStyle(
                                color: textColor,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "$numOfFemale",
                              style: const TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            if (lsController.currentUser.value.priority == UserPriority.Admin)
              Container(
                width: double.infinity,
                height: 560,
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 20),
                decoration: BoxDecoration(
                    color: mainBgColor,
                    borderRadius: BorderRadius.circular(40)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Text(
                        "Customer Location",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (locations.isNotEmpty)
                      Expanded(
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: locations.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) {
                            return Card(
                              color: mainBgColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 30,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      locations[index]["kk"],
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      locations[index]["num"].toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                        "${(locations[index]["num"] / totalCustomer * 100 as double).roundToDouble()}%")
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
