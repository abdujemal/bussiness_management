import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/expense_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateExpenseUsecase extends BaseUseCase<void, UpdateExpenseParams> {
  DatabaseRepo databaseRepo;
  UpdateExpenseUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, void>> call(UpdateExpenseParams parameters) async {
    final res = await databaseRepo.updateExpense(parameters.expenseModel);
    return res;
  }
}

class UpdateExpenseParams extends Equatable {
  ExpenseModel expenseModel;
  UpdateExpenseParams(this.expenseModel);

  @override
  List<Object?> get props => [expenseModel];
}
