import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Initialize variables for selected tab and location.
  int _selectedIndex = 0;
  String _location = "Your Location";

  // Define a list of fragment widgets.
  final List<Widget> _fragments = [
    // Replace one of these with the given code.
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(25.0),
          color: Colors.transparent,
          child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(9, (index) {
              return Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  //color: boxColors[index],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    //color: index == selectedIndex ? Colors.blue : Colors.transparent,
                    width: 2.0,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    ),
    const Placeholder(),

    const Placeholder(),

    const Placeholder(),
    const Placeholder(),
  ];

  // Function to update the selected tab.
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            //color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.location_on,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    // Implement location fetching here.
                    setState(() {
                      _location = "New Location"; // Update location here.
                    });
                  },
                ),
                Text(
                  "Location: $_location",
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                IconButton(
                    onPressed: (){

                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,

                    ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _fragments[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
        ],
      ),
    );
  }
}
