import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../utils/constants.dart';
import 'package:ionicons/ionicons.dart';

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
  final int _totalCards = 3; // Total number of cards in the carousel
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

  // Widget buildTopBar() {
  //   return Container(
  //     color: const Color(0xFFEAF6F6),
  //     padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Row(
  //           children: [
  //             GestureDetector(
  //               onTap: () {},
  //               child: const Icon(Icons.location_on),
  //             ),
  //             const SizedBox(width: 8),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   _localArea ?? 'GIDA',
  //                   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                 ),
  //                 Text(
  //                   _cityName ?? '',
  //                   style: const TextStyle(
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.normal,
  //                     color: Colors.grey,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         GestureDetector(
  //           onTap: () {},
  //           child: const Icon(Icons.notifications),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget buildFragmentContent() {
    // This list is for adding service images inside the Gesture detectors
    List<String> serviceImageURLs = [
      'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png', // Image URL for the first service
      'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-plumber-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png', // Image URL for the second service
      'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-multimeter-car-service-wanicon-flat-wanicon.png', // Image URL for the third service
      'https://img.icons8.com/fluency/2x/drill.png', // Image URL for the fourth service
    ];

    List<String> serviceNames = [
      'Cleaning',
      'Plumbing',
      'Electrician',
      'Carpenter',
    ];

    return Expanded(
      child: Column(
        children: [
          if (_currentIndex == 0) ...[
            Column(
              children: [
                Container(
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
                ),
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
                          imagePath: 'assets/images/discount1.jpg',
                          // cardColor: const Color(0xffEAF6F6),
                        ),
                        buildCarouselItem(
                          imagePath: 'assets/images/facebook.png',
                          // cardColor: const Color(0xffEAF6F6),
                        ),
                        buildCarouselItem(
                          imagePath: 'assets/images/apple.png',
                          // cardColor: const Color(0xffEAF6F6),
                        ),
                        // ... Repeat for other images ...
                      ],
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 20 / 9,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _carouselIndex = index;
                          });
                        },
                        viewportFraction: 0.9, // Adjust the fraction as needed
                        initialPage: 0,
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
                            for (int i = 0; i < 4; i++) ...[
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    CircleService(
                                      imageURLs: [serviceImageURLs[i]],
                                      onTapCallback: () {
                                        // Provide different functionality based on the category index (i)
                                        switch (i) {
                                          case 0:
                                          // Handle tap for the first category
                                            print('Tapped category 1');
                                            break;
                                          case 1:
                                          // Handle tap for the second category
                                            print('Tapped category 2');
                                            break;
                                          case 2:
                                          // Handle tap for the third category
                                            print('Tapped category 3');
                                            break;
                                          case 3:
                                          // Handle tap for the fourth category
                                            print('Tapped category 4');
                                            break;
                                          default:
                                            break;
                                        }
                                      },
                                    ),
                                    Text(
                                      serviceNames[i],
                                      style: kContentFontStyle.copyWith(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
          if (_currentIndex == 1)
            Padding(
              padding: EdgeInsets.zero,
              child: Text(
                'Cart fragment'
              ),
            ),
          if (_currentIndex == 2)
            Column(
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
                Padding(
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
              ],
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
    // required Color cardColor,
  }) {
    return Card(
      color: const Color(0xffEEEEEE),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.asset(
          imagePath,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.contain, // Maintain aspect ratio and fit within the card
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
          // buildTopBar(),
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

class CircleService extends StatelessWidget {
  final List<String> imageURLs;
  final VoidCallback onTapCallback; // Callback function for onTap

  const CircleService({
    required this.imageURLs,
    required this.onTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: onTapCallback, // Call the provided callback function
        child: CircleAvatar(
          backgroundColor: Color(0xffEEEEEE),
          radius: 44.0,
          child: Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageURLs[0]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


