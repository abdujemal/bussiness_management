import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/cutomer_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddCustomerUsecase extends BaseUseCase<void, AddCutomerParams> {
  DatabaseRepo databaseRepo;
  AddCustomerUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, void>> call(AddCutomerParams parameters) async {
    final res = await databaseRepo.addCustomer(parameters.customerModel);
    return res;
  }
}

class AddCutomerParams extends Equatable {
  CustomerModel customerModel;
  AddCutomerParams(this.customerModel);
  @override
  List<Object?> get props => [customerModel];
}
