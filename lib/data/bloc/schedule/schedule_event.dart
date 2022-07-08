part of 'schedule_bloc.dart';

abstract class ScheduleEvent {}

class getScheduleList extends ScheduleEvent {}

class getSchedule extends ScheduleEvent {
  int day;
  getSchedule(this.day);
}

class insertSchedule extends ScheduleEvent {
  Schedule data;
  insertSchedule(this.data);
}

class deleteSchedule extends ScheduleEvent {
  int id;
  deleteSchedule(this.id);
}
