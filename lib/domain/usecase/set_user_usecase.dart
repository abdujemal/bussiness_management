import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/user_model.dart';
import 'package:bussiness_management/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SetUserUsecase extends BaseUseCase<void, SetUserParams> {
  AuthRepo authRepo;
  SetUserUsecase(this.authRepo);
  @override
  Future<Either<Exception, void>> call(
      SetUserParams parameters) async {
    final res = await authRepo.setUser(parameters.userModel);
    return res;
  }
}

class SetUserParams extends Equatable {
  UserModel userModel;
  SetUserParams(this.userModel);
  @override
  List<Object?> get props => [userModel];
}
