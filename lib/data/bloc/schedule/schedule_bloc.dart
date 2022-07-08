import 'package:bloc/bloc.dart';
import 'package:malesin/data/bloc/schedule/schedule_repository.dart';
import 'package:malesin/data/db/database_helper.dart';
import 'package:malesin/data/models/listSchedule.dart';
import 'package:malesin/data/models/schedule.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  ScheduleBloc() : super(ScheduleInitial()) {
    on<getScheduleList>((event, emit) async {
      emit(ScheduleLoading());
      List<ListSchedule> result =
          await ScheduleRepository(databaseHelper: _databaseHelper)
              .getScheduleList();
      emit(ScheduleData(result));
    });

    on<getSchedule>((event, emit) async {
      emit(ScheduleLoading());
      List<Schedule> result =
          await ScheduleRepository(databaseHelper: _databaseHelper)
              .getSchedule(event.day);
      emit(ScheduleSingleData(result));
    });

    on<insertSchedule>((event, emit) async {
      await ScheduleRepository(databaseHelper: _databaseHelper)
          .insertSchedule(event.data);
    });

    on<deleteSchedule>((event, emit) async {
      await ScheduleRepository(databaseHelper: _databaseHelper)
          .deleteSchedule(event.id);
    });
  }
}
