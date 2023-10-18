import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:urbanserv/utils/constants.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const fragmentTopBar(
            topBarText: 'Notifications',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 1,
                  color: kNavBarColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.notifications,
                          color: kPrimaryColor,
                        ),
                        const SizedBox(width: 12.0),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Exciting News!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Hausify now serving in Gorakhpur',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              'Book a service now',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            // Handle cross icon tap
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
