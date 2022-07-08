// import 'dart:convert';
// import 'dart:math';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:malesin/commons/navigation.dart';
// import 'package:malesin/data/models/assignment.dart';
// import 'package:rxdart/subjects.dart';

// final selectNotificationSubject = BehaviorSubject<String>();

// class NotificationHelper {
//   static NotificationHelper? _instance;

//   NotificationHelper._internal() {
//     _instance = this;
//   }

//   factory NotificationHelper() => _instance ?? NotificationHelper._internal();

//   Future<void> initNotification(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin) async {
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');

//     var initializationSettingsIOS = IOSInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//     );

//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

//     await flutterLocalNotificationPlugin.initialize(initializationSettings,
//         onSelectNotification: (String? payload) async {
//       selectNotificationSubject.add(payload ?? 'empty payload');
//     });
//   }

//   Future<void> showNotification(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
//       Assignment assignment,
//       int margin) async {
//     var _channelId = "1";
//     var _channelName = "channel_01";
//     var _channelDescription = "dicoding news restaurant";

//     var androidPlatformCahannelSpecifics = AndroidNotificationDetails(
//         _channelId, _channelName,
//         channelDescription: _channelDescription,
//         icon: "ic_launcher.png",
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker',
//         styleInformation: DefaultStyleInformation(true, true));

//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformCahannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);

//     // Random random = new Random();
//     // int index = random.nextInt(restaurantResult.restaurants.length);
//     var titleNotification = "<b>${assignment.title}</b>";
//     var bodyNotification =
//         "Batas pengumpulan tugas ${assignment.mapel} - ${assignment.title} tinggal ${margin} hari lagi !!";

//     await flutterLocalNotificationsPlugin.show(
//         0, titleNotification, bodyNotification, platformChannelSpecifics,
//         payload: json.encode(assignment.toJson()));
//   }

//   void configureSelectNotificationSubject(String route) {
//     selectNotificationSubject.stream.listen((String payload) async {
//       var assignment = Assignment.fromJson(json.decode(payload));
//       Navigation.intentWithData(route, assignment);
//     });
//   }
// }
