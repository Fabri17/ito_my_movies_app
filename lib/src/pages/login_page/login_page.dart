import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_movies_app/main.dart';
import 'package:my_movies_app/src/constants/colors.dart';
import 'package:my_movies_app/src/pages/home_page/home_page.dart';
import 'package:my_movies_app/src/utils/services/auth_service.dart';
import 'package:my_movies_app/src/utils/tools/validators.dart';
import 'package:my_movies_app/src/widgets/inputs/general_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  //User info
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: colors.kBlackColor,
      extendBody: true,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.kGreenColor.withOpacity(0.5),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 200,
                  sigmaY: 200,
                ),
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.4,
            right: -88,
            child: Container(
              height: 166,
              width: 166,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.kPinkColor.withOpacity(0.5),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 200,
                  sigmaY: 200,
                ),
                child: Container(
                  height: 166,
                  width: 166,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.kCyanColor.withOpacity(0.5),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 200,
                  sigmaY: 200,
                ),
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'Welcome!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      color: colors.kWhiteColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  GeneralInputWidget(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Email",
                    validator: (val) {
                      var _result = validators.validateText(val);
                      if (_result != null) return _result;
                      return validators.validateEmail(val);
                    },
                    onChange: (value) {
                      email = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  GeneralInputWidget(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Password",
                    isPassword: true,
                    validator: (val) {
                      return validators.validateText(val);
                    },
                    onChange: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () => _performLogin(),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        primary: colors.kGreenColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              color: colors.kBlackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (_isLoading)
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: colors.kBlackColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _performLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      var token = await authService.authUser(email, password);

      if (token.isNotEmpty) {
        sharedPreferences.setString('auth-token', token);

        // Go home
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect credentials, try again.'),
          ),
        );
      }

      setState(() {
        _isLoading = false;
      });
    } else {}
  }
}
