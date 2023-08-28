import 'package:dio/dio.dart';
import 'package:truthordare/core/data/models/truthordare_model.dart';
import '../../core.dart';

abstract class TruthOrDareDataSource {
  Future<TruthOrDareModel> getTruthOrDare(String type, String lang);
}

class TruthOrDareDataSourceImplementation implements TruthOrDareDataSource {
  final Dio dio;

  const TruthOrDareDataSourceImplementation({
    required this.dio,
  });

  @override
  Future<TruthOrDareModel> getTruthOrDare(String type, String lang) async {
    String path = type;
    Map<String, dynamic>? param = {'lang': lang};
    try {
      final response = await dio.get(path, queryParameters: param);
      return TruthOrDareModel.fromJson(
        response.data,
      );
    } catch (e) {
      logMe(e);
      rethrow;
    }
  }
}
