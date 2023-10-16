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
  String _verificationId = '';

  late FocusNode _nameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _phoneFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _repasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _repasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _repasswordFocusNode.dispose();
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

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

  bool isChecked = false;bool isPhone = false;bool isMail = false;

  Future<void> sendOTP(BuildContext context) async {
    try {
      final phone = "+91" + _phoneController.text; // Assuming the phone number format

      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically sign in if verification is complete
          await _auth.signInWithCredential(credential);
          isPhone=true;
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Verification failed. Either already registered or invalid.'),
            ),
          );
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
            title: const Text("Enter OTP"),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: _otpController,
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  AuthCredential authCredential = PhoneAuthProvider.credential(
                    verificationId: _verificationId,
                    smsCode: _otpController.text,
                  );

                  try  {
                    await _auth.signInWithCredential(authCredential); // Verify OTP
                    User? user = _auth.currentUser;
                    if(user!=null)
                    {isPhone=true;}


                    Navigator.of(context).pop();
                    sendEmailVerificationAndRegisterUser(context, _auth, _emailController.text,_passwordController.text);

                  } catch (e) {
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Verification failed. Either already registered or invalid.'),
                      ),
                    );
                  }
                },
                child: const Text("Verify OTP"),
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

  Future<void> sendEmailVerificationAndRegisterUser(
      BuildContext context, FirebaseAuth _auth, String email, String password) async {
    try {
      // Create a new user with email and password
      // Display a dialog to inform the user to check their email
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Verify Email"),
            content: const Text(
                "A verification email has been sent to your email address. Please check your inbox and click the verification link to complete the registration."),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  await _auth.createUserWithEmailAndPassword(email: email, password: password);

                  User? user = _auth.currentUser;

                  // Send email verification
                  await user?.sendEmailVerification();
                  Navigator.of(context).pop();
                  if(user!=null)
                  {isMail=true;}
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      // You can navigate the user to the home screen or login screen here.
      // Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration failed. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _nameFocusNode.unfocus();
        _emailFocusNode.unfocus();
        _phoneFocusNode.unfocus();
        _passwordFocusNode.unfocus();
        _repasswordFocusNode.unfocus();
      },
      child: Scaffold(
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
                    Center(
                      child: Text(
                        'Sign Up',
                        style: kHeadingFontStyle.copyWith(
                            fontSize: 24.0,
                            color: kPrimaryColor
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),  // Adjust the radius as needed
                      ),
                      child: Image.asset(
                        'assets/images/registerlogo.png',
                        fit: BoxFit.cover,
                        height: 240,
                        width: 240,
                      ),
                    ),
                    const SizedBox(height: 16.0,),
                    TextFormField(
                      controller: _nameController,
                      focusNode: _nameFocusNode,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Ionicons.person, color: kPrimaryColor, size: 20,),
                        labelText: 'Name',
                        labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(color: kPrimaryColor),  // Color of the border when not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(color: kPrimaryColor),  // Color of the border when focused
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
                      focusNode: _emailFocusNode,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Ionicons.mail, color: kPrimaryColor, size: 20,),
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(color: kPrimaryColor),  // Color of the border when not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(color: kPrimaryColor),  // Color of the border when focused
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
                      focusNode: _phoneFocusNode,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Ionicons.call, color: kPrimaryColor, size: 20,),
                        labelText: 'Phone Number',
                        labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(color: kPrimaryColor),  // Color of the border when not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(color: kPrimaryColor),  // Color of the border when focused
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
                      focusNode: _passwordFocusNode,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Ionicons.lock_closed, color: kPrimaryColor, size: 20,),
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(color: kPrimaryColor),  // Color of the border when not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(color: kPrimaryColor),  // Color of the border when focused
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
                      focusNode: _repasswordFocusNode,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Ionicons.lock_closed, color: kPrimaryColor, size: 20,),
                        labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
                        labelText: 'Re-enter Password',
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(color: kPrimaryColor),  // Color of the border when not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(color: kPrimaryColor),  // Color of the border when focused
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
                    const SizedBox(height: 40.0),
                    Row(
                      children: [
                        const SizedBox(width: 4.0),
                        CircleCheckbox(
                          onChanged: (isChecked) {
                            // Handle checkbox state changes
                          },
                        ),
                        const SizedBox(width: 16.0),
                        const Text('I accept the Privacy Policy.'),
                        TextButton(
                          onPressed: () {
                            //Navigate to screen to Read Privacy Policy
                            // Navigator.pushNamed(context, '/registrationScreen');
                          },
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return kContrastColor;  // Color when pressed
                                }
                                return Colors.transparent;  // Default color
                              },
                            ),
                          ),
                          child: Text(
                            'Read',
                            style: kContentFontStyle.copyWith(
                              color: kPrimaryColor,
                              fontSize: 14.0,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                      ),
                      onPressed: () async {
                        await sendOTP(context);
                        if(isMail && isPhone)
                        {
                          Navigator.pushNamed(context, '/loginScreen');

                        }
                        else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please verify both email and phone no.'),
                            ),
                          );
                        }

                      },
                      child: Text(
                          'Register',
                        style: kContentFontStyle.copyWith(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CircleCheckbox extends StatefulWidget {
  final Function(bool) onChanged;

  CircleCheckbox({required this.onChanged});

  @override
  _CircleCheckboxState createState() => _CircleCheckboxState();
}

class _CircleCheckboxState extends State<CircleCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          widget.onChanged(isChecked);
        });
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: isChecked ? kPrimaryColor : kPrimaryColor),
          color: isChecked ? kPrimaryColor : Colors.white,
        ),
        child: isChecked
            ? const Center(
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 20.0,
          ),
        )
            : null,
      ),
    );
  }
}