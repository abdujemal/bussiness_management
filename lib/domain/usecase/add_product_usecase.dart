import 'dart:io';

import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/product_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddProductUsecase extends BaseUseCase<void, AddProductsParams> {
  DatabaseRepo databaseRepo;
  AddProductUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, void>> call(AddProductsParams parameters) async {
    final res =
        await databaseRepo.addProduct(parameters.productModel, parameters.files);
    return res;
  }
}

class AddProductsParams extends Equatable {
  ProductModel productModel;
  List<File> files;
  AddProductsParams(this.productModel, this.files);
  @override
  List<Object?> get props => [productModel, files];
}
