// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:urbanserv/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  final _auth = FirebaseAuth.instance;

  Color _nameBorderColor = Colors.grey;
  Color _emailBorderColor = Colors.grey;
  Color _phoneBorderColor = Colors.grey;
  Color _passwordBorderColor = Colors.grey;
  Color _reenterPasswordBorderColor = Colors.grey;
  TextEditingController _otpController = TextEditingController(); // Added OTP controller

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
    return !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zAZ0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value);
  }

  bool _validatePhone(String value) {
    return value.length != 10;
  }

  bool _validatePassword(String value) {
    return value.length < 8;
  }

  bool isChecked = false;

  Future<void> sendOTP() async {
    try {
      final phone = "+91" + _phoneController.text; // Assuming the phone number format
      final confirmationResult = await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Automatically sign in if verification is complete
          _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          // Store the verification ID
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );

      // OTP sent to the phone, now display OTP input field
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text("Enter OTP", textAlign: TextAlign.center),
            ),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.7, // Adjust the width as needed
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: _otpController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: 'Phone OTP',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(color: _nameBorderColor),
                  ),
                ),
              ),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(150, 40)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () async {
                    // Your existing code for button onPressed
                  },
                  child: Text("Verify OTP"),
                ),
              ),
            ],
          );


        },
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification failed. Please try again.'),
        ),
      );
    }
  }

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
                    keyboardType: TextInputType.number,
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
                          shape: const CircleBorder(),
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
                      minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        String phone = _phoneController.text;

                        try {
                          final newUser = await _auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          if (newUser != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registration Successful !! Please Verify Email and Phone.'),
                              ),
                            );
                            // Send OTP to phone and verify it
                            await sendOTP();
                          }
                        } catch (e) {
                          print(e);
                        }
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

  String _verificationId = '';

  Future<void> verifyOTP() async {
    try {
      AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otpController.text,
      );

      final userCredential = await _auth.signInWithCredential(authCredential); // Verify OTP

      if (userCredential != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Phone Verification Successful. Please check your email for verification.'),
          ),
        );

        // You can also send a verification email to the user's email address
        //  await _auth.currentUser.sendEmailVerification();
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification failed. Please try again.'),
        ),
      );
    }
  }
}