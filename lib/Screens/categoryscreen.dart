import 'package:flutter/material.dart';
import 'package:urbanserv/utils/constants.dart';
import 'package:urbanserv/utils/service.dart';
import 'package:urbanserv/Screens/cartscreen.dart';

class ServiceCard extends StatefulWidget {
  final Service service;
  final VoidCallback addToCart;
  final VoidCallback removeFromCart;
  final VoidCallback toggleWishlist;
  final bool isAddedToCart;
  final bool isWishlist;

  ServiceCard({
    required this.service,
    required this.addToCart,
    required this.removeFromCart,
    required this.toggleWishlist,
    required this.isAddedToCart,
    required this.isWishlist,
  });

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isInCart = false;
  bool _isWishlist = false; // New

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F6F4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(widget.service.imageURL),
                fit: BoxFit.cover,

              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.service.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isInCart = !_isInCart;
                    });
                    if (_isInCart) {
                      widget.addToCart();
                    }
                  },
                  child: Text(_isInCart ? 'Remove from Cart' : 'Add to Cart'),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              widget.isWishlist ? Icons.favorite : Icons.favorite_border,
              color: widget.isWishlist ? Colors.red : null,
            ),
            onPressed: widget.toggleWishlist,
          ),
        ],
      ),
    );
  }
}

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Service> services = [
    Service('Cleaning', 'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Plumber', 'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-plumber-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Electrician', 'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-multimeter-car-service-wanicon-flat-wanicon.png'),
    Service('Painter', 'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-painter-male-occupation-avatar-itim2101-flat-itim2101.png'),
    Service('Carpenter', 'https://img.icons8.com/fluency/2x/drill.png'),
    Service('Gardener', 'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-gardener-male-occupation-avatar-itim2101-flat-itim2101.png'),
    Service('Tailor', 'https://img.icons8.com/fluency/2x/sewing-machine.png'),
    Service('Maid', 'https://img.icons8.com/color/2x/housekeeper-female.png'),
    Service('Driver', 'https://img.icons8.com/external-sbts2018-lineal-color-sbts2018/2x/external-driver-women-profession-sbts2018-lineal-color-sbts2018.png'),
  ];

  List<Service> cartItems = [];
  Set<Service> wishlistItems = Set<Service>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Services',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFEAF6F6),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the home screen
            Navigator.pushReplacementNamed(context, '/homescreen');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cartItems: cartItems),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) {
            final isServiceInCart = cartItems.contains(services[index]);
            final isServiceInWishlist = wishlistItems.contains(services[index]);

            return ServiceCard(
              service: services[index],
              addToCart: () {
                setState(() {
                  if (!isServiceInCart) {
                    cartItems.add(services[index]);
                  } else {
                    cartItems.remove(services[index]);
                  }
                });
              },
              removeFromCart: () {
                setState(() {
                  cartItems.remove(services[index]);
                });
              },
              toggleWishlist: () {
                setState(() {
                  if (!isServiceInWishlist) {
                    wishlistItems.add(services[index]);
                  } else {
                    wishlistItems.remove(services[index]);
                  }
                });
              },
              isAddedToCart: isServiceInCart,
              isWishlist: isServiceInWishlist,
            );
          },
        ),
      ),
    );
  }
}