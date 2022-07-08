part of 'assignment_bloc.dart';

abstract class AssignmentEvent {
  const AssignmentEvent();
}

class getAssignment extends AssignmentEvent {
  getAssignment();
}

class insertAssignment extends AssignmentEvent {
  final Assignment assignment;
  insertAssignment(this.assignment);
}

class deleteAssignment extends AssignmentEvent {
  final int id;
  deleteAssignment(this.id);
}

class assignmentError extends AssignmentEvent {
  assignmentError();
}
