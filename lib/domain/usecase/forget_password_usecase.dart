import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ForgetPasswordUsecase extends BaseUseCase<void, ForegerPasswordParams> {
  AuthRepo authRepo;
  ForgetPasswordUsecase(this.authRepo);
  @override
  Future<Either<Exception, void>> call(ForegerPasswordParams parameters) async {
    final res = await authRepo.forgetPassword(parameters.email);
    return res;
  }
}

class ForegerPasswordParams extends Equatable {
  String email;
  ForegerPasswordParams(this.email);
  @override
  List<Object?> get props => [email];
}
