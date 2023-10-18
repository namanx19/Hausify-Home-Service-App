import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:urbanserv/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _emailFocusNode.unfocus();
        _passwordFocusNode.unfocus();
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Sign In',
                      style: kHeadingFontStyle.copyWith(
                          fontSize: 24.0,
                        color: kPrimaryColor
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),  // Adjust the radius as needed
                    ),
                    child: Image.asset(
                        'assets/images/loginlogo.png',
                      fit: BoxFit.cover,
                      height: 280,
                      width: 280,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: emailController,
                    focusNode: _emailFocusNode,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Ionicons.mail, color: kPrimaryColor, size: 20,),
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.black, fontSize: 14),  // Set the label text color to red
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
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    focusNode: _passwordFocusNode,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: kPrimaryColor, size: 20,),
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
                  ),
                  const SizedBox(height: 40.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(200,50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                    ),
                    onPressed: () async {
                      try {
                        final email = emailController.text;
                        final password = passwordController.text;
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        Navigator.pushNamed(context, '/start');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login failed!!'),
                          ),
                        );
                      }
                    },
                    child: Text(
                        'Login',
                      style: kContentFontStyle.copyWith(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 16.0
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          'Don\'t have an account?'
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/registrationScreen');
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
                          'Sign Up',
                          style: kContentFontStyle.copyWith(
                            color: kPrimaryColor,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50.0,
                        child: Divider(
                          color: Colors.grey,
                          height: 1.0,
                        ),
                      ),
                      Text(
                        '   or   ',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 50.0,
                        child: Divider(
                          color: Colors.grey,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[200], // Add a light grey background color
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap:() async{
                                await signInWithGoogle(context);
                              },
                              child: Image.asset(
                                'assets/images/google.png',
                                height: 60.0,
                                width: 60.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30.0,
                      ),
                      Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[200], // Add a light grey background color
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap:(){},
                              child: Image.asset(
                                'assets/images/apple.png',
                                height: 60.0,
                                width: 60.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  signInWithGoogle(BuildContext context) async{
    GoogleSignInAccount? googleUser =await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth= await googleUser?.authentication;
    AuthCredential credential=GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
    );
    UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);
    if(userCredential.user!=null)
    {
      print(userCredential);
      Navigator.pushNamed(context, '/start');
    }


  }

}
