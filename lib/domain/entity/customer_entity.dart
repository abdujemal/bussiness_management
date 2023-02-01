// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  String name;
  String? id;
  String phone;
  String sefer;
  String kk;
  String location;
  String gender;
  String source;
  CustomerEntity({
    required this.gender,
    required this.name,
    required this.id,
    required this.phone,
    required this.sefer,
    required this.kk,
    required this.location,
    required this.source,
  });

  @override
  List<Object?> get props =>
      [name, id, phone, sefer, kk, location, gender, source];
}
