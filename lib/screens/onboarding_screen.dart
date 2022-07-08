import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:malesin/commons/style.dart';

class OnBoardingScreen extends StatefulWidget {
  static String routeName = "/onBoardingScreen";

  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  static List<PageViewModel> pageView = [
    PageViewModel(
      reverse: true,
      title: "Tugas",
      image: const Align(
        alignment: Alignment.centerRight,
        child: Image(
          image: AssetImage('assets/onboarding/sitting-reading.png'),
        ),
      ),
      body:
          "kami akan membantu mengelola tugas anda, sehingga tidak akan terlewat.",
      decoration: PageDecoration(
        titleTextStyle: GoogleFonts.smooch(
          fontSize: 48,
          color: textPrimary,
        ),
        bodyTextStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: textSecondary,
        ),
      ),
    ),
    PageViewModel(
      reverse: true,
      title: "Jadwal",
      image: const Align(
        alignment: Alignment.centerLeft,
        child: Image(
          image: AssetImage('assets/onboarding/unboxing.png'),
        ),
      ),
      body:
          "kami akan membantu mengelola jadwal anda, sehingga anda mudah melihat jadwal.",
      decoration: PageDecoration(
        titleTextStyle: GoogleFonts.smooch(
          fontSize: 48,
          color: textPrimary,
        ),
        bodyTextStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: textSecondary,
        ),
      ),
    ),
    PageViewModel(
      reverse: true,
      title: "Mulai",
      image: const Align(
        alignment: Alignment.center,
        child: Image(
          image: AssetImage('assets/onboarding/swinging.png'),
        ),
      ),
      body: "mulai sekarang untuk menikmati fitur-fitur yang kami tawarkan.",
      decoration: PageDecoration(
        titleTextStyle: GoogleFonts.smooch(
          fontSize: 48,
          color: textPrimary,
        ),
        bodyTextStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: textSecondary,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 80),
          child: IntroductionScreen(
            pages: pageView,
            onDone: () {
              Navigator.pushReplacementNamed(context, '/bottomNavigation');
            },
            showBackButton: false,
            showSkipButton: true,
            next: const Icon(Icons.arrow_forward_ios_rounded),
            skip: const Text(
              "Lewati",
              style: TextStyle(color: textSecondary),
            ),
            done: const Text("Mulai",
                style: TextStyle(fontWeight: FontWeight.w600)),
            dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(20.0, 10.0),
                activeColor: primaryColor,
                color: Colors.black26,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0))),
          ),
        ),
      ),
    );
  }
}
