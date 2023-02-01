import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/order_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateOrderUsecase extends BaseUseCase<void, UpdateOrderParams> {
  DatabaseRepo databaseRepo;
  UpdateOrderUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, void>> call(UpdateOrderParams parameters) async {
    final res = await databaseRepo.updateOrder(parameters.orderModel, parameters.prevState);
    return res;
  }
}

class UpdateOrderParams extends Equatable {
  OrderModel orderModel;
  String prevState;
  UpdateOrderParams(this.orderModel, this.prevState);

  @override
  List<Object?> get props => [orderModel, prevState];
}
