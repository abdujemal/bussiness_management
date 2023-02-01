import 'dart:io';

import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/item_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddItemUsecase extends BaseUseCase<void, AddItemParams> {
  DatabaseRepo databaseRepo;
  AddItemUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, void>> call(AddItemParams parameters) async {
    final res =
        await databaseRepo.addItem(parameters.itemModel, parameters.file);
    return res;
  }
}

class AddItemParams extends Equatable {
  ItemModel itemModel;
  File file;
  AddItemParams(this.file, this.itemModel);
  @override
  List<Object?> get props => [file, itemModel];
}
