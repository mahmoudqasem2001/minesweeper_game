import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:minisweeper_game/home_page.dart';

class IntroductionScrren extends StatefulWidget {
  const IntroductionScrren({super.key});

  @override
  State<IntroductionScrren> createState() => _IntroductionScrrenState();
}

class _IntroductionScrrenState extends State<IntroductionScrren> {
  final Shader gradText = const LinearGradient(
    colors: <Color>[Colors.black, Colors.grey],
  ).createShader(const Rect.fromLTWH(50, 0.0, 200.0, 100.0));

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: const Image(
        image: ExactAssetImage('assets/images/logo.png'),
      ),
      title: Text(
        "Welcome To Minesweeper",
        style: TextStyle(
          fontSize: 25,
          fontFamily: "Poppins",
          foreground: Paint()..shader = gradText,
          fontWeight: FontWeight.w600,
          height: 4,
          letterSpacing: 0.9,
        ),
      ),
      gradientBackground: const LinearGradient(
        colors: [Colors.blueGrey, Colors.white],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      showLoader: true,
      loaderColor: Colors.white,
      loadingText: const Text(
        "Loading...",
        style: TextStyle(color: Colors.white),
      ),
      navigator: const HomePage(),
      durationInSeconds: 5,
    );
  }
}
