// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bussiness_management/domain/entity/product_category_entity.dart';

class ProductCategoryModel extends ProductCategoryEntity {
  String name;
  int quantity;
  String assetImage;
  ProductCategoryModel({
    required this.name,
    required this.assetImage,
    required this.quantity
  }) : super(
          assetImage: assetImage,
          name: name,
          quantity: quantity
        );

  ProductCategoryModel copyWith({
    String? name,
    int? quantity,
    String? assetImage,
  }) {
    return ProductCategoryModel(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      assetImage: assetImage ?? this.assetImage,
    );
  }
}
