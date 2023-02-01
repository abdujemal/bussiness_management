// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ExpenseChartEnitity extends Equatable {
  String date;
  double price;
  String category;
  String id;
  ExpenseChartEnitity({
    required this.date,
    required this.price,
    required this.category,
    required this.id,

  });

  @override
  List<Object?> get props => [id, date, price, category];
}
