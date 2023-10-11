import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: const Color(0xFFEAF6F6),
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
            child: const Center(
              child: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const CircleAvatar(
                        radius: 65.0,
                        backgroundImage: AssetImage('assets/profile_image.jpg'),
                        backgroundColor: Color(0xffEEEEEE),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'User',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 60.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildCard(
                            icon: Ionicons.person,
                            title: 'My Account',
                            onPressed: () {
                              // Handle My Account card pressed
                              print('My Account card pressed');
                            },
                          ),
                          const SizedBox(height: 10.0,),
                          buildCard(
                            icon: Ionicons.notifications,
                            title: 'Notifications',
                            onPressed: () {
                              // Handle Notifications card pressed
                              print('Notifications card pressed');
                            },
                          ),
                          const SizedBox(height: 10.0,),
                          buildCard(
                            icon: Ionicons.settings,
                            title: 'Settings',
                            onPressed: () {
                              // Handle Settings card pressed
                              print('Settings card pressed');
                            },
                          ),
                          const SizedBox(height: 10.0,),
                          buildCard(
                            icon: Ionicons.help_circle,
                            title: 'Help Center',
                            onPressed: () {
                              // Handle Help Center card pressed
                              print('Help Center card pressed');
                            },
                          ),
                          const SizedBox(height: 10.0,),
                          buildCard(
                            icon: Ionicons.log_out,
                            title: 'Logout',
                            onPressed: () {
                              // Handle Logout card pressed
                              print('Logout card pressed');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard({required IconData icon, required String title, VoidCallback? onPressed}) {
    return Card(
      elevation: 0,
      color: const Color(0xFFF8F6F4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green,
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        trailing: const Icon(
          Icons.arrow_forward,
          color: Colors.black,
          size: 30.0,
        ),
        onTap: onPressed,
      ),
    );
  }
}
