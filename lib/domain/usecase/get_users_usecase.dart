import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/user_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';

class GetUsersUsecase extends BaseUseCase<List<UserModel>, NoParameters>{
  DatabaseRepo databaseRepo;
  GetUsersUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, List<UserModel>>> call(NoParameters parameters) async {
    final res = await databaseRepo.getUsers();
    return res;
  }

}