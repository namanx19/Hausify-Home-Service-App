import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urbanserv/utils/constants.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isEditing = false;
  String? name, email, phone, address;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = _auth.currentUser;

    if (user != null) {
      String? displayName = user.displayName;
      String? userEmail = user.email;
      String? userPhone = user.phoneNumber;
      String? userAddress = ''; // Initialize with the user's data if available

      nameController.text = displayName ?? '';
      emailController.text = userEmail ?? '';
      phoneController.text = userPhone ?? '';
      addressController.text = userAddress ?? '';
    }
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void saveChanges() {
    // Save the changes to Firebase or your data source
    // Update 'name', 'email', 'phone', 'address' with new values.
    setState(() {
      isEditing = false;
      name = nameController.text;
      email = emailController.text;
      phone = phoneController.text;
      address = addressController.text;
    });
  }

  void openUpgradeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Upgrade to Pro'),
          content: Text('Upgrade to the Pro version for additional features.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const fragmentTopBar(topBarText: 'My Account'),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      'assets/images/my-account.png',
                    height: 160,
                    width: 160,
                  ),
                  SizedBox(height: 40),
                  RoundedTextField(
                    controller: nameController,
                    labelText: 'Name',
                    isEditing: isEditing,
                    icon: Icons.person,
                    borderColor: isEditing ? Colors.orange : Colors.black,
                  ),
                  RoundedTextField(
                    controller: emailController,
                    labelText: 'Email',
                    isEditing: false, // Email should not be editable
                    icon: Icons.email,
                    borderColor: kPrimaryColor,
                  ),
                  RoundedTextField(
                    controller: phoneController,
                    labelText: 'Phone',
                    isEditing: isEditing,
                    icon: Icons.phone,
                    borderColor: isEditing ? kPrimaryColor : Colors.black,
                  ),
                  RoundedTextField(
                    controller: addressController,
                    labelText: 'Address',
                    isEditing: isEditing,
                    icon: Icons.location_on,
                    borderColor: isEditing ? kPrimaryColor : Colors.black,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: isEditing ? saveChanges : toggleEditing,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 0), // Full width
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12), // Adjust height
                    ),
                    child: Text(
                      isEditing ? 'Save' : 'Edit Profile',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: openUpgradeDialog,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 0), // Full width
                      backgroundColor: Color(0xff192655),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12), // Adjust height
                    ),
                    child: const Text(
                      'Upgrade to Pro',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isEditing;
  final IconData icon;
  final Color borderColor;

  RoundedTextField({
    required this.controller,
    required this.labelText,
    required this.isEditing,
    required this.icon,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Icon(icon, color: kPrimaryColor),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                readOnly: !isEditing,
                decoration: InputDecoration(
                  hintText: labelText,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
