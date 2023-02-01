// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/cutomer_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';

class GetCustomerUsecase
    extends BaseUseCase<List<CustomerModel>, GetCustomersParam> {
  DatabaseRepo databaseRepo;
  GetCustomerUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, List<CustomerModel>>> call(
      GetCustomersParam parameters) async {
    final res = await databaseRepo.getCustomers(
      parameters.start,
      parameters.end,
    );
    return res;
  }
}

class GetCustomersParam extends Equatable {
  int? start;
  int? end;
  GetCustomersParam({
    required this.start,
    required this.end,
  });
  @override
  List<Object?> get props => [start, end];
}
