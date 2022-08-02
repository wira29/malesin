import 'dart:isolate';

import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:malesin/data/bloc/assignment/assignment_repository.dart';
import 'package:malesin/data/db/database_helper.dart';
import 'package:malesin/data/models/assignment.dart';
import 'package:malesin/main.dart';
import 'package:malesin/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();
class BackgroundService {
  static BackgroundService? _service;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._createObject();

  factory BackgroundService() {
    if (_service == null) {
      _service = BackgroundService._createObject();
    }
    return _service!;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    print('Alarm Fired !');
    final NotificationHelper _notificationHelper = NotificationHelper();
    final DatabaseHelper _databaseHelper = DatabaseHelper();
        List<Assignment> res =
        await AssignmentRepository(databaseHelper: _databaseHelper)
            .getAssignment();
    res.forEach(
      (element) {
        DateTime now = DateTime.now();
        DateTime tmpDate = DateFormat("dd-MM-yyyy").parse(element.dl);
        if (now.month == tmpDate.month) {
          int margin = tmpDate.day - now.day;
          if (margin <= 3 && margin > 0) {
              _notificationHelper.showNotification(
                  flutterLocalNotificationsPlugin, element, margin);
          }
        }
      },
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print("execute some process");
  }
}