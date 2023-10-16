import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});
  final _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Ionicons.mail),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(200,50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
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
                  child: const Text('Login'),
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
                      child: const Text('Register Here'),
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
                        child: TextButton(
                          onPressed:() async{
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
                        child: TextButton(
                          onPressed:(){},
                          child: Image.asset(
                            'assets/images/apple.png',
                            height: 60.0,
                            width: 60.0,
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





// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// class LoginScreen extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Ionicons.mail),
//                     labelText: 'Email',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(50.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20.0),
//                 TextField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.lock),
//                     labelText: 'Password',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(50.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20.0),
//                 ElevatedButton(
//                   style: ButtonStyle(
//                     minimumSize: MaterialStateProperty.all(const Size(200,50)),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(50.0),
//                       ),
//                     ),
//                   ),
//                   onPressed: () async {
//                     try {
//                       final email = emailController.text;
//                       final password = passwordController.text;
//                       await FirebaseAuth.instance.signInWithEmailAndPassword(
//                         email: email,
//                         password: password,
//                       );
//                       Navigator.pushNamed(context, '/start');
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Login failed!!'),
//                         ),
//                       );
//                     }
//                   },
//                   child: const Text('Login'),
//                 ),
//                 const SizedBox(
//                     height: 16.0
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                         'Don\'t have an account?'
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/registrationScreen');
//                       },
//                       child: const Text('Register Here'),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 16.0,
//                 ),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: 50.0,
//                       child: Divider(
//                         color: Colors.grey,
//                         height: 1.0,
//                       ),
//                     ),
//                     Text(
//                       '   or   ',
//                       style: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 50.0,
//                       child: Divider(
//                         color: Colors.grey,
//                         height: 1.0,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 60.0,
//                       width: 60.0,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200], // Add a light grey background color
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: TextButton(
//                           onPressed:() async{
//                             await signInWithGoogle(context);
//                           },
//                           child: Image.asset(
//                             'assets/images/google.png',
//                             height: 60.0,
//                             width: 60.0,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 30.0,
//                     ),
//                     Container(
//                       height: 60.0,
//                       width: 60.0,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200], // Add a light grey background color
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: TextButton(
//                           onPressed:(){},
//                           child: Image.asset(
//                             'assets/images/apple.png',
//                             height: 60.0,
//                             width: 60.0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   signInWithGoogle(BuildContext context) async{
//     GoogleSignInAccount? googleUser =await GoogleSignIn().signIn();
//     GoogleSignInAuthentication? googleAuth= await googleUser?.authentication;
//     AuthCredential credential=GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken
//     );
//     UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);
//     if(userCredential.user!=null)
//     {
//       print(userCredential);
//       Navigator.pushNamed(context, '/start');
//     }
//
//
//   }
// }
