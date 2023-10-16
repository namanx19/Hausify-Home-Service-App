import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:urbanserv/utils/constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  final PageController _pageController = PageController();

  // Updated the type to List<Widget>
  final List<Widget> pages = [
    const OnboardingPage(
      image: 'assets/images/obs1.png',
      title: 'Hausify in your city',
      subtitle: 'Find amazing places to visit',
    ),
    const OnboardingPage(
      image: 'assets/images/obs2.png',
      title: 'Services / Offerings - Everything served within 24 - 72 hours',
      subtitle: 'Book your trip with ease',
    ),
    const OnboardingPage(
      image: 'assets/images/obs3.png',
      title: 'Trusted, Skilled and Verified Helpers',
      subtitle: 'Enjoy your journey',
    ),
    const OnboardingPage(
      image: 'assets/images/obs4.png',
      title: '4.8 stars and 180+ Apartments',
      subtitle: 'Serving now in your city',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            itemBuilder: (context, index) => pages[index],
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Container(
              height: 120,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white.withOpacity(0), Colors.white],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: pages.length,
                        effect: const WormEffect(
                            type: WormType.thin,
                          activeDotColor: kPrimaryColor,
                          dotColor: kContrastColor,
                        ),
                        onDotClicked: (index) {
                          // Handle indicator tap if needed
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/loginScreen');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor, // Change to your color
                      minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.8, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: kContentFontStyle.copyWith(
                        fontSize: 20.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Image.asset(image, fit: BoxFit.contain, height: 400),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: kHeadingFontStyle.copyWith(
                    fontSize: 28.0,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  subtitle,
                  style: kContentFontStyle.copyWith(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 160,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
