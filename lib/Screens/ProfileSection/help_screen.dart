import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:urbanserv/utils/constants.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help Center',
          style: kHeadingFontStyle.copyWith(fontSize: 24.0),
        ),
        backgroundColor: const Color(0xFFEAF6F6),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Center(
               child: Padding(
                 padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
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
                color: Colors.black,
              ),
              title: Text('On time services'),
            ),
            const ListTile(
              leading: Icon(
                  Ionicons.hand_left,
                color: Colors.black,
              ),
              title: Text('Quality services & Affordable prices'),
            ),
            const ListTile(
              leading: Icon(
                  Ionicons.trophy,
                color: Colors.black,
              ),
              title: Text('KHDA Certified Professionals'),
            ),
            const ListTile(
              leading: Icon(
                  Ionicons.shield_checkmark,
                color: Colors.black,
              ),
              title: Text('Safe and Hygienic NBSP Services'),
            ),
            const SizedBox(height: 20.0),
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
                color: Colors.black,
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
            const SizedBox(height: 20.0),
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
                color: Colors.black,
              ),
              title: Text('Instagram'),
            ),
            const ListTile(
              leading: Icon(
                  Ionicons.logo_twitter,
                color: Colors.black,
              ),
              title: Text('Twitter'),
            ),
          ],
        ),
      ),
    );
  }
}
