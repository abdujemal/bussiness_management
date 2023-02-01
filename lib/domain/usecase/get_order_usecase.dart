import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/order_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetORderUsecase extends BaseUseCase<List<OrderModel>, GetOrderParams> {
  DatabaseRepo databaseRepo;
  GetORderUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, List<OrderModel>>> call(
      GetOrderParams parameters) async {
    final res = await databaseRepo.getOrders(
      parameters.quantity,
      parameters.status,
      parameters.date,
      parameters.isNew,
    );
    return res;
  }
}

class GetOrderParams extends Equatable {
  int? quantity;
  String? status;
  String? date;
  bool isNew;
  GetOrderParams({
    required this.quantity,
    required this.status,
    this.date,
    required this.isNew,
  });
  @override
  List<Object?> get props => [quantity, status, date];
}
