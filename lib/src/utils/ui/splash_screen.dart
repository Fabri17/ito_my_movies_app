import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_movies_app/main.dart';
import 'package:my_movies_app/src/constants/assets.dart';
import 'package:my_movies_app/src/constants/colors.dart';
import 'package:my_movies_app/src/pages/home_page/home_page.dart';
import 'package:my_movies_app/src/pages/login_page/login_page.dart';

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
      Future.delayed(const Duration(seconds: 3)).then((_) {
        var token = sharedPreferences.getString('auth-token');

        if (token == null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
            (route) => false,
          );
        }
      });
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
