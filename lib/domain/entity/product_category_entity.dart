// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductCategoryEntity extends Equatable {
  String name;
  int quantity;
  String assetImage;
  ProductCategoryEntity({
    required this.name,
    required this.assetImage,
    required this.quantity,
  });

  @override
  List<Object?> get props => [name, assetImage, quantity];
}
