import 'dart:convert';

class Assignment {
  late int id;
  late String mapel;
  late String title;
  late String desc;
  late String status;
  late String dl;

  Assignment.toInsert({
    required this.mapel,
    required this.title,
    required this.desc,
    required this.status,
    required this.dl,
  });

  Assignment({
    required this.id,
    required this.mapel,
    required this.title,
    required this.desc,
    required this.status,
    required this.dl,
  });

  Assignment.fromJson(Map<String, dynamic> assignment) {
    id = assignment['id'];
    mapel = assignment['mapel'];
    title = assignment['title'];
    desc = assignment['desc'];
    status = assignment['status'];
    dl = assignment['dl'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "mapel": mapel,
        "title": title,
        "desc": desc,
        "status": status,
        "dl": dl,
      };
}

List<Assignment> parseAssignment(String json) {
  if (json == null) {
    return [];
  }
  final Map<String, dynamic> map = jsonDecode(json);
  final List parsed = map['assignments'];
  return parsed.map((json) => Assignment.fromJson(json)).toList();
}
