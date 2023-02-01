import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/order_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetSingleOrderUsecase
    extends BaseUseCase<OrderModel, GetSingleOrderParams> {
  DatabaseRepo databaseRepo;
  GetSingleOrderUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, OrderModel>> call(
      GetSingleOrderParams parameters) async {
    final res = await databaseRepo.getOrder(parameters.id);
    return res;
  }
}

class GetSingleOrderParams extends Equatable {
  String id;
  GetSingleOrderParams(this.id);

  @override
  List<Object?> get props => [id];
}
