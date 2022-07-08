import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:malesin/commons/style.dart';
import 'package:malesin/screens/home_screen.dart';
import 'package:malesin/screens/schedule_screen.dart';
import 'package:malesin/screens/setting_screen.dart';

class BottomNav extends StatefulWidget {
  static String routeName = "/bottomNavigation";

  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  List<Widget> screen = [
    HomeScreen(),
    ScheduleScreen(),
    SettingScreen(),
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: BottomNavyBar(
          onItemSelected: onTap,
          showElevation: false,
          backgroundColor: Colors.transparent,
          selectedIndex: currentIndex,
          items: [
            BottomNavyBarItem(
              icon: Icon(
                Icons.home,
                color: const Color(0xFFA6D5FF),
              ),
              activeColor: primaryColor,
              title: Text("Beranda"),
            ),
            BottomNavyBarItem(
              icon: Icon(
                Icons.schedule_outlined,
                color: const Color(0xFFA6D5FF),
              ),
              activeColor: primaryColor,
              title: Text("Jadwal"),
            ),
            BottomNavyBarItem(
              icon: Icon(
                Icons.settings,
                color: const Color(0xFFA6D5FF),
              ),
              activeColor: primaryColor,
              title: Text("Pengaturan"),
            )
          ],
        ),
      ),
    );
  }
}
