import 'package:malesin/data/models/schedule.dart';

class ListSchedule {
  late int idList;
  late List<Schedule> schedules;

  ListSchedule({required this.idList, required this.schedules});

  ListSchedule.fromJson(Map<String, dynamic> list) {
    idList = list['idList'];
    schedules = list['schedules'];
  }
}
