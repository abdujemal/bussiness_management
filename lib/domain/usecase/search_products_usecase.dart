// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:bussiness_management/base_usecase.dart';
import 'package:bussiness_management/data/model/product_model.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:bussiness_management/domain/usecase/search_customers_usecase.dart';

class SearchProductsUsecase
    extends BaseUseCase<List<ProductModel>, SearchParams> {
  DatabaseRepo databaseRepo;
  SearchProductsUsecase(this.databaseRepo);

  @override
  Future<Either<Exception, List<ProductModel>>> call(
      SearchParams parameters) async {
    final res =
        await databaseRepo.searchProducts(parameters.key, parameters.value, parameters.length);
    return res;
  }
}
