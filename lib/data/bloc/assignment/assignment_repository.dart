import 'package:malesin/data/db/database_helper.dart';
import 'package:malesin/data/models/assignment.dart';

import 'assignment_bloc.dart';

class AssignmentRepository {
  final DatabaseHelper databaseHelper;

  AssignmentRepository({required this.databaseHelper});

  Future<List<Assignment>> getAssignment() async {
    var results = await databaseHelper.getAssignments();
    results = (results != null) ? results : [];
    return results.map((res) => Assignment.fromJson(res)).toList();
  }

  Future<void> insertAssignment(newData) async {
    await databaseHelper.insertAssignment(newData);
  }

  Future<void> deleteAssignment(id) async {
    await databaseHelper.deleteAssignment(id);
  }
}
