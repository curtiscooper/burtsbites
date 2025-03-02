import 'package:burtsbites/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  // final Product product;
  // const ProductDetail({Key? key, required this.product}) : super(key: key);

  final String? imageName;
  final String? productName;
  final String? productDescription;

  // Constructor
  ProductDetail({this.imageName, this.productName, this.productDescription});

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
          ],
        ));
  }
}
