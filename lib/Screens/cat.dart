import 'package:flutter/material.dart';
import 'package:urbanserv/utils/constants.dart';

class Service {
  final String name;
  final String imageURL;

  Service(this.name, this.imageURL);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CatServiceGrid(),
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
    // ... add all other services
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 14.0,
          crossAxisSpacing: 14.0,
          physics: NeverScrollableScrollPhysics(),
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
              height: 100,
              width: 100,
            ),
            SizedBox(height: 8),
            Text(service.name,
            style: kContentFontStyle.copyWith(fontSize: 14),),
            SizedBox(height: 8),
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
              child: Text('Schedule', style: kContentFontStyle.copyWith(fontSize: 14, color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}


