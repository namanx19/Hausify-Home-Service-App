import 'package:flutter/material.dart';
import 'package:urbanserv/utils/constants.dart';

class TroubleshootScreen extends StatelessWidget {
  const TroubleshootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const fragmentTopBar(topBarText: 'Troubleshoot'),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/7910/7910582.png',
                        height: 220,
                        width: 220,
                      ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    'Encountering Issues?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'We\'re here to help! Below are common problems and their solutions to ensure a seamless experience.',
                    style: kHeadingFontStyle.copyWith(
                        fontWeight: FontWeight.normal
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    '1. App Crashes or Freezes',
                    style: kHeadingFontStyle
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text('- Possible Causes:', style: kContentFontStyle,),
                  const Text('- Outdated app version.' , style: kContentFontStyle,),
                  const Text('- Insufficient device storage or memory.', style: kContentFontStyle,),
                  const Text('- Conflicting with other apps.', style: kContentFontStyle,),
                  const SizedBox(height: 16.0),
                  const Text(
                    '2. Unable to Place a Service Request',
                    style: kHeadingFontStyle
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text('- Possible Causes:', style: kContentFontStyle,),
                  const Text('- Poor internet connectivity.', style: kContentFontStyle,),
                  const Text('- Incomplete or incorrect profile information.', style: kContentFontStyle,),
                  const SizedBox(height: 16.0),
                  const Text(
                    '3. Payment Issues',
                    style: kHeadingFontStyle
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text('- Possible Causes:', style: kContentFontStyle,),
                  const Text('- Incorrect payment details.', style: kContentFontStyle,),
                  const Text('- Insufficient funds.', style: kContentFontStyle,),
                  const SizedBox(height: 16.0),
                  const Text(
                    '4. Service Not Delivered as Expected',
                    style: kHeadingFontStyle
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text('- Possible Causes:', style: kContentFontStyle,),
                  const Text('- Miscommunication.', style: kContentFontStyle,),
                  const Text('- Technical issues.', style: kContentFontStyle,),
                  const SizedBox(height: 16.0),
                  const Text(
                    '5. Login or Account Problems',
                    style: kHeadingFontStyle
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text('- Possible Causes:', style: kContentFontStyle,),
                  const Text('- Forgotten password.', style: kContentFontStyle,),
                  const Text('- Incorrect login credentials.', style: kContentFontStyle,),
                  const SizedBox(height: 24.0),
                  Text(
                    'If the issue persists or you encounter a different problem, please contact our support team for further assistance.',
                    style: kHeadingFontStyle.copyWith(
                      fontWeight: FontWeight.normal
                    )
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

