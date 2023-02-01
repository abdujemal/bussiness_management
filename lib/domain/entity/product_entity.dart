// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  String? id;
  String name;
  String sku;
  String category;
  String description;
  List<dynamic> images;
  double price;
  List<dynamic> tags;
  ProductEntity({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.description,
    required this.images,
    required this.price,
    required this.tags
  });

  @override
  List<Object?> get props =>
      [id, name, sku, category, description, images, price, tags];
}
