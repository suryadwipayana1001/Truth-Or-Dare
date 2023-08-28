import '../../domain/entities/truthordare_entities.dart';

class TruthOrDareModel extends TruthOrDare {
  TruthOrDareModel({
    required int status,
    required String message,
    required String data,
  }) : super(status: status, message: message, data: data);

  factory TruthOrDareModel.fromJson(Map<String, dynamic> json) =>
      TruthOrDareModel(
          status: json['status'], message: json['message'], data: json['data']);
}
