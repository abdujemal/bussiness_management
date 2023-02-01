import 'dart:io';

import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/data/model/cutomer_model.dart';
import 'package:bussiness_management/data/model/expense_chart_model.dart';
import 'package:bussiness_management/data/model/expense_model.dart';
import 'package:bussiness_management/data/model/item_history_model.dart';
import 'package:bussiness_management/data/model/item_model.dart';
import 'package:bussiness_management/data/model/order_model.dart';
import 'package:bussiness_management/data/model/product_model.dart';
import 'package:bussiness_management/data/model/user_model.dart';
import 'package:bussiness_management/domain/usecase/add_customer_usecase.dart';
import 'package:bussiness_management/domain/usecase/add_expense_usecase.dart';
import 'package:bussiness_management/domain/usecase/add_item_history_usecase.dart';
import 'package:bussiness_management/domain/usecase/add_item_usecase.dart';
import 'package:bussiness_management/domain/usecase/add_order_usecase.dart';
import 'package:bussiness_management/domain/usecase/add_product_usecase.dart';
import 'package:bussiness_management/domain/usecase/count_usecase.dart';
import 'package:bussiness_management/domain/usecase/delete_usecase.dart';
import 'package:bussiness_management/domain/usecase/get_customer_usecase.dart';
import 'package:bussiness_management/domain/usecase/get_expense_chart_usecase.dart';
import 'package:bussiness_management/domain/usecase/get_expense_usecase.dart';
import 'package:bussiness_management/domain/usecase/get_items_usecase.dart';
import 'package:bussiness_management/domain/usecase/get_order_chart_usecase.dart';
import 'package:bussiness_management/domain/usecase/get_order_usecase.dart';
import 'package:bussiness_management/domain/usecase/get_products_usecase.dart';
import 'package:bussiness_management/domain/usecase/get_users_usecase.dart';
import 'package:bussiness_management/domain/usecase/search_customers_usecase.dart';
import 'package:bussiness_management/domain/usecase/search_products_usecase.dart';
import 'package:bussiness_management/domain/usecase/update_cutomer_usecase.dart';
import 'package:bussiness_management/domain/usecase/update_expense_usecase.dart';
import 'package:bussiness_management/domain/usecase/update_item_usecase.dart';
import 'package:bussiness_management/domain/usecase/update_order_usecase.dart';
import 'package:bussiness_management/domain/usecase/update_product_usecase.dart';
import 'package:bussiness_management/domain/usecase/update_user_usecase.dart';
import 'package:bussiness_management/notification_service.dart';
import 'package:bussiness_management/view/widget/order_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/order_chart_model.dart';
import '../../domain/usecase/get_single_order_usecase.dart';

class MainConntroller extends GetxController {
  RxInt currentTabIndex = 0.obs;
  RxInt mainIndex = 0.obs;
  Rx<ZoomDrawerController> z = ZoomDrawerController().obs;
  RxBool isAddDialogueOpen = false.obs;
  RxList<String> dropdownVal = <String>[].obs;

  Rx<RequestState> expenseStatus = RequestState.idle.obs;
  Rx<RequestState> orderStatus = RequestState.idle.obs;
  Rx<RequestState> productStatus = RequestState.idle.obs;
  Rx<RequestState> itemStatus = RequestState.idle.obs;
  Rx<RequestState> customerStatus = RequestState.idle.obs;
  Rx<RequestState> stockStatus = RequestState.idle.obs;

  Rx<RequestState> getExpensesStatus = RequestState.idle.obs;
  Rx<RequestState> getOrdersStatus = RequestState.idle.obs;
  Rx<RequestState> getProductsStatus = RequestState.idle.obs;
  Rx<RequestState> getItemsStatus = RequestState.idle.obs;
  Rx<RequestState> getCustomersStatus = RequestState.idle.obs;
  Rx<RequestState> getUsersStatus = RequestState.idle.obs;

  RxList<ExpenseModel> payedExpenses = <ExpenseModel>[].obs;
  RxList<ExpenseModel> unPayedExpenses = <ExpenseModel>[].obs;
  RxList<OrderModel> pendingOrders = <OrderModel>[].obs;
  RxList<OrderModel> deliveredOrders = <OrderModel>[].obs;
  RxList<ExpenseChartModel> expensesChart = <ExpenseChartModel>[].obs;
  RxList<OrderChartModel> ordersChart = <OrderChartModel>[].obs;
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<ItemModel> items = <ItemModel>[].obs;
  RxList<CustomerModel> customers = <CustomerModel>[].obs;
  RxList<ItemHistoryModel> itemHistories = <ItemHistoryModel>[].obs;
  RxList<UserModel> users = <UserModel>[].obs;

