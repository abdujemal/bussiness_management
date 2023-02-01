import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  String? id;
  String? image;
  String name;
  String category;
  String unit;
  double pricePerUnit;
  String description;
  int quantity;
  List<dynamic> history;
  ItemEntity({
    required this.id,
    required this.image,
    required this.name,
    required this.category,
    required this.unit,
    required this.pricePerUnit,
    required this.description,
    required this.quantity,
    required this.history,
  });

  @override
  List<Object?> get props => [
        id,
        image,
        name,
        category,
        unit,
        category,
        unit,
        pricePerUnit,
        description,
        quantity,
        history
      ];
}
