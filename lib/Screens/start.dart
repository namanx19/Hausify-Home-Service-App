// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:urbanserv/utils/constants.dart';
import 'dart:async';
import 'dart:math';
import 'package:urbanserv/utils/service.dart';

import 'home_screen.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  List<Service> services = [
    // List of services...
    Service('Cleaning', 'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Plumber', 'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-plumber-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Electrician', 'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-multimeter-car-service-wanicon-flat-wanicon.png'),
    Service('Painter', 'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-painter-male-occupation-avatar-itim2101-flat-itim2101.png'),
    Service('Carpenter', 'https://img.icons8.com/fluency/2x/drill.png'),
    Service('Gardener', 'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-gardener-male-occupation-avatar-itim2101-flat-itim2101.png'),
    Service('Tailor', 'https://img.icons8.com/fluency/2x/sewing-machine.png'),
    Service('Maid', 'https://img.icons8.com/color/2x/housekeeper-female.png'),
    Service('Driver', 'https://img.icons8.com/external-sbts2018-lineal-color-sbts2018/2x/external-driver-women-profession-sbts2018-lineal-color-sbts2018.png'),
  ];
  // List<Service> services = [
  //   // List of services...
  //   Service('Cleaning', 'assets/images/carpenter.png'),
  //   Service('Plumber', 'assets/images/services/plumber.png'),
  //   Service('Electrician', 'assets/images/services/electrician.png'),
  //   Service('Painter', 'assets/images/services/painter.png'),
  //   Service('Carpenter', 'assets/images/services/carpenter.png'),
  //   Service('Gardener', 'assets/images/services/gardener.png'),
  //   Service('Tailor', 'assets/images/services/tailor.png'),
  //   Service('Maid', 'assets/images/services/maid.png'),
  //   Service('Driver', 'assets/images/services/driver.png'),
  // ];

  int selectedService = 4;
  double? latitude;
  double? longitude;
  String? _currentAddress;
  Position? _currentPosition;
  String? localArea;
  String? cityName;
  String? newCity;

  Future<bool> _handleLocationPermission() async {
    // Handling location permission...
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
    // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return true;
  }

  Future<void> _getCurrentPosition() async {
    // Getting current position...
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) async {
      setState(() => _currentPosition = position);

      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks[0];
          _currentAddress = "${placemark.locality}, ${placemark.administrativeArea}";
          // print("City: ${placemark.locality}");
          // print("Address: ${placemark.subLocality}");
          cityName = placemark.locality;
          localArea = placemark.subLocality;
          newCity = placemark.administrativeArea; //dummy var
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  @override
  void initState() {
    // Randomly select service every 2 seconds...
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        selectedService = Random().nextInt(services.length);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: services.length,
              itemBuilder: (BuildContext context, int index) {
                return serviceContainer(services[index].imageURL, services[index].name, index, kContentFontStyle.copyWith(fontWeight: FontWeight.normal, fontSize: 12.0));
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Easy, reliable way to take care of your home',
              textAlign: TextAlign.center,
              style: kContentFontStyle.copyWith(
                fontSize: 20.0,
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            //padding: const EdgeInsets.fromLTRB(16.0, 8.0 16.0, 8.0),
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              'We provide you with the best people to help take care of your home',
              textAlign: TextAlign.center,
              style: kContentFontStyle.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          ElevatedButton.icon(
            onPressed: () async {
              await _getCurrentPosition();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    localArea: localArea,
                    cityName: cityName,
                    newCity: newCity,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              padding: const EdgeInsets.fromLTRB(30.0, 14.0, 30.0, 14.0),
            ),
            icon: const Icon(Ionicons.location_outline),
            label: Text(
              'Get Location',
              style: kHeadingFontStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget serviceContainer(String image, String name, int index, TextStyle textStyle) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selectedService == index ? Colors.white : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index ? Colors.green : Colors.grey.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(image, height: 30),
              const SizedBox(height: 10,),
              Text(name, style: textStyle,)
            ]
        ),
      ),
    );
  }
}
