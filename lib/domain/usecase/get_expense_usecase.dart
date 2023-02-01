// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/expense_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';

class GetExpenseUsecase
    extends BaseUseCase<List<ExpenseModel>, GetExpenseParam> {
  DatabaseRepo databaseRepo;
  GetExpenseUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, List<ExpenseModel>>> call(
      GetExpenseParam parameters) async {
    final res = await databaseRepo.getExpenses(
      parameters.quantity,
      parameters.status,
      parameters.date,
      parameters.isNew
    );
    return res;
  }
}

class GetExpenseParam extends Equatable {
  int? quantity;
  String? status;
  String? date;
  bool isNew;
  GetExpenseParam({
    required this.quantity,
    required this.status,
    required this.date,
    required this.isNew,
  });
  @override
  List<Object?> get props => [quantity, status, date];
}
