import 'package:flutter/material.dart';
import 'package:urbanserv/utils/constants.dart';
import 'package:urbanserv/utils/service.dart';

class CartScreen extends StatefulWidget {
  final List<Service> cartItems;

  CartScreen({required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void removeFromCart(Service service) {
    setState(() {
      widget.cartItems.remove(service);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: kHeadingFontStyle.copyWith(
            fontSize: 24.0
          ),
        ),
        backgroundColor: const Color(0xFFEAF6F6),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    // Service Image
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(widget.cartItems[index].imageURL),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Service Name
                          Text(
                            widget.cartItems[index].name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Service Price (Assuming service has a price attribute)
                          const Text(
                            //'Price: \$${widget.cartItems[index].price.toString()}',
                            'Price :',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Remove Icon
                    IconButton(
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        removeFromCart(widget.cartItems[index]);
                      },
                    ),
                    Text(
                      'Remove',
                      style: kContentFontStyle.copyWith(
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
