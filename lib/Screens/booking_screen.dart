import 'package:flutter/material.dart';
import 'package:urbanserv/utils/constants.dart';

class ServiceInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,// Make the card take the entire width
          child: Card(
            elevation: 0,
            color: kSeperatorColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Services opted', 'Cleaning, Electrician'),
                  _buildInfoRow('Availability', 'Available Now', textColor: Colors.green),
                  _buildInfoRow('Date', '19 October 2023'),
                  _buildInfoRow('Time', '02:00 PM'),
                  _buildInfoRow('Repeat', 'No Repeat'),
                  _buildInfoRow('Additional Service', 'Washing'),
                  _buildInfoRow('Address', 'Mohaddipur, Gorakhpur'),
                  _buildInfoRow('Payment', 'On Completion'),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0,),
        Container(
          width: double.infinity,
          child: Card(
            elevation: 0,
            color: kSeperatorColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              width: 300, // Set the desired width
              height: 150, // Set the desired height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.grey, // Add a border for styling
                  width: 1.0,
                ),
              ),
              child: TextField(
                maxLines: 5, // Specify the number of visible lines
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16.0),
                  hintText: 'Describe about the service you need. Please provide necessary details.',
                  border: InputBorder.none, // Hide the default border
                ),
              ),
            ),
          ),
        )
      ],
    );

  }

  Widget _buildInfoRow(String label, String value, {Color textColor = Colors.black87}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: kHeadingFontStyle.copyWith(color: textColor),
          children: [
            TextSpan(
              text: value,
              style: kContentFontStyle.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            fragmentTopBar(topBarText: 'Booking'),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ServiceInfoCard(),
                    SizedBox(height: 180.0),
                    ElevatedButton(
                      // onPressed: openUpgradeDialog,
                      onPressed: (){
                        Navigator.pushNamed(context, '/homescreen');
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
                        'Book Now',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}