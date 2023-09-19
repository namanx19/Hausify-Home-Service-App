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
  final TextEditingController _reenterPasswordController = TextEditingController();

  Color _nameBorderColor = Colors.grey;
  Color _emailBorderColor = Colors.grey;
  Color _phoneBorderColor = Colors.grey;
  Color _passwordBorderColor = Colors.grey;
  Color _reenterPasswordBorderColor = Colors.grey;

  void _setBorderColor() {
    setState(() {
      _nameBorderColor = _validateName(_nameController.text) ? Colors.grey : kPrimaryColor;
      _emailBorderColor = _validateEmail(_emailController.text) ? Colors.grey : kPrimaryColor;
      _phoneBorderColor = _validatePhone(_phoneController.text) ? Colors.grey : kPrimaryColor;
      _passwordBorderColor = _validatePassword(_passwordController.text) ? Colors.grey : kPrimaryColor;
      _reenterPasswordBorderColor =
      _validatePassword(_reenterPasswordController.text) ? Colors.grey : kPrimaryColor;
    });
  }

  bool _validateName(String value) {
    return !RegExp(r"^[a-zA-Z\- ]+$").hasMatch(value);
  }

  bool _validateEmail(String value) {
    return !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value);
  }

  bool _validatePhone(String value) {
    return value.length != 10;
  }

  bool _validatePassword(String value) {
    return value.length < 8;
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
                    onTap: () => _setBorderColor(),
                    validator: (value) {
                      if (_validateName(value!)) {
                        return 'Only alphabets allowed';
                      }
                      return null;
                    },
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
                    onTap: () => _setBorderColor(),
                    validator: (value) {
                      if (_validateEmail(value!)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
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
                    onTap: () => _setBorderColor(),
                    validator: (value) {
                      if (_validatePhone(value!)) {
                        return 'Invalid phone number';
                      }
                      return null;
                    },
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
                    onTap: () => _setBorderColor(),
                    validator: (value) {
                      if (_validatePassword(value!)) {
                        return 'Password length must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    obscureText: true,
                    controller: _reenterPasswordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Ionicons.lock_closed),
                      labelText: 'Re-enter Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: _reenterPasswordBorderColor),
                      ),
                    ),
                    onTap: () => _setBorderColor(),
                    validator: (value) {
                      if (_validatePassword(value!) || value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
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
                        minimumSize: MaterialStateProperty.all(Size(200, 50)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.blue, width: 2),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor: MaterialStateProperty.all(Colors.white)),
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
