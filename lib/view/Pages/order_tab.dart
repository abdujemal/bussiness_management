import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/data/model/order_model.dart';
import 'package:bussiness_management/view/Pages/qr_scanner_page.dart';
import 'package:bussiness_management/view/controller/main_controller.dart';
import 'package:bussiness_management/view/widget/date_item.dart';
import 'package:bussiness_management/view/widget/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OrderTab extends StatefulWidget {
  const OrderTab({super.key});

  @override
  State<OrderTab> createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab> with AutomaticKeepAliveClientMixin<OrderTab> {
  MainConntroller mainConntroller = Get.find<MainConntroller>();

  int selectedTabIndex = 0;

  ScrollController controller = ScrollController();

  int pageNum = 2;

  @override
  void initState() {
    super.initState();
    controller.addListener(handleScrolling);
  }

  void handleScrolling() {
    if (controller.offset >= controller.position.maxScrollExtent) {
      if (mainConntroller.getOrdersStatus.value != RequestState.loading) {
        mainConntroller.getOrders(
          quantity: numOfDocToGet,
          status: OrderStatus.list[selectedTabIndex],
          isNew: false,
        );
        pageNum = pageNum + 1;
        if(selectedTabIndex == 0){
          print("${mainConntroller.pendingOrders.length} orders");
        }else{
          print("${mainConntroller.deliveredOrders.length} orders");
        }
      }
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
          title: title("Orders"),
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
                Get.to(
                  () => const QrScannerPage(),
                );
              },
              icon: const Icon(Icons.qr_code_scanner),
            ),
            IconButton(
              onPressed: () {
                mainConntroller.getOrders(
                  quantity: numOfDocToGet,
                  status: OrderStatus.Pending,
                );
                mainConntroller.getOrders(
                  quantity: numOfDocToGet,
                  status: OrderStatus.Delivered,
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
                  OrderStatus.list.length,
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
                        OrderStatus.list[index],
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40, top: 10),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: mainBgColor,
                  child: Obx(
                    () {
                      List<dynamic> orders = [];
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

                      for (OrderModel orderModel in selectedTabIndex == 0
                          ? mainConntroller.pendingOrders
                          : mainConntroller.deliveredOrders) {
                        if (currentDate != orderModel.finishedDate) {
                          if (today == orderModel.finishedDate) {
                            orders.add("Today");
                            currentDate = orderModel.finishedDate;
                          } else {
                            orders.add(
                              orderModel.finishedDate.replaceAll("-", "/"),
                            );
                            currentDate = orderModel.finishedDate;
                          }
                        }
                        orders.add(orderModel);
                      }

                      // if (mainConntroller.getOrdersStatus.value ==
                      //     RequestState.loading) {
                      //   return Center(
                      //     child: CircularProgressIndicator(
                      //       color: primaryColor,
                      //     ),
                      //   );
                      // }
                      if (selectedTabIndex == 0 &&
                          mainConntroller.pendingOrders.isEmpty) {
                        return const Center(
                          child: Text("No Orders."),
                        );
                      }
                      if (selectedTabIndex == 1 &&
                          mainConntroller.deliveredOrders.isEmpty) {
                        return const Center(
                          child: Text("No Orders."),
                        );
                      }
                      return Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                controller: controller,
                                // physics: const BouncingScrollPhysics(),
                                itemCount: orders.length,
                                itemBuilder: (context, index) {
                                  if (orders[index].runtimeType.toString() ==
                                      "String") {
                                    return DateItem(
                                      date: orders[index],
                                      style: orders[index] == "Finished orders"
                                          ? TextStyle(
                                              color: primaryColor, fontSize: 18)
                                          : null,
                                    );
                                  } else {
                                    return OrderItem(
                                      isFinished: orders[index].status ==
                                          OrderStatus.Delivered,
                                      isDelivery:
                                          orders[index].deliveryOption ==
                                              DeliveryOption.delivery,
                                      orderModel: orders[index],
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          mainConntroller.getOrdersStatus.value ==
                                  RequestState.loading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                )
                              : const SizedBox()
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
  
  @override
  bool get wantKeepAlive => true;
}
