import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urbanserv/utils/constants.dart';

class FAQScreen extends StatelessWidget {
  final List<FAQItem> faqItems = [
    FAQItem(
        question: "What is HAUSIFY?",
        answer:
        "HAUSIFY is a comprehensive home service app designed to make your life easier. It connects you with a network of trusted and qualified service providers who can assist you with a wide range of home-related tasks, from cleaning and repairs to landscaping and more. With HAUSIFY, you can conveniently book the services you need, all in one place."),
    FAQItem(
        question: "How can I download the HAUSIFY app?",
        answer: "To download the HAUSIFY app, visit the Apple App Store if you're using an iOS device or the Google Play Store for Android devices. Simply search for \"HAUSIFY\" and click the download or install button."),
    FAQItem(
        question: "Is HAUSIFY available for both iOS and Android devices?",
        answer: "Yes, HAUSIFY is accessible on both iOS and Android platforms, making it versatile and compatible with a wide range of devices."),
    FAQItem(
        question: "What types of home services can I find on HAUSIFY?",
        answer: "HAUSIFY offers an extensive array of home services, including house cleaning, plumbing, electrical work, home renovations, landscaping, pest control, handyman services, and much more. Whatever your home-related needs are, HAUSIFY likely has a service provider to assist you."),
    FAQItem(
        question: "How do I book a service through HAUSIFY?",
        answer: "Booking a service through HAUSIFY is straightforward. Open the app, select the service you require, browse through available service providers, choose the one that suits your needs, and then schedule a convenient appointment time."),
    FAQItem(
        question: "Is HAUSIFY available in my city/region?",
        answer: "HAUSIFY is expanding rapidly and aims to serve as many regions as possible. Availability may vary, so it's best to check the app to see if your city or region is supported."),
    FAQItem(
        question: "Are the service providers on HAUSIFY background checked and verified?",
        answer: "Yes, we take your safety seriously. All service providers on HAUSIFY undergo rigorous background checks and verification processes to ensure they are trustworthy and qualified to perform the services they offer."),
    FAQItem(
        question: "How can I pay for services on HAUSIFY?",
        answer: "HAUSIFY offers various payment options, including credit/debit cards, digital wallets, or cash, depending on your preference. Payment can usually be made securely within the app."),
    FAQItem(
        question: "Can I schedule services for a specific date and time?",
        answer: "Absolutely! HAUSIFY allows you to schedule services for a date and time that aligns with your schedule and convenience."),
    FAQItem(
        question: "What should I do if I have a complaint or issue with a service provider?",
        answer: "We understand that issues can arise. If you encounter any problems with a service provider, please contact HAUSIFY's customer support. We are here to help and will assist you in resolving any concerns you may have."),
    FAQItem(
        question: "How are service prices determined on HAUSIFY?",
        answer: "Service prices on HAUSIFY are typically determined by the service providers themselves. You can review the pricing details for each service within the app, allowing you to make informed decisions."),
    FAQItem(
        question: "How do I become a service provider on HAUSIFY?",
        answer: "If you're interested in becoming a service provider on HAUSIFY, you can typically apply through the app. The registration process involves submitting your qualifications and relevant information for review."),
    FAQItem(
        question: "What is the cancellation policy on HAUSIFY?",
        answer: "The cancellation policy may vary depending on the specific service and the service provider. Detailed cancellation policies for each service can be found in the app."),
    FAQItem(
        question: "Is there a loyalty or referral program for HAUSIFY users?",
        answer: "HAUSIFY often offers loyalty rewards and referral programs for its users. These programs can provide you with discounts and benefits for being a loyal user and referring friends and family."),
    FAQItem(
        question: "How does HAUSIFY handle customer data and privacy?",
        answer: "HAUSIFY takes data privacy seriously. We follow strict data protection and privacy policies to ensure the security and confidentiality of customer information. You can find detailed information in the app's privacy policy section, which outlines our data handling practices and safeguards."),
    FAQItem(
        question: "What should I do if I forget my password or encounter login issues?",
        answer: "If you forget your password or encounter login issues, simply use the \"Forgot Password\" option to reset your password or contact HAUSIFY's customer support for prompt assistance."),
    FAQItem(
        question: "What safety measures are in place for both customers and service providers?",
        answer: "HAUSIFY prioritizes safety. Our safety measures include background checks, user verification, secure payment options, and other protocols to create a secure environment for both customers and service providers."),
    FAQItem(
        question: "Is there a rating and review system for service providers?",
        answer: "Yes, HAUSIFY has a rating and review system that allows users to rate and provide feedback on their experiences with service providers. This helps other users make informed decisions and ensures quality service."),

    // Add more FAQ items here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fragmentTopBar(topBarText: 'FAQs'),
          Expanded(
            child: ListView.builder(
              itemCount: faqItems.length,
              itemBuilder: (context, index) {
                return FAQItemWidget(item: faqItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({
    required this.question,
    required this.answer,
  });
}

class FAQItemWidget extends StatefulWidget {
  final FAQItem item;

  FAQItemWidget({required this.item});

  @override
  _FAQItemWidgetState createState() => _FAQItemWidgetState();
}

class _FAQItemWidgetState extends State<FAQItemWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.item.question,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            if (isExpanded)
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(widget.item.answer),
              ),
          ],
        ),
      ),
    );
  }
}