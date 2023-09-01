import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              onPressed: () {
                // Perform login logic here
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
                    onPressed: (){
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
                  '   OR   ',
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
                      onPressed:(){},
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
    );
  }
}
