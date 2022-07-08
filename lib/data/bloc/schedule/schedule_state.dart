part of 'schedule_bloc.dart';

abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleData extends ScheduleState {
  List<ListSchedule> scheduleList;
  ScheduleData(this.scheduleList);
}

class ScheduleSingleData extends ScheduleState {
  List<Schedule> schedule;
  ScheduleSingleData(this.schedule);
}

class ScheduleLoading extends ScheduleState {}
