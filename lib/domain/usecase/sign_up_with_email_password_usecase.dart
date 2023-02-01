import 'dart:io';

import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/user_model.dart';
import 'package:bussiness_management/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SignUpWithEmailPasswordUsecase
    extends BaseUseCase<void, SignUpWithEmailPasswordParams> {
  AuthRepo authRepo;
  SignUpWithEmailPasswordUsecase(this.authRepo);
  @override
  Future<Either<Exception, UserModel>> call(
      SignUpWithEmailPasswordParams parameters) async {
    final res = await authRepo.signUpWithEmailnPassword(
        parameters.userModel, parameters.password, parameters.file);
    return res;
  }
}

class SignUpWithEmailPasswordParams extends Equatable {
  UserModel userModel;
  String password;
  File file;
  SignUpWithEmailPasswordParams(this.password, this.userModel, this.file);
  @override
  List<Object?> get props => [userModel, password, file];
}
