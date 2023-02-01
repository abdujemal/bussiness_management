import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/user_model.dart';
import 'package:bussiness_management/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class GetUserUsecase extends BaseUseCase<UserModel, NoParameters>{
  AuthRepo authRepo;
  GetUserUsecase(this.authRepo);
  @override
  Future<Either<Exception, UserModel>> call(NoParameters parameters) async {
    final res = await authRepo.getUser();
    return res;
  }

}