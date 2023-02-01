import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';

class SignOutUsecase extends BaseUseCase<void, NoParameters>{
  AuthRepo authRepo;
  SignOutUsecase(this.authRepo);
  @override
  Future<Either<Exception, void>> call(NoParameters parameters) async {
    final res = await authRepo.signOut();
    return res;
  }
}