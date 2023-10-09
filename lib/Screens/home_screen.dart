import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../utils/constants.dart';

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
  int _carouselIndex = 0;
  int _totalCards = 3; // Total number of cards in the carousel
  final CarouselController _carouselController = CarouselController();
  late String _imageURL; // Initialize imageURL

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
    if (_localArea == '') {
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
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _cityName ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
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
          if (_currentIndex == 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Hi User!',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'What services do you need?',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for a service',
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 8.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CarouselSlider(
                  items: [
                    buildCarouselItem(
                      imagePath: 'assets/images/google.png',
                      cardColor: const Color(0xffEAF6F6),
                    ),
                    buildCarouselItem(
                      imagePath: 'assets/images/facebook.png',
                      cardColor: const Color(0xffEAF6F6),
                    ),
                    buildCarouselItem(
                      imagePath: 'assets/images/apple.png',
                      cardColor: const Color(0xffEAF6F6),
                    ),
                    // ... Repeat for other images ...
                  ],

                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 22 / 9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _carouselIndex = index;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: _carouselIndex,
                    count: _totalCards,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: Colors.blue,
                      dotColor: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Services by category',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: TextButton(
                        onPressed: () {
                          // Handle 'See All' button tap
                        },
                        child: Text(
                          'See All',
                          style: kContentFontStyle.copyWith(
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        for (int i = 0; i < 4; i++) // Change the number of icons as needed
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: circleService(
                              imageURL: _imageURL,
                            ),
                          ),
                      ],
                    ),
                  ),
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
      },
      child: Icon(
        icon,
        size: 30.0,
        color: _currentIndex == index ? Colors.green : Colors.grey,
      ),
    );
  }

  Widget buildCarouselItem({
    required String imagePath,
    required Color cardColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: double.infinity, // Fixed height for the card
        width: double.infinity, // Fixed width for the card
        child: Card(
          color: cardColor, // Light grey background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Rounded edges
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 100.0, // Adjust the height as needed
                width: 100.0, // Adjust the width as needed
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sample image URL, replace this with your actual image URL
    _imageURL = 'https://example.com/image.png';

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

class circleService extends StatelessWidget {
  final String imageURL;

  const circleService({
    required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          // Handle the tap for each category
        },
        child: CircleAvatar(
          backgroundImage: NetworkImage(imageURL),
          radius: 36.0,
        ),
      ),
    );
  }
}
