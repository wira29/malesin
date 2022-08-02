import 'dart:async';
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:malesin/commons/navigation.dart';
import 'package:malesin/commons/textTheme.dart';
import 'package:malesin/data/bloc/assignment/assignment_bloc.dart';
import 'package:malesin/data/bloc/assignment/assignment_repository.dart';
import 'package:malesin/data/bloc/schedule/schedule_bloc.dart';
import 'package:malesin/data/db/database_helper.dart';
import 'package:malesin/data/models/assignment.dart';
import 'package:malesin/screens/detail_assignment_screen.dart';
import 'package:malesin/screens/onboarding_screen.dart';
import 'package:malesin/screens/splash_screen.dart';
import 'package:malesin/utils/background_service.dart';
import 'package:malesin/utils/notification_helper.dart';
import 'package:malesin/utils/preferences_helper.dart';
import 'package:malesin/widgets/bottom_nav.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final NotificationHelper _notificationHelper = NotificationHelper();
final PreferencesHelper _preferences = PreferencesHelper();
final BackgroundService _service = BackgroundService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _notificationHelper.initNotification(flutterLocalNotificationsPlugin);

  await _preferences.init();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await AndroidAlarmManager.periodic(
    Duration(hours: 3),
    1,
    BackgroundService.callback,
    exact: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    FlutterBackgroundService().invoke("setAsBackground");
    _notificationHelper
        .configureSelectNotificationSubject(DetailAssignmentScreen.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AssignmentBloc>(
            create: (BuildContext context) => AssignmentBloc()),
        BlocProvider<ScheduleBloc>(
          create: (BuildContext context) => ScheduleBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: myTextTheme,
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
          BottomNav.routeName: (context) => BottomNav(),
          DetailAssignmentScreen.routeName: (context) => DetailAssignmentScreen(
              data: ModalRoute.of(context)!.settings.arguments as Assignment),
        },
        navigatorKey: navigatorKey,
      ),
    );
  }
}
