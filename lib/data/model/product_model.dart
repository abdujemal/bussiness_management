// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bussiness_management/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  String? id;
  String name;
  String sku;
  String category;
  String description;
  List<dynamic> images;
  double price;
  List<dynamic> tags;
  ProductModel({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.description,
    required this.images,
    required this.price,
    required this.tags,
  }) : super(
          id: id,
          name: name,
          sku: sku,
          category: category,
          description: description,
          images: images,
          price: price,
          tags: tags,
        );

  factory ProductModel.fromFirebase(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductModel(
        id: snapshot.id,
        name: data['name'],
        sku: data['sku'],
        category: data['category'],
        description: data['description'],
        images: data['images'],
        price: data['price'],
        tags: data['tags']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sku': sku,
      'category': category,
      'description': description,
      'images': images,
      'price': price,
      'tags': tags
    };
  }

  

  ProductModel copyWith({
    String? id,
    String? name,
    String? sku,
    String? category,
    String? description,
    List<dynamic>? images,
    double? price,
    List<dynamic>? tags,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      category: category ?? this.category,
      description: description ?? this.description,
      images: images ?? this.images,
      price: price ?? this.price,
      tags: tags ?? this.tags,
    );
  }
}
