import 'package:flutter/material.dart';
import 'package:urbanserv/utils/constants.dart';

class SubscriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const fragmentTopBar(topBarText: 'Subscription Plans'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PremiumPlanCard(
                    duration: 'Monthly',
                    price: '₹ 199',
                    description: 'Unlock premium features on a monthly basis.',
                    image: 'assets/images/month.png',
                  ),
                  PremiumPlanCard(
                    duration: 'Quarterly',
                    price: '₹ 499',
                    description: 'Get a quarterly subscription with savings.',
                    image: 'assets/images/quarter.png',
                  ),
                  PremiumPlanCard(
                    duration: 'Annually',
                    price: '₹ 799',
                    description: 'Pay once a year and enjoy the best value.',
                    image: 'assets/images/yearly.png',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class PremiumPlanCard extends StatelessWidget {
  final String duration;
  final String price;
  final String description;
  final String image;

  PremiumPlanCard({
    required this.duration,
    required this.price,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Adjust the corner radius
      ),
      color: kSeperatorColor,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Image.asset(image, height: 120, width: 120,)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  duration,
                  style: kHeadingFontStyle.copyWith(
                    fontSize: 24,
                    color: Color(0xff192655),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  price,
                  style: kHeadingFontStyle.copyWith(
                      fontSize: 24,
                    color: Color(0xff279EFF),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: kContentFontStyle.copyWith(
                    color: Color(0xff192655)
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement the action to subscribe to this plan
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 0),
                      backgroundColor: Color(0xff192655),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text('Subscribe', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}