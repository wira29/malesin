import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:malesin/data/bloc/assignment/assignment_repository.dart';
import 'package:malesin/data/db/database_helper.dart';
import 'package:malesin/data/models/assignment.dart';
import 'package:malesin/utils/result_state.dart';

part 'assignment_event.dart';
part 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  AssignmentBloc() : super(AssignmentInitial()) {
    // get assignment
    on<getAssignment>((event, emit) async {
      emit(AssignmentLoading());
      final List<Assignment> data =
          await AssignmentRepository(databaseHelper: _databaseHelper)
              .getAssignment();
      if (data.length > 0) {
        emit(AssignmentData(data));
      } else {
        emit(AssignmentNoData());
      }
    });

    // insert assignment
    on<insertAssignment>((event, emit) async {
      try {
        await AssignmentRepository(databaseHelper: _databaseHelper)
            .insertAssignment(event.assignment);
      } catch (err) {
        print("gagal !!");
        print(err);
      }
    });

    // delete assignment
    on<deleteAssignment>(((event, emit) async {
      try {
        await AssignmentRepository(databaseHelper: _databaseHelper)
            .deleteAssignment(event.id);
      } catch (err) {
        print("gagal !!");
        print(err);
      }
    }));
  }
}
