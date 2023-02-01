// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  String? id;
  String customerName;
  String customerGender;
  String phoneNumber;
  String productName;
  double productPrice;
  double payedPrice;
  String productSku;
  int quantity;
  String orderedDate;
  String finishedDate;
  String status;
  String sefer;
  String customerSource;
  String kk;
  String location;
  String paymentMethod;
  String deliveryOption;
  String imgUrl;
  String productDescription;
  OrderEntity({
    required this.id,
    required this.customerName,
    required this.phoneNumber,
    required this.productName,
    required this.productPrice,
    required this.productSku,
    required this.quantity,
    required this.orderedDate,
    required this.finishedDate,
    required this.status,
    required this.sefer,
    required this.customerSource,
    required this.kk,
    required this.location,
    required this.paymentMethod,
    required this.deliveryOption,
    required this.customerGender,
    required this.imgUrl,
    required this.productDescription,
    required this.payedPrice,
  });

  @override
  List<Object?> get props => [
        id,
        customerName,
        phoneNumber,
        productName,
        productPrice,
        productSku,
        quantity,
        orderedDate,
        finishedDate,
        status,
        sefer,
        customerSource,
        kk,
        location,
        paymentMethod,
        deliveryOption,
        customerGender,
        imgUrl,
        productDescription,
        payedPrice,
      ];
}
