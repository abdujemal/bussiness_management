import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/order_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddOrderUsecase extends BaseUseCase<String, AddOrderParams> {
  DatabaseRepo databaseRepo;
  AddOrderUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, String>> call(AddOrderParams parameters) async {
    final res = await databaseRepo.addOrder(parameters.orderModel);
    return res;
  }

}

class AddOrderParams extends Equatable {
  OrderModel orderModel;
  AddOrderParams(this.orderModel);
  @override
  List<Object?> get props => throw UnimplementedError();
}
