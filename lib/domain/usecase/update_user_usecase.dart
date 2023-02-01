import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/user_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateUserUsecase extends BaseUseCase<void, UpdateUserParams> {
  DatabaseRepo databaseRepo;
  UpdateUserUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, void>> call(UpdateUserParams parameters) async {
    final res = await databaseRepo.updateUser(parameters.userModel);
    return res;
  }
}

class UpdateUserParams extends Equatable {
  UserModel userModel;
  UpdateUserParams(this.userModel);

  @override
  List<Object?> get props => [userModel];
}
