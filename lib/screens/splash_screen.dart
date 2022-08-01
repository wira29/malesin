import 'dart:async';

import 'package:flutter/material.dart';
import 'package:malesin/commons/style.dart';
import 'package:malesin/screens/onboarding_screen.dart';
import 'package:malesin/utils/preferences_action.dart';
import 'package:malesin/utils/preferences_helper.dart';
import 'package:malesin/widgets/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splashScreen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _preferences = PreferencesHelper();

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() {
    bool isOnBoarding = _preferences.readPreferencesBool(ON_BOARDING);

    const duration = Duration(seconds: 3);
    return Timer(duration, () {
      if(isOnBoarding){
        Navigator.pushReplacementNamed(context, BottomNav.routeName);  
      }else {
        Navigator.pushReplacementNamed(context, OnBoardingScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "malesin.",
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              "atur tugasmu agar tidak terlewat",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
