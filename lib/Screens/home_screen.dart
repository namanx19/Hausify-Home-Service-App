// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../utils/constants.dart';
import 'package:ionicons/ionicons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  final String? localArea;
  final String? cityName;
  final String? newCity;
  final String? country;
  final String? pincode;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  HomeScreen({super.key, this.localArea, this.cityName, this.newCity, this.country, this.pincode});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _currentIndex = 0;
  int _carouselIndex = 0;
  final int _totalCards = 8; // Total number of cards in the carousel
  final CarouselController _carouselController = CarouselController();
  late String _imageURL; // Initialize imageURL

  String? _localArea;
  String? _cityName;
  String? _newCity;
  String? _country;
  String? _pincode;

  @override
  void initState() {
    super.initState();
    _localArea = widget.localArea ?? 'GIDA';
    _cityName = widget.cityName ?? 'Jhungia';
    _newCity = widget.newCity ?? 'Uttar Pradesh';
    _country = widget.country ?? 'India';
    _pincode = widget.pincode ?? '273209';

    _searchbarFocusNode = FocusNode(); // for changing the border color of search bar
  }

  late FocusNode _searchbarFocusNode; // for changing the border color of search bar
  
  @override // for changing the border color of search bar
  void dispose() {
    _searchbarFocusNode.dispose();
    super.dispose();
  }

  void onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget buildFragmentContent() {
    // This list is for adding service images inside the Gesture detectors
    List<String> serviceImageURLs = [
      'https://cdn-icons-png.flaticon.com/512/5612/5612846.png',
      'https://cdn-icons-png.flaticon.com/512/2025/2025470.png',
      'https://cdn-icons-png.flaticon.com/512/3343/3343641.png', // Image URL for the first service
      'https://cdn-icons-png.flaticon.com/512/681/681531.png',
      'https://cdn-icons-png.flaticon.com/512/4635/4635163.png', // Image URL for the second service
      'https://cdn-icons-png.flaticon.com/512/6008/6008918.png', // Image URL for the third service
      'https://cdn-icons-png.flaticon.com/512/3531/3531568.png', // Image URL for the fourth service

    ];

    List<String> serviceNames = [
      'Pest Control',
      'Salon/SPA',
      'Cleaning',
      'Painting',
      'Plumbing',
      'Electrician',
      'Carpenter',
    ];

    return Expanded(
      child: GestureDetector(
        onTap: (){
          _searchbarFocusNode.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_currentIndex == 0) ...[
                Column(
                  children: [
                    Container(
                      color: Colors.white, //TopBar Color
                      padding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 6.0),
                      // padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(Icons.location_on, color: kPrimaryColor,),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _localArea ?? 'Gida',
                                    style: kHeadingFontStyle.copyWith(
                                      fontSize: 14,
                                      color: kPrimaryColor
                                    )
                                  ),
                                  Text(
                                    '$_cityName, $_newCity, $_country, $_pincode',
                                      style: kContentFontStyle.copyWith(
                                          fontSize: 12,
                                          color: Colors.black
                                      ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.notifications, color: kPrimaryColor,),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Hi Naman!',
                            style: kHeadingFontStyle.copyWith(
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'What services do you need?',
                            style: kContentFontStyle.copyWith(
                              fontSize: 18.0,
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            focusNode: _searchbarFocusNode,
                            decoration: InputDecoration(
                              hintText: 'Search for a service',
                              prefixIcon: const Icon(Icons.search, color: kPrimaryColor,),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 8.0,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: kPrimaryColor),  // Color of the border when not focused
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: kPrimaryColor),  // Color of the border when focused
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
                              imagePath: 'assets/images/discount2.jpg',
                              // cardColor: const Color(0xffEAF6F6),
                            ),
                            buildCarouselItem(
                              imagePath: 'assets/images/discount3.jpg',
                              // cardColor: const Color(0xffEAF6F6),
                            ),
                            buildCarouselItem(
                              imagePath: 'assets/images/discount4.jpg',
                              // cardColor: const Color(0xffEAF6F6),
                            ),
                            buildCarouselItem(
                              imagePath: 'assets/images/discount5.jpg',
                              // cardColor: const Color(0xffEAF6F6),
                            ),
                            buildCarouselItem(
                              imagePath: 'assets/images/discount6.jpg',
                              // cardColor: const Color(0xffEAF6F6),
                            ),
                            buildCarouselItem(
                              imagePath: 'assets/images/discount7.jpg',
                              // cardColor: const Color(0xffEAF6F6),
                            ),
                            buildCarouselItem(
                              imagePath: 'assets/images/discount8.jpg',
                              // cardColor: const Color(0xffEAF6F6),
                            ),
                            // ... Repeat for other images ...
                          ],
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _carouselIndex = index;
                              });
                            },
                            viewportFraction: 0.96, // Adjust the fraction as needed
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
                            effect: const WormEffect(
                              type: WormType.thin,
                              dotHeight: 10,
                              dotWidth: 10,
                              activeDotColor: kPrimaryColor,
                              dotColor: kContrastColor,
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
                                  Navigator.pushNamed(context, '/categoryScreen');
                                },
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.pressed)) {
                                        return kContrastColor;  // Color when pressed
                                      }
                                      return Colors.transparent;  // Default color
                                    },
                                  ),
                                ),
                                child: Text(
                                  'See All',
                                  style: kContentFontStyle.copyWith(
                                    color: kPrimaryColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                              )
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                for (int i = 0; i < 7; i++) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        SquareCardService(
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
                                              case 4:
                                              // Handle tap for the third category
                                                print('Tapped category 5');
                                                break;
                                                case 5:
                                              // Handle tap for the third category
                                                print('Tapped category 6');
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
                const Padding(
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
                                      Navigator.pushNamed(context, '/helpScreen');
                                    },
                                  ),
                                  const SizedBox(height: 10.0,),
                                  buildCard(
                                    icon: Ionicons.log_out,
                                    title: 'Logout',
                                    onPressed: () async {
                                      try {
                                        await _auth.signOut();
                                        // After signing out, you may want to navigate to a login or home screen.
                                        // For example, you can use Navigator to go back to your login screen.
                                        Navigator.pushNamed(context, '/loginScreen');
                                      } catch (e) {
                                        print('Error during sign out: $e');
                                      }
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
        ),
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
          color: kPrimaryColor,
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
        color: _currentIndex == index ? kPrimaryColor : Colors.grey,
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
          fit: BoxFit.cover, // Maintain aspect ratio and fit within the card
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
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildNavBarIcon(Icons.home, 0),
                  buildNavBarIcon(Icons.shopping_cart, 1),
                  buildNavBarIcon(Icons.person, 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SquareCardService extends StatelessWidget {
  final List<String> imageURLs;
  final VoidCallback onTapCallback; // Callback function for onTap

  const SquareCardService({super.key,
    required this.imageURLs,
    required this.onTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: GestureDetector(
        onTap: onTapCallback, // Call the provided callback function
        child: Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(10.0),  // Adjust the radius as needed
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),  // Adjust the radius to match the container
                image: DecorationImage(
                  fit: BoxFit.cover,  // Set to BoxFit.none to maintain original image size
                  image: NetworkImage(imageURLs[0]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
