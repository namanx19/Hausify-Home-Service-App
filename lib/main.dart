import 'package:flutter/material.dart';
import 'package:urbanserv/Screens/GettingStarted/login_screen.dart';
import 'package:urbanserv/Screens/GettingStarted/ob_screen.dart';
import 'package:urbanserv/Screens/GettingStarted/registration_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const urbanserv());
}

class urbanserv extends StatelessWidget {
  const urbanserv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: 'Login App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.black,
            fontFamily: 'Montserrat',
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => OnboardingScreen(),
          '/loginScreen': (context) => LoginScreen(),
          '/registrationScreen': (context) => RegistrationScreen(),
      },
      ),
    );
  }
}