  DeleteUsecase deleteUsecase;
  AddExpenseUsecase addExpenseUsecase;
  UpdateExpenseUsecase updateExpenseUsecase;
  GetExpenseUsecase getExpenseUsecase;
  AddProductUsecase addProductUsecase;
  UpdateProductUsecase updateProductUsecase;
  GetProductsUsecase getProductsUsecase;
  SearchProductsUsecase searchProductsUsecase;
  AddOrderUsecase addOrderUsecase;
  UpdateOrderUsecase updateOrderUsecase;
  GetORderUsecase getORderUsecase;
  AddItemUsecase addItemUsecase;
  UpdateItemUsecase updateItemUsecase;
  GetItemUsecase getItemUsecase;
  AddCustomerUsecase addCustomerUsecase;
  UpdateCustomerUsecase updateCustomerUsecase;
  GetCustomerUsecase getCustomerUsecase;
  SearchCustomersUsecase searchCustomersUsecase;
  AddItemHistoryUsecase addItemHistoryUsecase;
  GetUsersUsecase getUsersUsecase;
  UpdateUserUsecase updateUserUsecase;
  CountUsecase countUsecase;
  GetExpenseChartUsecase getExpenseChartUsecase;
  GetOrderChartUsecase getOrderChartUsecase;
  GetSingleOrderUsecase getSingleOrderUsecase;

  Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();

  MainConntroller(
    this.getSingleOrderUsecase,
    this.getExpenseChartUsecase,
    this.getOrderChartUsecase,
    this.countUsecase,
    this.searchCustomersUsecase,
    this.searchProductsUsecase,
    this.getUsersUsecase,
    this.updateUserUsecase,
    this.deleteUsecase,
    this.addExpenseUsecase,
    this.updateExpenseUsecase,
    this.getExpenseUsecase,
    this.getORderUsecase,
    this.getProductsUsecase,
    this.getItemUsecase,
    this.addItemUsecase,
    this.addOrderUsecase,
    this.addProductUsecase,
    this.updateItemUsecase,
    this.updateOrderUsecase,
    this.updateProductUsecase,
    this.addCustomerUsecase,
    this.updateCustomerUsecase,
    this.getCustomerUsecase,
    this.addItemHistoryUsecase,
  );

  setCurrentTabIndex(int val) {
    currentTabIndex.value = val;
  }

  setMainIndex(int val) {
    mainIndex.value = val;
    update();
  }

  toggleAddDialogue() {
    isAddDialogueOpen.value = !isAddDialogueOpen.value;
  }

  // delete

