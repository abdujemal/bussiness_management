// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bussiness_management/data/model/order_chart_model.dart';
import 'package:dartz/dartz.dart';

import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';

class GetOrderChartUsecase extends BaseUseCase<List<OrderChartModel>, NoParameters> {
  DatabaseRepo databaseRepo;
  GetOrderChartUsecase(this.databaseRepo);

  @override
  Future<Either<Exception, List<OrderChartModel>>> call(NoParameters parameters) async {
    final res = await databaseRepo.getOrderChart();
    return res;
  }
}
