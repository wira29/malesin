class Schedule {
  late int id;
  late String title;
  late String start;
  late String end;
  late int day;

  Schedule(
      {required this.id,
      required this.title,
      required this.start,
      required this.end,
      required this.day});

  Schedule.toInsert(
      {required this.title,
      required this.start,
      required this.end,
      required this.day});

  Schedule.fromJson(Map<String, dynamic> schedule) {
    id = schedule['id'];
    title = schedule['title'];
    start = schedule['start'];
    end = schedule['end'];
    day = schedule['day'];
  }

  Map<String, dynamic> toJson() => {
        "title": this.title,
        "start": this.start,
        "end": this.end,
        "day": this.day,
      };
}
