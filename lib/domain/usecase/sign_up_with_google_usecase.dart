import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/user_model.dart';
import 'package:bussiness_management/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SignUpWithGoogleUsecase extends BaseUseCase<void, SignUpWithGoogleParams> {
  AuthRepo authRepo;
  SignUpWithGoogleUsecase(this.authRepo);
  @override
  Future<Either<Exception, void>> call(SignUpWithGoogleParams parameters) async {
    final res = await authRepo.signUpWithGoogle(parameters.userModel, parameters.priority);
    return res;
  }

}

class SignUpWithGoogleParams extends Equatable {
  UserModel userModel;
  String priority;
  SignUpWithGoogleParams(this.priority, this.userModel);
  
  @override
  List<Object?> get props => [userModel, priority];
}
