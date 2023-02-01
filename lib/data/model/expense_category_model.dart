// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ExpenseCategoryModel extends Equatable {
  String title;
  double persontage;
  double price;
  int numOfTransaction;
  ExpenseCategoryModel({
    required this.title,
    required this.persontage,
    required this.price,
    required this.numOfTransaction,
  });

  @override
  List<Object?> get props => [title, persontage, price];
}
