import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // The current page index of the PageView
  int currentPage = 0;

  // The list of pages for the PageView
  List<Widget> pages = [
    const OnboardingPage(
      image: 'assets/images/obs1.png',
      title: 'UrbanServ in your city.',
      subtitle: 'Find amazing places to visit',
    ),
    const OnboardingPage(
      image: 'assets/images/obs2.png',
      title: 'Services / Offerings - Everything served within 24-72 hours',
      subtitle: 'Book your trip with ease',
    ),
    const OnboardingPage(
      image: 'assets/images/obs3.png',
      title: 'Trusted, Skilled and Verified Helpers',
      subtitle: 'Enjoy your journey',
    ),
    // const OnboardingPage(
    //   image: 'images/obs4.png',
    //   title: 'Travel',
    //   subtitle: 'Enjoy your journey',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // The PageView that shows the onboarding pages
          PageView.builder(
            itemCount: pages.length,
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            itemBuilder: (context, index) => pages[index],
          ),
          // The bottom part that shows the indicators and the button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white,
                  ],
                ),
              ),
              child: Column(
                children: [
                  // The row of indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center indicators
                    children: [
                      const Spacer(), // Add a spacer to align indicators between the text and button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          pages.length,
                              (index) => buildIndicator(index),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // The "Get Started" button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/loginScreen');
                      // Navigate to the home screen
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.8, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child:
                    const Text('Get Started', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // A helper method to build an indicator for a given index
  Widget buildIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8, // Smaller indicator height
      width: currentPage == index ? 16 : 8, // Smaller indicator width
      decoration: BoxDecoration(
        color:
        currentPage == index ? Theme.of(context).primaryColor : Colors.grey,
        borderRadius: BorderRadius.circular(4), // Smaller border radius
      ),
    );
  }
}

// A widget that represents a single onboarding page
class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const OnboardingPage({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center( // Center the contents vertically and horizontally
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // The image part
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Image.asset(image, fit: BoxFit.cover, height: 400)), // Smaller image size
          const SizedBox(height: 16),
          // The text part
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)), // Adjusted font size
                const SizedBox(height: 8),
                Text(subtitle, style: const TextStyle(fontSize: 16, color: Colors.grey)), // Adjusted font size
              ],
            ),
          ),
        ],
      ),
    );
  }
}
