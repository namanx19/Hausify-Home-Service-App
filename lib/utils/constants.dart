import 'package:flutter/material.dart';
import 'service.dart';

const kIconColor = Color(0xff040D12);
const kPrimaryColor = Color(0xffFC8019);
const kContrastColor = Color(0xffFFE6C7);
const kSeperatorColor = Color(0xffEEEEEE);
const kNavBarColor = Color(0xFFF5F5F5);

const kHeadingFontStyle = TextStyle(
  fontFamily: 'BoldHeading',
  fontSize: 18.0,
  color: Colors.black,
  fontWeight: FontWeight.bold, // Use FontWeight to select the style (e.g., Bold)
  //fontSize: 24.0,
);

const kContentFontStyle = TextStyle(
  fontFamily: 'LightContent',
  fontSize: 16.0,
  color: Colors.black,
  fontWeight: FontWeight.bold, // Use FontWeight to select the style (e.g., Bold)
);

class fragmentTopBar extends StatelessWidget {
  final String topBarText;
  const fragmentTopBar({
    super.key, required this.topBarText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white, //TopBar Color
          padding: const EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 6.0),
          // padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
          child: Center(
            child: Text(
              topBarText,
              style: kHeadingFontStyle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: Colors.black87,
              ),
            ),
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
      ],
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
//New List of Service with updated images
// List<Service> services = [
//   // List of services...
//   Service('Cleaning', 'https://cdn-icons-png.flaticon.com/512/3343/3343641.png'),
//   Service('Plumber', 'https://cdn-icons-png.flaticon.com/512/4635/4635163.png'),
//   Service('Electrician', 'https://cdn-icons-png.flaticon.com/512/6008/6008918.png'),
//   Service('Painter', 'https://cdn-icons-png.flaticon.com/512/681/681531.png'),
//   Service('Carpenter', 'https://cdn-icons-png.flaticon.com/512/3531/3531568.png'),
//   Service('Gardener', 'https://cdn-icons-png.flaticon.com/512/2316/2316118.png'),
//   Service('Tailor', 'https://cdn-icons-png.flaticon.com/512/6920/6920474.png'),
//   Service('Maid', 'https://cdn-icons-png.flaticon.com/512/2470/2470595.png'),
//   Service('Driver', 'https://cdn-icons-png.flaticon.com/512/3270/3270997.png'),
//   Service('Salon/SPA', 'https://cdn-icons-png.flaticon.com/512/2025/2025470.png'),
//   Service('Pest Control', 'https://cdn-icons-png.flaticon.com/512/5612/5612846.png'),
//   Service('AC & Appliance Repair', 'https://cdn-icons-png.flaticon.com/512/911/911409.png'),
//   Service('Gadgets Repair', 'https://cdn-icons-png.flaticon.com/512/3659/3659899.png'),
// ];