import 'package:bussiness_management/domain/entity/item_history_entity.dart';

class ItemHistoryModel extends ItemHistoryEntity {
  int quantity;
  String type;
  String date;
  String id;
  ItemHistoryModel(
      {required this.date, required this.quantity, required this.type, required this.id})
      : super(date: date, type: type, quantity: quantity, id: id);

  Map<String, dynamic> toMap() {
    return {'quantity': quantity, 'type': type, 'date': date, "id": id};
  }
}
