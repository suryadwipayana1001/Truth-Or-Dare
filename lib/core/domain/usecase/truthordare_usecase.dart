import 'package:dartz/dartz.dart';
import '../../core.dart';
import '../../data/repositories/truthordare_repositories.dart';

abstract class TruthOrDareUseCase<Type> {
  Future<Either<Failure, dynamic>> call(String type, String lang);
}

class TruthOrDare implements TruthOrDareUseCase<int> {
  final TruthOrDareRepository repository;

  TruthOrDare(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(String type, String lang) async {
    return await repository.getTruthOrDare(type, lang);
  }
}
