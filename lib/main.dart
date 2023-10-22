import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urbanserv/Screens/GettingStarted/login_screen.dart';
import 'package:urbanserv/Screens/GettingStarted/ob_screen.dart';
import 'package:urbanserv/Screens/GettingStarted/registration_screen.dart';
import 'package:urbanserv/Screens/ProfileSection/faq_screen.dart';
import 'package:urbanserv/Screens/ProfileSection/myaccount_screen.dart';
import 'package:urbanserv/Screens/booking_screen.dart';
import 'package:urbanserv/Screens/home_screen.dart';
import 'package:urbanserv/Screens/notification_screen.dart';
import 'package:urbanserv/Screens/refund_screen.dart';
import 'package:urbanserv/Screens/start.dart';
import 'package:urbanserv/Screens/categoryscreen.dart';
import 'package:urbanserv/Screens/ProfileSection/help_screen.dart';
import 'Screens/schedule.dart';
import 'package:urbanserv/Screens/ProfileSection/troubleshoot_screen.dart';
import 'package:urbanserv/Screens/ProfileSection/subscription_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(UrbanServ());
}

class UrbanServ extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

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
          '/notificationScreen': (context) => NotificationScreen(),
          '/categoryScreen' : (context) => CategoryScreen(),
          '/scheduleScreen' : (context)=> const ScheduleScreen(),
          '/bookingScreen': (context)=> BookingScreen(),
          '/myaccountScreen': (context)=> MyAccountScreen(),
          '/faqScreen': (context) => FAQScreen(),
          '/helpScreen' : (context)=> const HelpScreen(),
          '/troubleshootScreen': (context) => const TroubleshootScreen(),
          '/subscriptionScreen': (context) => SubscriptionScreen(),
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
