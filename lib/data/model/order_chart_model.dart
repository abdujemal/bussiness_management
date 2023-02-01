import 'package:bussiness_management/domain/entity/order_chart_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderChartModel extends OrderChartEntity {
  String date;
  double price;
  String orderId;
  OrderChartModel({
    required this.date,
    required this.price,
    required this.orderId,
  }) : super(
          date: date,
          price: price,
          orderId: orderId,
        );

  factory OrderChartModel.fromMap(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return OrderChartModel(date: data["date"], price: data["price"], orderId: data['orderId']);
  }

  toMap() {
    return {
      'date': date,
      'price': price,
      'orderId': orderId,
    };
  }
}
