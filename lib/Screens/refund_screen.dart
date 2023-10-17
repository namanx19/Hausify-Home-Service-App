import 'package:flutter/material.dart';
import 'package:urbanserv/utils/constants.dart';

class RefundScreen extends StatelessWidget {
  const RefundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            fragmentTopBar(topBarText: 'Refund Policy'),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/5501/5501571.png',
                      height: 220,
                      width: 220,
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    'Refund Policy',
                    style: kHeadingFontStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'At Hausify, we prioritize your satisfaction and strive to ensure a seamless experience. Our refund policy is designed to offer you peace of mind when using our platform for home services.',
                    style: kContentFontStyle.copyWith(
                        fontWeight: FontWeight.normal,
                      fontSize: 16
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Service Delivery through Hausify App',
                    style: kHeadingFontStyle,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Full Refund: If you are dissatisfied with the service provided through the Hausify app, and you request a refund within 24-72 hours from the service completion, we will issue a 100% refund.',
                    style: kContentFontStyle.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 16
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Service Delivery Outside the Hausify App',
                    style: kHeadingFontStyle,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Full Refund: If our partner delivered a service outside the Hausify app, we will provide a 100% refund upon verification of the service delivery details.',
                    style: kContentFontStyle.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 16
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Requesting a Refund',
                    style: kHeadingFontStyle,
                  ),
                  SizedBox(height: 16.0),
                  Text('To request a refund, please follow these steps:', style: kContentFontStyle.copyWith(fontWeight: FontWeight.normal, fontSize: 16),),
                  SizedBox(height: 16.0),
                  Text('1. Contact our support team via email or call customer support within 48 hours of service completion.', style: kContentFontStyle.copyWith(fontWeight: FontWeight.normal, fontSize: 16),),
                  Text('2. Provide details about the service and the reason for requesting a refund.', style: kContentFontStyle.copyWith(fontWeight: FontWeight.normal, fontSize: 16),),
                  Text('3. Our team will review the request and may seek additional information if required.', style: kContentFontStyle.copyWith(fontWeight: FontWeight.normal, fontSize: 16),),
                  Text('4. Once approved, the refund will be initiated to the original payment method used for the transaction.', style: kContentFontStyle.copyWith(fontWeight: FontWeight.normal, fontSize: 16),),
                  SizedBox(height: 16.0),
                  Text(
                    'Please note that refunds may take 7-10 business days to reflect in your account.',
                    style: kContentFontStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'For any questions or concerns regarding our refund policy, please reach out to our support team.',
                    style: kContentFontStyle.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 16
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
