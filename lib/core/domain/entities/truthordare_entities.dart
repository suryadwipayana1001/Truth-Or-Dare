import 'package:equatable/equatable.dart';

class TruthOrDare extends Equatable {
  final int status;
  final String message;
  final String? data;

  TruthOrDare({required this.status, required this.message, this.data});

  @override
  List<Object?> get props => [status, message, data];
}
