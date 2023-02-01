import 'dart:io';

import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/product_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateProductUsecase extends BaseUseCase<void, UpdateProductParams> {
  DatabaseRepo databaseRepo;
  UpdateProductUsecase(this.databaseRepo);

  @override
  Future<Either<Exception, void>> call(UpdateProductParams parameters) async {
    final res = await databaseRepo.updateProduct(
        parameters.productModel, parameters.files);
    return res;
  }
}

class UpdateProductParams extends Equatable {
  ProductModel productModel;
  List<File> files;
  UpdateProductParams(this.files, this.productModel);
  @override
  List<Object?> get props => [files, productModel];
}
