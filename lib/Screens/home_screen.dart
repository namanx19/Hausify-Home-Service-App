import 'package:flutter/material.dart';
import 'package:urbanserv/utils/constants.dart';
import 'package:urbanserv/Screens/start.dart';
import 'package:urbanserv/utils/service.dart';

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

  List<Service> services = [
    // List of services...
    Service('Cleaning',
        'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Plumber',
        'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-plumber-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Electrician',
        'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-multimeter-car-service-wanicon-flat-wanicon.png'),
    Service('Painter',
        'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-painter-male-occupation-avatar-itim2101-flat-itim2101.png'),
    Service('Carpenter', 'https://img.icons8.com/fluency/2x/drill.png'),
    Service('Gardener',
        'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-gardener-male-occupation-avatar-itim2101-flat-itim2101.png'),
    Service('Tailor', 'https://img.icons8.com/fluency/2x/sewing-machine.png'),
    Service('Maid', 'https://img.icons8.com/color/2x/housekeeper-female.png'),
    Service('Driver',
        'https://img.icons8.com/external-sbts2018-lineal-color-sbts2018/2x/external-driver-women-profession-sbts2018-lineal-color-sbts2018.png'),
  ];

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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          if (_currentIndex == 0)
            Column(
              children: services
                  .map((service) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: serviceContainer(
                  service.imageURL,
                  service.name,
                  TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
                  .toList(),
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

  Widget serviceContainer(String image, String name, TextStyle textStyle) {
    return GestureDetector(
      onTap: () {
        // Handle service item tap
        print('Tapped on service: $name');
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.network(
                image,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 16.0),
              Text(
                name,
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}