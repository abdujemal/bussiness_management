import 'package:equatable/equatable.dart';

class ItemHistoryEntity extends Equatable {
  int quantity;
  String type;
  String date;
  String id;
  ItemHistoryEntity(
      {required this.id, required this.date, required this.quantity, required this.type});
  @override
  List<Object?> get props => [quantity, type, date, id];
}
