import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:malesin/utils/notification_helper.dart';
import 'package:malesin/widgets/bottom_nav.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
// final NotificationHelper _notificationHelper = NotificationHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await _notificationHelper.initNotification(flutterLocalNotificationsPlugin);

  await initializeService();

  runApp(const MyApp());
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

// run app from xcode, then from xcode menu, select Simulate Background Fetch
bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');

  return true;
}

void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  WidgetsFlutterBinding.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  // SharedPreferences preferences = await SharedPreferences.getInstance();
  // await preferences.setString("hello", "world");

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // set notif
  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(
      title: "Malesin",
      content: "atur tugasmu agar tidak terlewat",
    );
  }

  // bring to foreground
  DatabaseHelper _databaseHelper = DatabaseHelper();
  Timer.periodic(const Duration(seconds: 10), (timer) async {
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
            // if (service is AndroidServiceInstance) {
            //   _notificationHelper.showNotification(
            //       flutterLocalNotificationsPlugin, element, margin);
            // }
            // if (service is AndroidServiceInstance) {
            //   service.setForegroundNotificationInfo(
            //     title: "${element.mapel} - ${element.title}",
            //     content:
            //         "Batas pengumpulan tugas ${element.title} tinggal ${margin} hari lagi !!",
            //   );
            // }
          }
        }
      },
    );

    /// you can see this log in logcat
    // print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    FlutterBackgroundService().invoke("setAsBackground");
    // _notificationHelper
    //     .configureSelectNotificationSubject(DetailAssignmentScreen.routeName);
  }

  @override
  void dispose() {
    // selectNotificationSubject.close();
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
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
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
