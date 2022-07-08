part of 'assignment_bloc.dart';

abstract class AssignmentState {}

class AssignmentInitial extends AssignmentState {}

class AssignmentData extends AssignmentState {
  final List<Assignment> assignment;

  AssignmentData(this.assignment);
}

class AssignmentLoading extends AssignmentState {}

class AssignmentNoData extends AssignmentState {}

class AssignmentIsError extends AssignmentState {
  final bool isError;
  AssignmentIsError(this.isError);
}
