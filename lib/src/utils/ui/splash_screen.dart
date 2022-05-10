import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_movies_app/src/constants/assets.dart';
import 'package:my_movies_app/src/constants/colors.dart';
import 'package:my_movies_app/src/pages/home_page/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      Future.delayed(const Duration(seconds: 3)).then(
        (value) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colors.kBlackColor,
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 40),
          width: 150,
          height: 150,
          child: Lottie.asset(
            Assets.kSplash,
          ),
        ),
      ),
    );
  }
}
