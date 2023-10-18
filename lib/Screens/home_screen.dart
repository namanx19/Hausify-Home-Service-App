// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../utils/constants.dart';
import 'package:ionicons/ionicons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:urbanserv/utils/service.dart';

class HomeScreen extends StatefulWidget {
  final String? localArea;
  final String? fulladdress;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  HomeScreen({super.key, this.localArea, this.fulladdress});

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
  late String username;
  late String? _fullname;
  late String? _profileImageURL;
  late String _localArea;
  late String _fulladdress;
  bool _isFetchingLocation = false; // New boolean to track fetching location


  @override
  void initState() {
    super.initState();
    _localArea = widget.localArea ?? 'GIDA';
    _fulladdress = widget.fulladdress ?? 'Tap to fetch';
    _searchbarFocusNode = FocusNode(); // for changing the border color of search bar
    final user = _auth.currentUser;
    if (user != null && user.photoURL != null) {
      _profileImageURL = user.photoURL;
    } else {
      // Set a default image URL or use a fallback image from an asset
      _profileImageURL = 'https://cdn-icons-png.flaticon.com/128/1077/1077012.png'; // Replace with a default image URL
    }
    if (user != null) {
      // Check if the user has a display name
      if (user.displayName != null) {
        // Split the display name by space and take the first part as the username
        final parts = user.displayName?.split(' ');
        username = parts![0];
        _fullname = user.displayName;
      }
      else {
        // If there's no display name, you can use the email as a username or customize it as needed
        username = 'Naman';
        _fullname = 'Naman Gupta';
      }
    }
    else
    {
      username = 'Naman';
      _fullname = 'Naman Gupta';
    }
  }
  // void initState() {
  //   super.initState();
  //   _localArea = widget.localArea ?? 'Get Current Location!';
  //   _fulladdress = widget.fulladdress ?? 'Tap to fetch';
  //   _searchbarFocusNode = FocusNode(); // for changing the border color of search bar
  //   final user = _auth.currentUser;
  //   _fullname = user?.displayName;
  //   _profileImageURL = user?.photoURL;
  //   if (user != null) {
  //     // Check if the user has a display name
  //     if (user.displayName != null) {
  //       // Split the display name by space and take the first part as the username
  //       final parts = user.displayName?.split(' ');
  //       username = parts![0];
  //     } else {
  //       // If there's no display name, you can use the email as a username or customize it as needed
  //       username = 'Potato';
  //     }
  //   } else {
  //     // Handle the case where there is no authenticated user
  //     username = "Guest"; // or show an error message
  //   }
  // }

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

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }

    return true;
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isFetchingLocation = true; // Set fetching location to true when starting fetching
    });

    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      setState(() {
        _isFetchingLocation = false; // Set fetching location to false when permission denied
      });
      return;
    }

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) async {
      setState(() {
        _localArea = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
        _isFetchingLocation = false;
      });

      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks[0];
          setState(() {
            _localArea = placemark.subLocality ?? 'Tap to Fetch Location!';
            _fulladdress = "${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}, ${placemark.postalCode}" ?? '';
          });
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }).catchError((e) {
      setState(() {
        _isFetchingLocation = false; // Set fetching location to false on error
      });
    });
  }

  Widget buildFragmentContent() {
    // This list is for adding service images inside the Gesture detectors
    List<String> serviceCatImageURLs = [
      'https://cdn-icons-png.flaticon.com/512/5612/5612846.png',
      'https://cdn-icons-png.flaticon.com/512/1057/1057470.png',
      'https://cdn-icons-png.flaticon.com/512/2377/2377308.png',
      'https://cdn-icons-png.flaticon.com/512/3343/3343641.png',
      'https://cdn-icons-png.flaticon.com/512/681/681531.png',
      'https://cdn-icons-png.flaticon.com/512/4635/4635163.png',
      'https://cdn-icons-png.flaticon.com/512/6008/6008918.png',
      'https://cdn-icons-png.flaticon.com/512/3531/3531568.png',
    ];

    List<String> serviceCatNames = [
      'Pest Control',
      'Salon',
      'Spa',
      'Cleaning',
      'Painting',
      'Plumbing',
      'Electrician',
      'Carpenter',
    ];

    final int serviceItems = serviceCatImageURLs.length;

    List<String> serviceMostImageURLs = [
      'https://cdn-icons-png.flaticon.com/512/2470/2470595.png',
      'https://cdn-icons-png.flaticon.com/512/911/911409.png',
      'https://cdn-icons-png.flaticon.com/512/6008/6008918.png',
    ];

    List<String> serviceMostNames = [
      'Maid',
      'Appliance Repair',
      'Electrician',
    ];

    final int mostItems = serviceMostImageURLs.length;

    List<String> serviceWomenImageURLs = [
      'https://cdn-icons-png.flaticon.com/512/4192/4192022.png',
      'https://cdn-icons-png.flaticon.com/512/1802/1802113.png',
      'https://cdn-icons-png.flaticon.com/512/3461/3461972.png',
      'https://cdn-icons-png.flaticon.com/512/856/856612.png',
      'https://cdn-icons-png.flaticon.com/512/3461/3461961.png',
    ];

    List<String> serviceWomenNames = [
      'Waxing',
      'Haircut',
      'Manicure',
      'Facial',
      'Pedicure',
    ];

    final int womenItems = serviceWomenImageURLs.length;

    List<String> serviceBuyImageURLs = [
      'https://cdn-icons-png.flaticon.com/512/4992/4992693.png',
      'https://cdn-icons-png.flaticon.com/512/2516/2516211.png',
      'https://cdn-icons-png.flaticon.com/512/3659/3659950.png',
      'https://cdn-icons-png.flaticon.com/512/3731/3731057.png',
      'https://cdn-icons-png.flaticon.com/512/1198/1198368.png',
    ];

    List<String> serviceBuyNames = [
      'Water Purifier',
      'Smart Lock',
      'Appliances',
      'Gadgets',
      'Furnitures',
    ];

    final int buyItems = serviceBuyImageURLs.length;

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
                      padding: const EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 6.0),
                      // padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: kPrimaryColor,),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: _getCurrentLocation,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _isFetchingLocation
                                        ? const SpinKitThreeBounce(
                                      color: kPrimaryColor,
                                      size: 18.0,
                                    )
                                        : Text(
                                      _localArea,
                                      style: kHeadingFontStyle.copyWith(
                                        fontSize: 14,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    Text(
                                      _fulladdress,
                                      style: kContentFontStyle.copyWith(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      maxLines: 1, // Limit to a single line
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/notificationScreen');
                            },
                            child: const Icon(Icons.notifications, color: kPrimaryColor,),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 5.0,
                      color: kSeperatorColor,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                          child: Text(
                            'Hi $username!',
                            style: kHeadingFontStyle.copyWith(
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
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
                              dotColor: kContrastColor,     //End of carousel slider 1st card
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Container(
                          width: double.infinity,
                          height: 5.0,
                          color: kSeperatorColor,
                        ),
                        Row(                            //Services by category Heading
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Text(
                                'Services by category',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 6.0),
                                child: TextButton(
                                  onPressed: () {
                                    _currentIndex = 2;
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
                        SingleChildScrollView(              //Services by category Scroll View
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                for (int i = 0; i < serviceItems; i++) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        SquareCardService(
                                          imageURLs: [serviceCatImageURLs[i]],
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
                                          serviceCatNames[i],
                                          style: kContentFontStyle.copyWith(
                                            fontSize: 12.0,     //End of services by category
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
                        const SizedBox(
                          height: 16.0,
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
                          padding: EdgeInsets.fromLTRB(16.0, 10, 16, 6),
                          child: Text(
                            'Black Friday Sale',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: const BorderSide(
                                color: kPrimaryColor, // Set the border color here
                                width: 1.0, // Set the border width
                              ),// Adjust the radius as needed
                            ),
                            elevation: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Image.asset(
                                    'assets/images/salebanner.jpg',
                                    fit: BoxFit.cover,          //end of refer banner
                                  )
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Container(
                          width: double.infinity,
                          height: 5.0,
                          color: kSeperatorColor,
                        ),
                        const Padding(                    //Most Booked Heading
                          padding: EdgeInsets.fromLTRB(16.0, 10, 16, 6),
                          child: Text(
                            'Most Booked Services',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Padding(                         //Most Booked Heading
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (int i = 0; i < mostItems; i++) ...[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Column(
                                    children: [
                                      SquareCardService(
                                        imageURLs: [serviceMostImageURLs[i]],
                                        onTapCallback: () {
                                          // Provide different functionality based on the category index (i)
                                        },
                                      ),
                                      Text(
                                        serviceMostNames[i],
                                        style: kContentFontStyle.copyWith(
                                          fontSize: 12.0,     //End of most booked category
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Container(
                          width: double.infinity,
                          height: 5.0,
                          color: kSeperatorColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 90,
                                width: 90,
                                child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Money_Flat_Icon.svg/1200px-Money_Flat_Icon.svg.png'),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Claim 100% refund',
                                  style: kHeadingFontStyle.copyWith(
                                    fontSize: 15.0,
                                    color: const Color(0xff54B435)
                                  ),
                                ),
                                const SizedBox(height: 8.0,),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.6, // Adjust the width as needed
                                  child: Text(
                                    'If our partner delivered a service outside the Hausify app',
                                    style: kContentFontStyle.copyWith(fontSize: 12.0),
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                  ),
                                )
                              ],
                            ),
                            GestureDetector(
                              child: const Icon(CupertinoIcons.right_chevron),
                              onTap: (){
                                Navigator.pushNamed(context, '/refundScreen');
                              },
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 0.0,
                        ),
                        Container(
                          width: double.infinity,
                          height: 5.0,
                          color: kSeperatorColor,
                        ),
                        const Padding(                  //Women Salon Heading
                          padding: EdgeInsets.fromLTRB(16.0, 10, 16, 6),
                          child: Text(
                            'Women Salon',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        SingleChildScrollView(              //Women Salon Scroll View
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                for (int i = 0; i < womenItems; i++) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        SquareCardService(
                                          imageURLs: [serviceWomenImageURLs[i]],
                                          onTapCallback: () {
                                          },
                                        ),
                                        Text(
                                          serviceWomenNames[i],
                                          style: kContentFontStyle.copyWith(
                                            fontSize: 12.0,     //End of women salon category
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
                        const SizedBox(
                          height: 16.0,
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
                          padding: EdgeInsets.fromLTRB(16.0, 10, 16, 6),
                          child: Text(
                            'Medical help just a tap away!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: const BorderSide(
                                color: Color(0xff9EDDFF), // Set the border color here
                                width: 1.0, // Set the border width
                              ),// Adjust the radius as needed
                            ),
                            elevation: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: AspectRatio(
                                  aspectRatio: 1/1,
                                  child: Image.asset(
                                    'assets/images/medibanner.jpg',
                                    fit: BoxFit.cover,          //end of refer banner
                                  )
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Container(
                          width: double.infinity,
                          height: 5.0,
                          color: kSeperatorColor,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 10, 16, 6),
                          child: Text(
                            'Buy Products',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        SingleChildScrollView(              //Buy Products Scroll View
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                for (int i = 0; i < buyItems; i++) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        SquareCardService(
                                          imageURLs: [serviceBuyImageURLs[i]],
                                          onTapCallback: () {
                                          },
                                        ),
                                        Text(
                                          serviceBuyNames[i],
                                          style: kContentFontStyle.copyWith(
                                            fontSize: 12.0,     //End of buy products scroll view
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
                        const SizedBox(
                          height: 16.0,
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
                          padding: EdgeInsets.fromLTRB(16.0, 10, 16, 6),
                          child: Text(
                            'Offers',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              // side: const BorderSide(
                              //   color: kPrimaryColor, // Set the border color here
                              //   width: 1.0, // Set the border width
                              // ),// Adjust the radius as needed
                            ),
                            elevation: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Image.asset(
                                    'assets/images/lastbanner.jpg',
                                    fit: BoxFit.cover,          //end of last banner
                                  )
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
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
                          padding: EdgeInsets.fromLTRB(16.0, 10, 16, 6),
                          child: Text(
                            'Refer & Earn',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: const BorderSide(
                                color: kPrimaryColor, // Set the border color here
                                width: 1.0, // Set the border width
                              ),// Adjust the radius as needed
                            ),
                            elevation: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Image.asset(
                                    'assets/images/referbanner.jpg',
                                    fit: BoxFit.cover,          //end of refer banner
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              if (_currentIndex == 1)
                Column(
                  children: [
                    const fragmentTopBar(
                      topBarText: 'Cart',
                    ),
                    const SizedBox(height: 20.0,),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Card(
                            elevation: 0,  // No elevation
                            color: kSeperatorColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),  // Rounded edges
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Left side: Image and Service Name
                                  Container(
                                    width: 80,  // Adjust width as needed
                                    height: 80,  // Adjust height as needed
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),  // Rounded edges
                                      image: const DecorationImage(
                                        image: NetworkImage('https://cdn-icons-png.flaticon.com/512/3343/3343641.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ), // Add some spacing between image and text
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Cleaning',  // Replace with your service name
                                        style: kContentFontStyle
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                          'Available soon                                 ',  // Replace with your service name
                                          style: kContentFontStyle.copyWith(
                                            fontSize: 12
                                          )
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: const Icon(Icons.delete_forever_rounded, color: kPrimaryColor,),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 0,  // No elevation
                            color: kSeperatorColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),  // Rounded edges
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Left side: Image and Service Name
                                  Container(
                                    width: 80,  // Adjust width as needed
                                    height: 80,  // Adjust height as needed
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),  // Rounded edges
                                      image: const DecorationImage(
                                        image: NetworkImage('https://cdn-icons-png.flaticon.com/512/6008/6008918.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ), // Add some spacing between image and text
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                          'Electrician',  // Replace with your service name
                                          style: kContentFontStyle
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                          'Available soon                                 ',  // Replace with your service name
                                          style: kContentFontStyle.copyWith(
                                              fontSize: 12
                                          )
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: const Icon(Icons.delete_forever_rounded, color: kPrimaryColor,),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 360,),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ElevatedButton(
                        // onPressed: openUpgradeDialog,
                        onPressed: (){
                          Navigator.pushNamed(context, '/scheduleScreen');
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 0), // Full width
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12), // Adjust height
                        ),
                        child: const Text(
                          'Proceed to Book',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              if (_currentIndex == 2)
                Column(
                  children: [
                    const fragmentTopBar(
                      topBarText: 'Category',
                    ),
                    const SizedBox(height: 20.0,),
                    const Text(
                        'Home Services',
                      style: kHeadingFontStyle,
                    ),
                    const SizedBox(height: 12.0,),
                    Center(
                      child: Text(
                        'Choose from our wide range of home services',
                        style: kContentFontStyle.copyWith(
                          fontSize: 14
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0,),
                    CatServiceGrid(),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 5.0,
                      color: kSeperatorColor,
                    ),
                    const SizedBox(height: 20.0,),
                    const Text(
                      'Buy Products',
                      style: kHeadingFontStyle,
                    ),
                    const SizedBox(height: 12.0,),
                    Center(
                      child: Text(
                        'Bring home your favourite products',
                        style: kContentFontStyle.copyWith(
                            fontSize: 14
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0,),
                    CatProdServiceGrid(),
                  ],
                ),
              if (_currentIndex == 3)
                Column(
                  children: [
                    const fragmentTopBar(topBarText: 'User Profile'),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Container(
                        color: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 65.0,
                                backgroundImage: NetworkImage(_profileImageURL!),
                                backgroundColor: const Color(0xffEEEEEE),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                _fullname!,
                                style: const TextStyle(
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
                                      Navigator.pushNamed(context, '/myaccountScreen');
                                    },
                                  ),
                                  const SizedBox(height: 10.0,),
                                  buildCard(
                                    icon: Ionicons.settings,
                                    title: 'FAQs',
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/faqScreen');
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
                                    icon: Ionicons.help_circle,
                                    title: 'TroubleShoot',
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/troubleshootScreen');
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
              // if (_currentIndex == 4)
              //   Column(
              //     children: [
              //       const fragmentTopBar(
              //         topBarText: 'Chat Bot',
              //       ),
              //       CatServiceGrid()
              //     ],
              //   ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard({required IconData icon, required String title, VoidCallback? onPressed}) {
    return Card(
      elevation: 0,
      color: kNavBarColor,
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
          color: Colors.black54,
          size: 30.0,
        ),
        onTap: onPressed,
      ),
    );
  }

  Widget buildNavBarIcon(IconData icon, int index) {
    if (index == 0) {
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
    } else {
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
                color: kNavBarColor,
                borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildNavBarIcon(Icons.home, 0),
                  buildNavBarIcon(Icons.shopping_cart, 1),
                  buildNavBarIcon(Icons.grid_view_rounded, 2),
                  buildNavBarIcon(Icons.person, 3),
                  //buildNavBarIcon(Icons.message_rounded, 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CatServiceGrid extends StatelessWidget {
  final List<Service> services = [
    // List of services...
    Service('Maid', 'https://cdn-icons-png.flaticon.com/512/2470/2470595.png'),
    Service('Waxing', 'https://cdn-icons-png.flaticon.com/512/4192/4192022.png'),
    Service('Haircut', 'https://cdn-icons-png.flaticon.com/512/1802/1802113.png'),
    Service('Manicure', 'https://cdn-icons-png.flaticon.com/512/3461/3461972.png'),
    Service('Facial', 'https://cdn-icons-png.flaticon.com/512/856/856612.png'),
    Service('Pedicure', 'https://cdn-icons-png.flaticon.com/512/3461/3461961.png'),
    Service('Driver', 'https://cdn-icons-png.flaticon.com/512/3270/3270997.png'),
    Service('Salon', 'https://cdn-icons-png.flaticon.com/512/1057/1057470.png'),
    Service('Spa', 'https://cdn-icons-png.flaticon.com/512/2377/2377308.png'),
    Service('Cleaning', 'https://cdn-icons-png.flaticon.com/512/3343/3343641.png'),
    Service('Plumber', 'https://cdn-icons-png.flaticon.com/512/4635/4635163.png'),
    Service('Electrician', 'https://cdn-icons-png.flaticon.com/512/6008/6008918.png'),
    Service('Pest Control', 'https://cdn-icons-png.flaticon.com/512/5612/5612846.png'),
    Service('Appliance Repair', 'https://cdn-icons-png.flaticon.com/512/911/911409.png'),
    Service('Gadgets Repair', 'https://cdn-icons-png.flaticon.com/512/3659/3659899.png'),
    Service('Painter', 'https://cdn-icons-png.flaticon.com/512/681/681531.png'),
    Service('Carpenter', 'https://cdn-icons-png.flaticon.com/512/3531/3531568.png'),
    Service('Gardener', 'https://cdn-icons-png.flaticon.com/512/2316/2316118.png'),
    Service('Tailor', 'https://cdn-icons-png.flaticon.com/512/6920/6920474.png'),
    Service('Architect', 'https://cdn-icons-png.flaticon.com/512/3270/3270910.png'),
    Service('Dry Cleaning', 'https://cdn-icons-png.flaticon.com/512/5502/5502169.png'),
    // ... add all other services
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          childAspectRatio: 0.7,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          physics: const NeverScrollableScrollPhysics(),
          children: services.map((service) {
            return CatServiceCard(service: service);
          }).toList(),
        ),
      ),
    );
  }
}

class CatServiceCard extends StatelessWidget {
  final Service service;

  const CatServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.transparent,
            width: 1.0), // Adjust border width
        borderRadius: BorderRadius.circular(10.0),
        color: kSeperatorColor, // Set background color
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent, // Set card color to transparent
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              service.imageURL,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 8),
            Text(service.name,
              style: kContentFontStyle.copyWith(fontSize: 14),),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Add to cart button action
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: kPrimaryColor, // Change this to your desired color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Schedule', style: kContentFontStyle.copyWith(fontSize: 12, color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}


class CatProdServiceGrid extends StatelessWidget {
  final List<Service> services = [
    // List of services...
    Service('Water Purifier', 'https://cdn-icons-png.flaticon.com/512/4992/4992693.png'),
    Service('Smart Lock', 'https://cdn-icons-png.flaticon.com/512/2516/2516211.png'),
    Service('Appliances', 'https://cdn-icons-png.flaticon.com/512/3659/3659950.png'),
    Service('Gadgets', 'https://cdn-icons-png.flaticon.com/512/3731/3731057.png'),
    Service('Furnitures', 'https://cdn-icons-png.flaticon.com/512/1198/1198368.png'),
    Service('Cookwares', 'https://cdn-icons-png.flaticon.com/512/1703/1703122.png'),
    Service('Arts', 'https://cdn-icons-png.flaticon.com/512/2970/2970785.png'),
    Service('Sanitary', 'https://cdn-icons-png.flaticon.com/512/1606/1606456.png'),
    Service('Tools', 'https://cdn-icons-png.flaticon.com/512/2091/2091418.png'),
    Service('Gardening', 'https://cdn-icons-png.flaticon.com/512/1518/1518914.png'),
    Service('Infantware', 'https://cdn-icons-png.flaticon.com/512/3731/3731107.png'),
    Service('Pet Supplies', 'https://cdn-icons-png.flaticon.com/512/616/616408.png'),
    // ... add all other services
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        physics: const NeverScrollableScrollPhysics(),
        children: services.map((service) {
          return CatProdServiceCard(service: service);
        }).toList(),
      ),
    );
  }
}

class CatProdServiceCard extends StatelessWidget {
  final Service service;

  const CatProdServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.transparent,
            width: 1.0), // Adjust border width
        borderRadius: BorderRadius.circular(10.0),
        color: kSeperatorColor, // Set background color
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent, // Set card color to transparent
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              service.imageURL,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 8),
            Text(service.name,
              style: kContentFontStyle.copyWith(fontSize: 14),),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Add to cart button action
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: kPrimaryColor, // Change this to your desired color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Add to Cart', style: kContentFontStyle.copyWith(fontSize: 10, color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}



