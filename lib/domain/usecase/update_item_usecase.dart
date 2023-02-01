import 'dart:io';

import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/item_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateItemUsecase extends BaseUseCase<void, UpdateItemParams> {
  DatabaseRepo databaseRepo;
  UpdateItemUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, void>> call(UpdateItemParams parameters) async {
    final res = await databaseRepo
        .updateItem(parameters.itemModel, parameters.file, quantity: parameters.quantity);
    return res;
  }
}

class UpdateItemParams extends Equatable {
  ItemModel itemModel;
  File? file;
  int? quantity;
  UpdateItemParams(this.file, this.itemModel, {this.quantity});
  @override
  List<Object?> get props => [file, itemModel, quantity];
}
