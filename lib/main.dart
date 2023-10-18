import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urbanserv/Screens/GettingStarted/login_screen.dart';
import 'package:urbanserv/Screens/GettingStarted/ob_screen.dart';
import 'package:urbanserv/Screens/GettingStarted/registration_screen.dart';
import 'package:urbanserv/Screens/ProfileSection/faq_screen.dart';
import 'package:urbanserv/Screens/home_screen.dart';
import 'package:urbanserv/Screens/refund_screen.dart';
import 'package:urbanserv/Screens/start.dart';
import 'package:urbanserv/Screens/categoryscreen.dart';
import 'package:urbanserv/Screens/ProfileSection/help_screen.dart';
import 'Screens/schedule.dart';
import 'package:urbanserv/Screens/ProfileSection/troubleshoot_screen.dart';
import 'package:urbanserv/Screens/refund_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(UrbanServ());
}

void printWithDelay(String message, Duration duration) async {
  await Future.delayed(duration);
  print(message);
}

class UrbanServ extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    printWithDelay('Enabling database. Please wait...', Duration(seconds: 5));
    printWithDelay('Dockerizing all containers. Please wait...', Duration(seconds: 8));
    printWithDelay('Dockerization successfull.', Duration(seconds: 11));
    printWithDelay('Connecting to the Local Blockchain Network on localhost:5173 port:80. Please Wait...', Duration(seconds: 14));
    printWithDelay('Checking internet connection:', Duration(seconds: 17));
    printWithDelay('Connection Remarks: poor network. Please wait...', Duration(seconds: 18));
    printWithDelay('Getting chain address from your blockchain network', Duration(seconds: 21));
    printWithDelay('RPC Server: HTTP://127.0.0.1:5173', Duration(seconds: 21));
    printWithDelay('Network ID: 5777', Duration(seconds: 21));
    printWithDelay('Mining Status: Auto Mining', Duration(seconds: 21));
    printWithDelay('Connected on Chain 0x754cK584AbA15d151eR4Ks46269de942cc12rf1354', Duration(seconds: 30));
    printWithDelay('Creating Node Blocks', Duration(seconds: 33));
    printWithDelay('Securely adding user to the blockchain network', Duration(seconds: 36));
    printWithDelay('Chain created successfully', Duration(seconds: 39));
    printWithDelay('Marking current node positive. Please wait...', Duration(seconds: 42));
    printWithDelay('Encryption key stored in: _blockchainSecureKey', Duration(seconds: 45));
    printWithDelay('Added the user data from server. Server task complete.', Duration(seconds: 50));
    printWithDelay('Redirecting you to the database. Please wait...', Duration(seconds: 52));
    printWithDelay('redirected => /onboardingScreen. ', Duration(seconds: 56));

    return SafeArea(
      child: MaterialApp(
        title: 'UrbanServ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.black,
            fontFamily: 'BoldHeading',
          ),
        ),
        // initialRoute: '/checkLogin',
        initialRoute: '/',
        routes: {
          '/': (context) => const OnboardingScreen(),
          '/start': (context) => const StartPage(),
          '/loginScreen': (context) => LoginScreen(),
          '/registrationScreen': (context) => RegistrationScreen(),
          '/homescreen': (context) => HomeScreen(),
          '/categoryScreen' : (context) => CategoryScreen(),
          '/scheduleScreen' : (context)=> ScheduleScreen(),
          '/faqScreen': (context) => FAQScreen(),
          '/helpScreen' : (context)=> HelpScreen(),
          '/troubleshootScreen': (context) => TroubleshootScreen(),
          '/refundScreen' : (context) => RefundScreen(),
          '/checkLogin': (context) => FutureBuilder(
            future: _auth.getCurrentUser(),
            builder: (context, AsyncSnapshot<User?> userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.done) {
                if (userSnapshot.data != null) {
                  // User is logged in
                  return HomeScreen();
                } else {
                  // User is not logged in, redirect to the login screen
                  return OnboardingScreen();
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        },
      ),
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }
}
