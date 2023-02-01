// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class LineChartModel extends Equatable {
  String title;
  double leftVal;
  double rightVal;
  LineChartModel({
    required this.title,
    required this.leftVal,
    required this.rightVal,
  });

  @override
  List<Object?> get props => [title, leftVal, rightVal];
}
