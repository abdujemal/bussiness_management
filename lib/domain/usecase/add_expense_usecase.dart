import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/expense_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddExpenseUsecase extends BaseUseCase<void, AddExpenseParams> {
  DatabaseRepo databaseRepo;
  AddExpenseUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, void>> call(AddExpenseParams parameters) async {
    final res = await databaseRepo.addExpense(parameters.expenseModel);
    return res;
  }
}

class AddExpenseParams extends Equatable {
  ExpenseModel expenseModel;
  AddExpenseParams(this.expenseModel);
  @override
  List<Object?> get props => [expenseModel];
}
