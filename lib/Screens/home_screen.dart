
import 'package:flutter/material.dart';
import 'package:urbanserv/utils/constants.dart';
import 'package:urbanserv/Screens/start.dart';
import 'package:urbanserv/utils/service.dart';
import 'package:carousel_slider/carousel_slider.dart';


class HomeScreen extends StatefulWidget {
  final String? localArea;
  final String? cityName;
  final String? newCity;

  HomeScreen({this.localArea, this.cityName, this.newCity});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  String? _localArea;
  String? _cityName;
  String? _newCity;

  List<String> _images = [
    'image1.jpg',
    'image2.jpg',
    'image3.jpg',
    // Add more image paths as needed
  ];

  @override
  void initState() {
    super.initState();
    _localArea = widget.localArea;
    _cityName = widget.cityName;
    _newCity = widget.newCity;
    print(_localArea);
    print(_cityName);
    print(_newCity);
    if(_localArea == '')
    {
      _localArea = 'GIDA';
    }
  }

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
                  Text(
                    _localArea ?? 'GIDA',
                    style: kHeadingFontStyle,
                  ),
                  Text(
                    _cityName ?? '',
                    style: kContentFontStyle.copyWith(
                      color: Colors.grey,
                    ),
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for a service',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),  // Adjust the vertical padding here
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          if (_currentIndex == 0)
            Column(
              children: [
                CarouselSlider(
                  items: _images.map((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Image.asset(
                            'assets/$image',
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16/9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _images.map((image) {
                    int index = _images.indexOf(image);
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index ? Colors.blue : Colors.grey,
                      ),
                    );
                  }).toList(),
                ),
              ],
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
    );
  }

  Widget buildNavBarIcon(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        onNavItemTapped(index);
        print(index);
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
          Expanded(
            child: SingleChildScrollView(
              child: buildFragmentContent(),
            ),
          ),
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

