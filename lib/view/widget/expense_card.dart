import 'package:bussiness_management/constants.dart';
import 'package:bussiness_management/data/model/expense_model.dart';
import 'package:bussiness_management/view/Pages/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseCard extends StatefulWidget {
  final ExpenseModel expenseModel;
  final bool isPayed;
  const ExpenseCard({
    super.key,
    required this.isPayed,
    required this.expenseModel,
  });

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withAlpha(100),
                    blurRadius: 8,
                    offset: const Offset(0, 8))
              ]),
          child: ListTile(
            onTap: () => Get.to(
              () => AddExpense(
                expenseModel: widget.expenseModel,
              ),
            ),
            leading: const Icon(
              Icons.keyboard_arrow_up,
              size: 45,
            ),
            title: Text(
              widget.expenseModel.category,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            trailing: Text(
              '${widget.expenseModel.price} Br',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            subtitle: Text(
              widget.expenseModel.category == ExpenseCategory.employee?
              "Name: ${widget.expenseModel.seller}":
              "Seller: ${widget.expenseModel.seller}",
              style: const TextStyle(
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Positioned(
          right: 30,
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: widget.isPayed
                    ? mainColor
                    : const Color.fromARGB(255, 146, 111, 99),
                shape: BoxShape.circle),
            child: Icon(
              widget.isPayed ? Icons.check : Icons.more_horiz,
              size: 20,
            ),
          ),
        )
      ],
    );
  }
}
