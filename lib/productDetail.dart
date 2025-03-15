import 'dart:ffi';

import 'package:burtsbites/models/product.dart';
import 'globals.dart' as globals;
import 'package:burtsbites/database.dart';
import 'package:flutter/material.dart';
import 'package:burtsbites/cart.dart';
import 'cartservices.dart'; // Import the file
import 'package:burtsbites/cart.dart';

class ProductDetail extends StatelessWidget {
  // final Product product;
  // const ProductDetail({Key? key, required this.product}) : super(key: key);
  Cart cart = Cart();
  Cartservices cartservices = Cartservices();

  final DatabaseService _databaseService = DatabaseService.instance;

  final String? imageName;
  final String? productName;
  final String? productDescription;
  final double? productPrice;
  final int? productID;

  // Constructor
  ProductDetail({this.imageName, this.productName, this.productDescription,this.productPrice,this.productID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Detail'),
        ),
        body: Column(
          children: [
            // Image.asset('assets/${product.productImage}'
            Image.asset('assets/$imageName'),
            Text('$productName'),
            Text('$productDescription'),
            MaterialButton(
              color: Colors.red,
              child: const Text("ADD TO CART",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold)),
              onPressed: () {
                print("Before run addCartItem");

                _databaseService.addCartItem(
                    globals.counter, productID!, '$productName', productPrice!,1 );
                // cartservices.addItemToCart(
                //     1, "prodname", 1.99, 1); // Call the function

                // cart.add
                globals.counter++; // Increases the counter
              },
            ),
            // MaterialButton(
            //   color: Colors.red,
            //   child: const Text("DISPLAY CART",
            //       style: TextStyle(
            //           color: Colors.white70, fontWeight: FontWeight.bold)),
            //   onPressed: () {
            //     print("Before run DisplayCart");

            //     // cartservices.displayCart(); // Call the function

            //     // cart.add
            //   },
            // ),
          ],
        ));
  }
}
