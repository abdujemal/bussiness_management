import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/cutomer_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateCustomerUsecase extends BaseUseCase<void, UpdateCustomerPArams> {
  DatabaseRepo databaseRepo;
  UpdateCustomerUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, void>> call(UpdateCustomerPArams parameters) async {
    final res = await databaseRepo.updateCustomer(parameters.customerModel);
    return res;
  }
}

class UpdateCustomerPArams extends Equatable {
  CustomerModel customerModel;
  UpdateCustomerPArams(this.customerModel);
  @override
  List<Object?> get props => [customerModel];
}
