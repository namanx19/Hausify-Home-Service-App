import 'package:flutter/material.dart';
import 'package:urbanserv/utils/constants.dart';
//import 'package:urbanserv/Screens/start.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget buildTopBar() {
    return Container(
      color: const Color(0xFFEAF6F6),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: const Icon(Icons.location_on),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mohaddipur',
                    style: kHeadingFontStyle,
                    //style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Gorakhpur',
                    style: kContentFontStyle.copyWith(
                      color: Colors.grey,
                    ),
                    //style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.notifications),
          ),
        ],
      ),
    );
  }

  Widget buildFragmentContent() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (_currentIndex == 0)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Home Fragment Content'),
              ),
            if (_currentIndex == 1)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Cart Fragment Content'),
              ),
            if (_currentIndex == 2)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('User Profile Fragment Content'),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildNavBarIcon(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        onNavItemTapped(index);
      },
      child: Icon(
        icon,
        size: 30.0,
        color: _currentIndex == index ? Colors.green : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildTopBar(),
          buildFragmentContent(),
          Container(
            color: const Color(0xFFEAF6F6),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildNavBarIcon(Icons.home, 0),
                buildNavBarIcon(Icons.shopping_cart, 1),
                buildNavBarIcon(Icons.person, 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}