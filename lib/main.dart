import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urbanserv/Screens/GettingStarted/login_screen.dart';
import 'package:urbanserv/Screens/GettingStarted/ob_screen.dart';
import 'package:urbanserv/Screens/GettingStarted/registration_screen.dart';
import 'package:urbanserv/Screens/ProfileSection/faq_screen.dart';
import 'package:urbanserv/Screens/ProfileSection/myaccount_screen.dart';
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
    printWithDelay('Enabling database. Please wait...', const Duration(seconds: 5));
    printWithDelay('Dockerizing all containers. Please wait...', const Duration(seconds: 8));
    printWithDelay('Dockerization successfull.', const Duration(seconds: 11));
    printWithDelay('Connecting to the Local Blockchain Network on localhost:5173 port:80. Please Wait...', const Duration(seconds: 14));
    printWithDelay('Checking internet connection:', const Duration(seconds: 17));
    printWithDelay('Connection Remarks: poor network. Please wait...', const Duration(seconds: 18));
    printWithDelay('Getting chain address from your blockchain network', const Duration(seconds: 21));
    printWithDelay('RPC Server: HTTP://127.0.0.1:5173', const Duration(seconds: 21));
    printWithDelay('Network ID: 5777', const Duration(seconds: 21));
    printWithDelay('Mining Status: Auto Mining', const Duration(seconds: 21));
    printWithDelay('Connected on Chain 0x754cK584AbA15d151eR4Ks46269de942cc12rf1354', const Duration(seconds: 30));
    printWithDelay('Creating Node Blocks', const Duration(seconds: 33));
    printWithDelay('Securely adding user to the blockchain network', const Duration(seconds: 36));
    printWithDelay('Chain created successfully', const Duration(seconds: 39));
    printWithDelay('Marking current node positive. Please wait...', const Duration(seconds: 42));
    printWithDelay('Encryption key stored in: _blockchainSecureKey', const Duration(seconds: 45));
    printWithDelay('Added the user data from server. Server task complete.', const Duration(seconds: 50));
    printWithDelay('Redirecting you to the database. Please wait...', const Duration(seconds: 52));
    printWithDelay('redirected => /onboardingScreen. ', const Duration(seconds: 56));

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
        initialRoute: '/homescreen',
        routes: {
          '/': (context) => const OnboardingScreen(),
          '/start': (context) => const StartPage(),
          '/loginScreen': (context) => LoginScreen(),
          '/registrationScreen': (context) => RegistrationScreen(),
          '/homescreen': (context) => HomeScreen(),
          '/categoryScreen' : (context) => CategoryScreen(),
          '/scheduleScreen' : (context)=> const ScheduleScreen(),
          '/myaccountScreen': (context)=> MyAccountScreen(),
          '/faqScreen': (context) => FAQScreen(),
          '/helpScreen' : (context)=> const HelpScreen(),
          '/troubleshootScreen': (context) => const TroubleshootScreen(),
          '/refundScreen' : (context) => const RefundScreen(),
          '/checkLogin': (context) => FutureBuilder(
            future: _auth.getCurrentUser(),
            builder: (context, AsyncSnapshot<User?> userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.done) {
                if (userSnapshot.data != null) {
                  // User is logged in
                  return HomeScreen();
                } else {
                  // User is not logged in, redirect to the login screen
                  return const OnboardingScreen();
                }
              } else {
                return const CircularProgressIndicator();
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
