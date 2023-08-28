import 'package:dartz/dartz.dart';
import 'package:truthordare/core/data/datasources/truthordare_datasource.dart';
import 'package:truthordare/core/domain/entities/truthordare_entities.dart';

import '../../core.dart';
import '../../network/network_info.dart';

abstract class TruthOrDareRepository {
  Future<Either<Failure, TruthOrDare>> getTruthOrDare(String type, String lang);
}

class TruthOrDareRepositoryImplementation implements TruthOrDareRepository {
  final TruthOrDareDataSource dataSource;
  final NetworkInfo networkInfo;
  TruthOrDareRepositoryImplementation(
      {required this.dataSource, required this.networkInfo});

  @override
  Future<Either<Failure, TruthOrDare>> getTruthOrDare(
      String type, String lang) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.getTruthOrDare(type, lang);
        return Right(result);
      } catch (e) {
        return const Left(ServerFailure());
      }
    }
    return const Left(ServerFailure());
  }
}
