import 'package:flutter/material.dart';
import 'package:urbanserv/Screens/GettingStarted/login_screen.dart';
import 'package:urbanserv/Screens/GettingStarted/ob_screen.dart';
import 'package:urbanserv/Screens/GettingStarted/registration_screen.dart';
import 'package:urbanserv/Screens/categoryscreen.dart';
import 'package:urbanserv/Screens/home_screen.dart';
import 'package:urbanserv/Screens/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:urbanserv/Screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(urbanserv());
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
            fontFamily: 'BoldHeading',
          ),
        ),
        initialRoute: '/categoryScreen',
        routes: {
          '/': (context) => const OnboardingScreen(),
          '/start' : (context) => const StartPage(),
          '/loginScreen': (context) => LoginScreen(),
          '/registrationScreen': (context) => RegistrationScreen(),
          '/homescreen': (context) => HomeScreen(),
          '/profile': (context) => ProfileScreen(),
          '/categoryScreen': (context) => CategoryScreen(),
      },
      ),
    );
  }
}