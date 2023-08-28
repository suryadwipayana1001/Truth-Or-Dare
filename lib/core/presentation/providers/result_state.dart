import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';

abstract class ResultState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResultInitial extends ResultState {}

class ResultLoading extends ResultState {}

class ResultSuccess extends ResultState {
  ResultSuccess();
}

class ResultFailure extends ResultState {
  final Failure error;

  ResultFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
