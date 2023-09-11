import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:urbanserv/utils/constants.dart';
class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reenterPasswordController =
  TextEditingController();

  Color _nameBorderColor = Colors.grey;
  Color _emailBorderColor = Colors.grey;
  Color _phoneBorderColor = Colors.grey;
  Color _passwordBorderColor = Colors.grey;
  Color _reenterPasswordBorderColor = Colors.grey;

  void _setBorderColor(String field) {
    setState(() {
      switch (field) {
        case 'name':
          _nameBorderColor = kPrimaryColor;
          _emailBorderColor = Colors.grey;
          _phoneBorderColor = Colors.grey;
          _passwordBorderColor = Colors.grey;
          _reenterPasswordBorderColor = Colors.grey;
          break;
        case 'email':
          _nameBorderColor = Colors.grey;
          _emailBorderColor = kPrimaryColor;
          _phoneBorderColor = Colors.grey;
          _passwordBorderColor = Colors.grey;
          _reenterPasswordBorderColor = Colors.grey;
          break;
        case 'phone':
          _nameBorderColor = Colors.grey;
          _emailBorderColor = Colors.grey;
          _phoneBorderColor = kPrimaryColor;
          _passwordBorderColor = Colors.grey;
          _reenterPasswordBorderColor = Colors.grey;
          break;
        case 'password':
          _nameBorderColor = Colors.grey;
          _emailBorderColor = Colors.grey;
          _phoneBorderColor = Colors.grey;
          _passwordBorderColor = kPrimaryColor;
          _reenterPasswordBorderColor = Colors.grey;
          break;
        case 'reenterPassword':
          _nameBorderColor = Colors.grey;
          _emailBorderColor = Colors.grey;
          _phoneBorderColor = Colors.grey;
          _passwordBorderColor = Colors.grey;
          _reenterPasswordBorderColor = kPrimaryColor;
          break;
      }
    });
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Ionicons.person),
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: _nameBorderColor),
                      ),
                    ),
                    onTap: () => _setBorderColor('name'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Ionicons.mail),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: _emailBorderColor),
                      ),
                    ),
                    onTap: () => _setBorderColor('email'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Ionicons.call),
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: _phoneBorderColor),
                      ),
                    ),
                    onTap: () => _setBorderColor('phone'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Ionicons.lock_closed),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: _passwordBorderColor),
                      ),
                    ),
                    onTap: () => _setBorderColor('password'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _reenterPasswordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Ionicons.lock_closed),
                      labelText: 'Re-enter Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: _reenterPasswordBorderColor),
                      ),
                    ),
                    onTap: () => _setBorderColor('reenterPassword'),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                          value: isChecked,
                          shape: CircleBorder(),
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                          checkColor: Colors.white,
                        ),
                      ),
                      const Text('I accept the privacy policy'),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(200, 50)), // Set the minimum size
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50), // Set the border radius
                            side: BorderSide(color: Colors.blue, width: 2), // Set the border color and width
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.blue), // Set the background color
                        foregroundColor: MaterialStateProperty.all(Colors.white)
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Perform registration functionality
                        Navigator.pushNamed(context, '/start');
                      }
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}