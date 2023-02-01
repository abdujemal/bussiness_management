import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/item_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';

class GetItemUsecase extends BaseUseCase<List<ItemModel>, NoParameters>{
  DatabaseRepo databaseRepo;
  GetItemUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, List<ItemModel>>> call(NoParameters parameters) async {
    final res = await databaseRepo.getItems();
    return res;
  }

}