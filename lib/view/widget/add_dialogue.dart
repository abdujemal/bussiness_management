import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/view/Pages/add_expense.dart';
import 'package:bussiness_management/view/Pages/add_item.dart';
import 'package:bussiness_management/view/Pages/add_order.dart';
import 'package:bussiness_management/view/Pages/add_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddDialogue extends StatefulWidget {
  const AddDialogue({super.key});

  @override
  State<AddDialogue> createState() => _AddDialogueState();
}

class _AddDialogueState extends State<AddDialogue> {
  List<AddMenu> items = [
    AddMenu('assets/expense icon.svg', "Expense", const AddExpense()),
    AddMenu('assets/order icon.svg', "Order", const AddOrder()),
    AddMenu('assets/item icon.svg', "Item", const AddItem()),
    AddMenu('assets/product icon.svg', "Product", const AddProduct()),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: primaryColor, 
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(color: Color.fromARGB(192, 0, 0, 0), spreadRadius: 2, blurRadius: 15)
          ]
        ),
      width: 230,
      height: 260,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: List.generate(
            items.length,
            (index) => ListTile(
                  onTap: () {
                    Get.to(() => items[index].page);
                  },
                  leading: items[index].name == "Product"?
                  const Icon(Icons.star_outline, size: 30,):
                   SvgPicture.asset(
                    items[index].icon,
                    height: 30,
                    color: whiteColor,
                  ),
                  title: Text(
                    items[index].name,
                    style: const TextStyle(fontSize: 24),
                  ),
                )),
      ),
    );
  }
}

class AddMenu {
  String name, icon;
  Widget page;
  AddMenu(this.icon, this.name, this.page);
}