  delete(
    String path,
    String id,
    String name,
    bool alsoImage,
    int? numOfImages,
  ) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      toast("No Network", ToastType.error);
      return;
    }

    if (path == FirebaseConstants.expenses) {
      expenseStatus.value = RequestState.loading;
    } else if (path == FirebaseConstants.items) {
      itemStatus.value = RequestState.loading;
    } else if (path == FirebaseConstants.orders) {
      orderStatus.value = RequestState.loading;
    } else if (path == FirebaseConstants.products) {
      productStatus.value = RequestState.loading;
    } else if (path == FirebaseConstants.customers) {
      customerStatus.value = RequestState.loading;
    }
    final res = await deleteUsecase.call(DeleteParams(
        alsoImage: alsoImage,
        id: id,
        path: path,
        name: name,
        numOfImages: numOfImages));

    res.fold((l) {
      if (path == FirebaseConstants.expenses) {
        expenseStatus.value = RequestState.error;
      } else if (path == FirebaseConstants.items) {
        itemStatus.value = RequestState.error;
      } else if (path == FirebaseConstants.orders) {
        orderStatus.value = RequestState.error;
      } else if (path == FirebaseConstants.products) {
        productStatus.value = RequestState.error;
      } else if (path == FirebaseConstants.customers) {
        customerStatus.value = RequestState.error;
      }
      toast(l.toString(), ToastType.error);
    }, (r) {
      if (path == FirebaseConstants.expenses) {
        expenseStatus.value = RequestState.loaded;
      } else if (path == FirebaseConstants.items) {
        itemStatus.value = RequestState.loaded;
      } else if (path == FirebaseConstants.orders) {
        orderStatus.value = RequestState.loaded;
      } else if (path == FirebaseConstants.products) {
        productStatus.value = RequestState.loaded;
      } else if (path == FirebaseConstants.customers) {
        customerStatus.value = RequestState.loaded;
      }

      if (path == FirebaseConstants.expenses) {
        // getExpenses();
      } else if (path == FirebaseConstants.items) {
        getItems();
      } else if (path == FirebaseConstants.orders) {
        // getOrders();
      } else if (path == FirebaseConstants.products) {
        // getProducts();
      } else if (path == FirebaseConstants.customers) {
        // getCustomers();
      }

      Get.back();
    });
  }

  // user
  getUsers() async {
    getUsersStatus.value = RequestState.loading;

    final res = await getUsersUsecase.call(const NoParameters());

    res.fold((l) {
      getUsersStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      getUsersStatus.value = RequestState.loaded;
      users.value = r;
    });
  }

  updateUser(UserModel userModel) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      toast("No Network", ToastType.error);
      return;
    }

    getUsersStatus.value = RequestState.loading;

    final res = await updateUserUsecase.call(UpdateUserParams(userModel));

    res.fold((l) {
      getUsersStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) async {
      getUsersStatus.value = RequestState.loaded;
      await getUsers();
      toast("Successfully updated.", ToastType.success);
    });
  }

  // stock
  increaseStock(int quantity, ItemModel itemModel,
      ItemHistoryModel itemHistoryModel) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      toast("No Network", ToastType.error);
      return;
    }

    stockStatus.value = RequestState.loading;

    final res = await addItemHistoryUsecase
        .call(AddItemHistoryParams(itemHistoryModel, itemModel.id!));

    res.fold(
      (l) {
        stockStatus.value = RequestState.error;
        toast(l.toString(), ToastType.error);
      },
      (r) async {
        await updateItem(
          null,
          itemModel,
          quantity: itemModel.quantity + quantity,
          stayin: true,
        );
        await getItemHistories(
            items.where((p0) => p0.id == itemModel.id).toList()[0]);
        stockStatus.value = RequestState.loaded;
      },
    );
  }

  decreaseStock(int quantity, ItemModel itemModel,
      ItemHistoryModel itemHistoryModel) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      toast("No Network", ToastType.error);
      return;
    }

    stockStatus.value = RequestState.loading;

    final res = await addItemHistoryUsecase
        .call(AddItemHistoryParams(itemHistoryModel, itemModel.id!));

    res.fold(
      (l) {
        stockStatus.value = RequestState.error;
        toast(l.toString(), ToastType.error);
      },
      (r) async {
        await updateItem(
          null,
          itemModel,
          quantity: itemModel.quantity - quantity,
          stayin: true,
        );

        stockStatus.value = RequestState.loaded;
      },
    );
  }

  // expense

  getExpenses(
      {int? quantity, String? status, String? date, bool isNew = true}) async {
    getExpensesStatus.value = RequestState.loading;
    final res = await getExpenseUsecase.call(GetExpenseParam(
        quantity: quantity, status: status, date: date, isNew: isNew));

    res.fold((l) {
      getExpensesStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      getExpensesStatus.value = RequestState.loaded;

      if (status == ExpenseState.payed) {
        if (isNew) {
          payedExpenses.value = r;
          payedExpenses.sort((a, b) =>
              DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
        } else {
          payedExpenses.addAll(r);
          payedExpenses.sort((a, b) =>
              DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
        }
      } else {
        if (isNew) {
          unPayedExpenses.value = r;
          unPayedExpenses.sort((a, b) =>
              DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
        } else {
          unPayedExpenses.addAll(r);
          unPayedExpenses.sort((a, b) =>
              DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
        }
      }
    });
  }

  addExpense(ExpenseModel expenseModel, {goBack = true}) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      toast("No Network", ToastType.error);
      return;
    }

    expenseStatus.value = RequestState.loading;
    final res = await addExpenseUsecase.call(AddExpenseParams(expenseModel));

    res.fold((l) {
      expenseStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      expenseStatus.value = RequestState.loaded;
      if (goBack) {
        Get.back();
      }
    });
  }

  updateExpense(ExpenseModel expenseModel) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      toast("No Network", ToastType.error);
      return;
    }

    expenseStatus.value = RequestState.loading;
    final res =
        await updateExpenseUsecase.call(UpdateExpenseParams(expenseModel));

    res.fold((l) {
      expenseStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      expenseStatus.value = RequestState.loaded;
      Get.back();
    });
  }

  // products

  getProducts({int? quantity, String? category, bool isNew = true}) async {
    getProductsStatus.value = RequestState.loading;
    if (isNew) {
      products.value = [];
    }
    final res = await getProductsUsecase.call(
      GetProductsParam(quantity: quantity, category: category, isNew: isNew),
    );

    res.fold((l) {
      getProductsStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      if (isNew) {
        getProductsStatus.value = RequestState.loaded;
        products.value = r;
      } else {
        getProductsStatus.value = RequestState.loaded;
        products.addAll(r);
      }
    });
  }

  searchProducts(String key, String value, int length) async {
    getProductsStatus.value = RequestState.loading;
    final res = await searchProductsUsecase
        .call(SearchParams(key: key, value: value, length: length));

    res.fold((l) {
      getProductsStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      getProductsStatus.value = RequestState.loaded;
      products.value = r;
    });
  }

  addProduct(ProductModel productModel, List<File> files) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      toast("No Network", ToastType.error);
      return;
    }

    productStatus.value = RequestState.loading;
    final res =
        await addProductUsecase.call(AddProductsParams(productModel, files));

    res.fold((l) {
      productStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      productStatus.value = RequestState.loaded;
      Get.back();
    });
  }

  updateProduct(ProductModel productModel, List<File> files) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      toast("No Network", ToastType.error);
      return;
    }

    productStatus.value = RequestState.loading;

    final res = await updateProductUsecase
        .call(UpdateProductParams(files, productModel));

    res.fold((l) {
      productStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      productStatus.value = RequestState.loaded;
      // getProducts();
      Get.back();
    });
  }

  // Orders

  getOrders(
      {int? quantity, String? status, String? date, bool isNew = true}) async {
    SharedPreferences pref = await sharedPreferences;

    getOrdersStatus.value = RequestState.loading;
    final res = await getORderUsecase.call(GetOrderParams(
      quantity: quantity,
      status: status,
      date: date,
      isNew: isNew,
    ));

    res.fold((l) {
      getOrdersStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
      print(l.toString());
    }, (r) {
      getOrdersStatus.value = RequestState.loaded;

      if (status == OrderStatus.Pending) {
        if (isNew) {
          String? currentDate = pref.getString("CurrentDate");
          String today = DateTime.now().toString().split(" ")[0];

          pendingOrders.value = r;
          pendingOrders.sort((a, b) => DateTime.parse(a.finishedDate)
              .compareTo(DateTime.parse(b.finishedDate)));

          if (currentDate == null || currentDate != today) {
            pref.setString("CurrentDate", today);

            final list = pendingOrders.length <= 3
                ? pendingOrders
                : pendingOrders.sublist(0, 3);

            int i = 0;
            for (OrderModel orderModel in list) {
              int daysLeft = DateTime.parse(orderModel.finishedDate)
                  .difference(DateTime.now())
                  .inDays;
              NotificationService().showNotification(
                i,
                orderModel.productName,
                "for: ${orderModel.customerName},   $daysLeft days left",
                const Duration(days: 1),
              );
              i++;
            }
          }
        } else {
          pendingOrders.addAll(r);
          pendingOrders.sort((a, b) => DateTime.parse(a.finishedDate)
              .compareTo(DateTime.parse(b.finishedDate)));
        }
      } else {
        if (isNew) {
          deliveredOrders.value = r;
          deliveredOrders.sort((a, b) => DateTime.parse(a.finishedDate)
              .compareTo(DateTime.parse(b.finishedDate)));
        } else {
          deliveredOrders.addAll(r);
          deliveredOrders.sort((a, b) => DateTime.parse(a.finishedDate)
              .compareTo(DateTime.parse(b.finishedDate)));
        }
      }
    });
  }

  getOrder(String id) async {
    orderStatus.value = RequestState.loading;

    final res = await getSingleOrderUsecase.call(GetSingleOrderParams(id));

    OrderModel? orderModel;

    res.fold((l) {
      orderStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      orderStatus.value = RequestState.loaded;
      orderModel = r;
    });

    return orderModel;
  }

  addOrder(OrderModel orderModel) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      toast("No Network", ToastType.error);
      return;
    }

    orderStatus.value = RequestState.loading;
    final res = await addOrderUsecase.call(AddOrderParams(orderModel));

    res.fold((l) {
      orderStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      orderStatus.value = RequestState.loaded;
      Get.back();
      Get.dialog(
          OrderDialog(
            orderModel: orderModel.copyWith(id: r),
          ),
          barrierColor: const Color.fromARGB(200, 0, 0, 0));
    });
  }

  updateOrder(OrderModel orderModel, String prevState) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      toast("No Network", ToastType.error);
      return;
    }

    orderStatus.value = RequestState.loading;
    final res = await updateOrderUsecase.call(UpdateOrderParams(orderModel, prevState));

    res.fold((l) {
      orderStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      orderStatus.value = RequestState.loaded;
      Get.back();
    });
  }

  // Items

  getItems() async {
    getItemsStatus.value = RequestState.loading;
    final res = await getItemUsecase.call(const NoParameters());

    res.fold((l) {
      getItemsStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      getItemsStatus.value = RequestState.loaded;
      items.value = r;
    });
  }

  getItemHistories(ItemModel itemModel) async {
    itemHistories.value = [];
    for (var item in itemModel.history) {
      itemHistories.add(ItemHistoryModel(
          date: item['date'],
          quantity: item['quantity'],
          type: item['type'],
          id: item['id']));
    }
    itemHistories.sort(
        (a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
  }

  addItem(File file, ItemModel itemModel) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      toast("No Network", ToastType.error);
      return;
    }

    itemStatus.value = RequestState.loading;
    final res = await addItemUsecase.call(AddItemParams(file, itemModel));

    res.fold((l) {
      itemStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      itemStatus.value = RequestState.loaded;
      getItems();
      Get.back();
    });
  }

  updateItem(File? file, ItemModel itemModel,
      {bool stayin = false, int? quantity}) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      toast("No Network", ToastType.error);
      return;
    }

    itemStatus.value = RequestState.loading;
    final res = await updateItemUsecase
        .call(UpdateItemParams(file, itemModel, quantity: quantity));

    res.fold((l) {
      itemStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) async {
      itemStatus.value = RequestState.loaded;
      await getItems();
      getItemHistories(items.where((p0) => p0.id == itemModel.id).toList()[0]);
      if (!stayin) {
        Get.back();
      }
    });
  }

  // customers

  getCustomers({int? quantity, int? end}) async {
    getCustomersStatus.value = RequestState.loading;
    final res = await getCustomerUsecase.call(GetCustomersParam(
      start: quantity,
      end: end,
    ));

    res.fold((l) {
      getCustomersStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      getCustomersStatus.value = RequestState.loaded;
      customers.value = r;
    });
  }

  searchCustomers(String key, String value, int length) async {
    getCustomersStatus.value = RequestState.loading;
    final res = await searchCustomersUsecase
        .call(SearchParams(key: key, value: value, length: length));

    res.fold((l) {
      getCustomersStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      getCustomersStatus.value = RequestState.loaded;
      customers.value = r;
    });
  }

  addCustomer(CustomerModel customerModel) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      toast("No Network", ToastType.error);
      return;
    }

    customerStatus.value = RequestState.loading;
    final res = await addCustomerUsecase.call(AddCutomerParams(customerModel));

    res.fold((l) {
      customerStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      customerStatus.value = RequestState.loaded;
      toast("New Customer is Added", ToastType.success);
      Get.back();
    });
  }

  updateCustomer(CustomerModel customerModel) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      toast("No Network", ToastType.error);
      return;
    }

    customerStatus.value = RequestState.loading;
    final res =
        await updateCustomerUsecase.call(UpdateCustomerPArams(customerModel));

    res.fold((l) {
      customerStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      customerStatus.value = RequestState.loaded;
      Get.back();
    });
  }

  getOrderChart() async {
    getOrdersStatus.value = RequestState.loading;

    final res = await getOrderChartUsecase.call(const NoParameters());

    res.fold((l) {
      getOrdersStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      getOrdersStatus.value = RequestState.loaded;
      ordersChart.value = r;
    });
  }

  getExpenseChart() async {
    getExpensesStatus.value = RequestState.loading;

    final res = await getExpenseChartUsecase.call(const NoParameters());

    res.fold((l) {
      getExpensesStatus.value = RequestState.error;
      toast(l.toString(), ToastType.error);
    }, (r) {
      getExpensesStatus.value = RequestState.loaded;
      expensesChart.value = r;
    });
  }
}