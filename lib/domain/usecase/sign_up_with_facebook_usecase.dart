import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/user_model.dart';
import 'package:bussiness_management/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SignUpWithFacebookUsecase extends BaseUseCase<void, SignUpWithFacebookParams> {
  AuthRepo authRepo;
  SignUpWithFacebookUsecase(this.authRepo);
  
  @override
  Future<Either<Exception, void>> call(SignUpWithFacebookParams parameters) async {
    final res = await authRepo.signUpWithFacebook(parameters.userModel, parameters.priority);
    return res;
  }
  

}

class SignUpWithFacebookParams extends Equatable {
  UserModel? userModel;
  String priority;
  SignUpWithFacebookParams(this.priority, this.userModel);
  
  @override
  List<Object?> get props => [priority, userModel];
}
