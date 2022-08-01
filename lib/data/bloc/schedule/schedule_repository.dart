import 'package:malesin/data/db/database_helper.dart';
import 'package:malesin/data/models/listSchedule.dart';
import 'package:malesin/data/models/schedule.dart';

class ScheduleRepository {
  final DatabaseHelper databaseHelper;

  ScheduleRepository({required this.databaseHelper});

  Future<List<ListSchedule>> getScheduleList() async {
    List<ListSchedule> list = [
      ListSchedule(idList: 0, schedules: []),
      ListSchedule(idList: 1, schedules: []),
      ListSchedule(idList: 2, schedules: []),
      ListSchedule(idList: 3, schedules: []),
      ListSchedule(idList: 4, schedules: []),
      ListSchedule(idList: 5, schedules: []),
    ];

    var results = await databaseHelper.getListSchedule();

    results.forEach((element) {
      var tmp = Schedule.fromJson(element);
      list[tmp.day].schedules.add(tmp);
    });
    return list;
  }

  Future<List<Schedule>> getSchedule(int day) async {
    var result = await databaseHelper.getSchedule(day);
    result = (result != null) ? result : [];
    return result.map((res) => Schedule.fromJson(res)).toList();
  }

  Future<void> insertSchedule(Schedule data) async {
    await databaseHelper.insertSchedule(data);
  }

  Future<void> deleteSchedule(int id) async {
    await databaseHelper.deleteSchedule(id);
  }
}
