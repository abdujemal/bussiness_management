import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/item_history_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddItemHistoryUsecase extends BaseUseCase<void, AddItemHistoryParams>{
  DatabaseRepo databaseRepo;
  AddItemHistoryUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, void>> call(AddItemHistoryParams parameters) async {
    final res = await databaseRepo.addItemHistory(parameters.itemHistoryModel, parameters.itemId);
    return res;
  }

}

class AddItemHistoryParams extends Equatable {
  ItemHistoryModel itemHistoryModel;
  String itemId;
  AddItemHistoryParams(this.itemHistoryModel, this.itemId);
  @override
  List<Object?> get props => [itemHistoryModel, itemId];
}
