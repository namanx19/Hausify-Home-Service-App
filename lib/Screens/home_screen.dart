import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Color> boxColors = List.generate(9, (index) => Colors.grey.shade300);
  int selectedIndex = -1;
  Random random = Random();

  void selectRandomBox() {
    int randomIndex;

    do {
      randomIndex = random.nextInt(9);
    } while (randomIndex == selectedIndex);

    setState(() {
      if (selectedIndex != -1) {
        boxColors[selectedIndex] = Colors.grey; // Reset previous box
      }
      boxColors[randomIndex] = Colors.lightBlue; // Highlight the new box
      selectedIndex = randomIndex;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        boxColors[randomIndex] = Colors.grey; // Reset the highlighted box after 2 seconds
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(25.0),
              color: Colors.transparent,
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(9, (index) {
                  return Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: boxColors[index],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: index == selectedIndex ? Colors.blue : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    selectedIndex = -1; // Reset the selected index when the widget is disposed
  }
}
