// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:urbanserv/utils/service.dart';
import 'dart:async';
import 'dart:math';
import 'package:ionicons/ionicons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:urbanserv/utils/constants.dart';

class StartPage extends StatefulWidget {
  const StartPage({ Key? key }) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  List<Service> services = [
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

  int selectedService = 4;
  
  double? latitude;
  double? longitude;
  
  void getLocationData() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        latitude = position.latitude;
        longitude = position.longitude;
        getData();
      } catch (e) {
        // Handle any errors that may occur while getting the location.
        print('Error getting location: $e');
      }
    } else if (status.isDenied) {
      // The user denied permission, you can show a dialog or message explaining why location access is needed.
      // You can also provide a button to open app settings.
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Location Permission'),
            content: const Text('To use this feature, please grant location access in the app settings.'),
            actions: [
              TextButton(
                onPressed: () {
                  // Open app settings
                  openAppSettings();
                },
                child: const Text('Open Settings'),
              ),
            ],
          );
        },
      );
    } else if (status.isPermanentlyDenied) {
      // The user permanently denied permission, typically by selecting "Never ask again" in the permission dialog.
      // You can prompt the user to go to settings and enable the permission.
      print('Location permission is permanently denied. You can prompt the user to enable it in settings.');
    }
  }

  void getData() async {
    Uri url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    Response response = await get(url);
    String data = response.body;
    var decodedData = jsonDecode(data);
    var cityName = decodedData['name'];
    if(response.statusCode == 200){
      print(cityName);
    }
    else{
      print(response.statusCode);
    }
  }


  @override
  void initState() {
    // Randomly select from service list every 2 seconds
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
        mainAxisAlignment: MainAxisAlignment.center, // Center the contents vertically
        children: [
          const SizedBox(height: 100),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
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
                return serviceContainer(services[index].imageURL, services[index].name, index);
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              getLocationData();
              getData();
              // Handle button press
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              // Set button color to orange
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0), // Set rounded corners
              ),
              padding: const EdgeInsets.fromLTRB(30.0, 14.0, 30.0, 14.0),

            ),
            icon: const Icon(Ionicons.location_outline), // Add location icon from Ionicons
            label: const Text(
              'Get Location',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  serviceContainer(String image, String name, int index) {
    return GestureDetector(
      onTap: () {
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selectedService == index ? Colors.white : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index ? Colors.green: Colors.grey.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(image, height: 30),
              const SizedBox(height: 10,),
              Text(name, style: const TextStyle(fontSize: 14),)
            ]
        ),
      ),
    );
  }
}