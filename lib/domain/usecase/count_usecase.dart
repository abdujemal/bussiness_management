// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bussiness_management/data/data_src/database_data_src.dart';
import 'package:bussiness_management/domain/repo/database_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:bussiness_management/base_usecase.dart';

class CountUsecase extends BaseUseCase<int, CounterParams> {
  DatabaseRepo databaseRepo;
  CountUsecase(this.databaseRepo);
  @override
  Future<Either<Exception, int>> call(CounterParams parameters) async {
    final res = await databaseRepo.count(
        parameters.path, parameters.key, parameters.value);
    return res;
  }
}

class CounterParams extends Equatable {
  String path;
  String key;
  String value;
  CounterParams({
    required this.path,
    required this.key,
    required this.value,
  });

  @override
  List<Object?> get props => [path, key, value];
}
