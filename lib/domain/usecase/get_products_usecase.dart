// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/product_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';

class GetProductsUsecase
    extends BaseUseCase<List<ProductModel>, GetProductsParam> {
  DatabaseRepo databaseRepo;
  GetProductsUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, List<ProductModel>>> call(
      GetProductsParam parameters) async {
    final res = await databaseRepo.getProducts(
      parameters.quantity,
      parameters.category,
      parameters.isNew,
    );
    return res;
  }
}

class GetProductsParam extends Equatable {
  int? quantity;
  bool isNew;
  String? category;
  GetProductsParam({
    required this.isNew,
    required this.quantity,
    required this.category,
  });
  @override
  List<Object?> get props => [quantity, isNew, category];
}
