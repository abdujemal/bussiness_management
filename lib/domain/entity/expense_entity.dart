// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ExpenseEntity extends Equatable {
  String? id;
  String category;
  String description;
  double price;
  String expenseStatus;
  String seller;
  String date;
  ExpenseEntity({
    required this.id,
    required this.category,
    required this.description,
    required this.price,
    required this.expenseStatus,
    required this.seller,
    required this.date
  });
  @override
  List<Object?> get props => [
        id,
        category,
        description,
        price,
        expenseStatus,
        seller,
        date
      ];
}
