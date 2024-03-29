// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bussiness_management/domain/entity/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  String name;
  String? id;
  String phone;
  String sefer;
  String kk;
  String location;
  String gender;
  String source;
  CustomerModel({
    required this.gender,
    required this.name,
    required this.id,
    required this.phone,
    required this.sefer,
    required this.kk,
    required this.location,
    required this.source,
  }) : super(
            gender: gender,
            name: name,
            id: id,
            phone: phone,
            sefer: sefer,
            kk: kk,
            location: location,
            source: source);

  factory CustomerModel.fromFirebase(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return CustomerModel(
      name: data['name'],
      id: snapshot.id,
      phone: data['phone'],
      sefer: data['sefer'],
      kk: data['kk'],
      gender: data['gender'],
      location: data['location'],
      source: data['source'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'sefer': sefer,
      'kk': kk,
      'gender': gender,
      'location': location,
      'source': source,
    };
  }
}
