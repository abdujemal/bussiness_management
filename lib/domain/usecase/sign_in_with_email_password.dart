import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/user_model.dart';
import 'package:bussiness_management/domain/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SignInWithEmailPasswordUSecase extends BaseUseCase<UserModel, SignInWithEmailPAsswordPArams> {
  AuthRepo authRepo;
  SignInWithEmailPasswordUSecase(this.authRepo);
  @override
  Future<Either<Exception, UserModel>> call(SignInWithEmailPAsswordPArams parameters) async {
    final res = await authRepo.signInWithEmailnPassword(parameters.email, parameters.password);
    return res;
  }

}

class SignInWithEmailPAsswordPArams extends Equatable{
  String email;
  String password;
  SignInWithEmailPAsswordPArams(this.email, this.password);
  
  @override
  List<Object?> get props => [email, password];


}