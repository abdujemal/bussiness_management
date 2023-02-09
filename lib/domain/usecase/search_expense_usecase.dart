import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/expense_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SearchExpenseUsecase
    extends BaseUseCase<List<ExpenseModel>, SearchExpenseParams> {
  DatabaseRepo databaseRepo;
  SearchExpenseUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, List<ExpenseModel>>> call(
      SearchExpenseParams parameters) async {
    final res = await databaseRepo.searchExpense(parameters.sellerName);
    return res;
  }
}

class SearchExpenseParams extends Equatable {
  String sellerName;
  SearchExpenseParams(this.sellerName);

  @override
  List<Object?> get props => [sellerName];
}
