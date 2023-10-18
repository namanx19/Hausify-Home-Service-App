import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:urbanserv/utils/constants.dart';
import 'package:urbanserv/Screens/home_screen.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const fragmentTopBar(
            topBarText: 'Help Center',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                     child: Padding(
                       padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                       child: Image.asset(
                           'assets/images/helpscreenicon.png',
                       ),
                     ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'We help in your all needs',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const ListTile(
                      leading: Icon(
                        Ionicons.timer,
                      color: Color(0xffC70039),
                    ),
                    title: Text('On time services'),
                  ),
                  const ListTile(
                    leading: Icon(
                        Ionicons.hand_left,
                      color: Color(0xffEAD7BB),
                    ),
                    title: Text('Quality services & Affordable prices'),
                  ),
                  const ListTile(
                    leading: Icon(
                        Ionicons.trophy,
                      color: Color(0xffFFCC70),
                    ),
                    title: Text('KHDA Certified Professionals'),
                  ),
                  const ListTile(
                    leading: Icon(
                        Ionicons.shield_checkmark,
                      color: Color(0xff088395),
                    ),
                    title: Text('Safe and Hygienic Services'),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 5.0,
                    color: kSeperatorColor,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Contact Us',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                        Ionicons.call,
                      color: Colors.green,
                    ),
                    title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('+91 70074 60524'),
                      SizedBox(height: 18.0,),
                      Text('+91 94552 41118'),
                    ],
                  ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 5.0,
                    color: kSeperatorColor,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Social Media',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                        Ionicons.logo_instagram,
                      color: Colors.pink,
                    ),
                    title: Text('Instagram'),
                  ),
                  const ListTile(
                    leading: Icon(
                        Ionicons.logo_twitter,
                      color: Colors.blue,
                    ),
                    title: Text('Twitter'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 5.0,
                    color: kSeperatorColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
