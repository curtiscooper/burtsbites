import 'dart:ffi';

import 'package:burtsbites/database.dart';
import 'package:burtsbites/models/product.dart';
import 'package:flutter/material.dart';


class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  // use controller to show what user typed

  final DatabaseService _databaseService = DatabaseService.instance;

  int? _productid = 0;
  String? _productname = null;
  String? _productdesc = null;
  double? _productprice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _addProductsButton(),
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: _productsList(),
      // Padding(
      //     padding: const EdgeInsets.all(5.0),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      // children: [
      //   TextField(
      //     controller: _textController,
      //     decoration: InputDecoration(
      //         hintText: 'Username', border: OutlineInputBorder()),
      //   ),
      //   TextField(
      //     controller: _textController,
      //     decoration: InputDecoration(
      //         hintText: 'First Name', border: OutlineInputBorder()),
      //   ),
      //   TextField(
      //     controller: _textController,
      //     decoration: InputDecoration(
      //         hintText: 'Last Name', border: OutlineInputBorder()),
      //   ),
      //   TextField(
      //     controller: _textController,
      //     decoration: InputDecoration(
      //         hintText: 'Password', border: OutlineInputBorder()),
      //   ),
      //   MaterialButton(
      //     onPressed: () {
      //       // Add user info to database
      //     },
      //     color: Colors.blue,
      //     child: Text(
      //       'Submit',
      //       style: TextStyle(color: Colors.white),
      //     ),
      //   ),
      // ],
      //       )),
    );
  }

  Widget _addProductsButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
              title: const Text('Add Product'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _productid = int.parse(value);
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'ProductID', border: OutlineInputBorder()),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _productname = value;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Product Name', border: OutlineInputBorder()),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _productdesc = value;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Product Description',
                        border: OutlineInputBorder()),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _productprice = double.parse(value);
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Product Price',
                        border: OutlineInputBorder()),
                  ),
                  MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        if (_productname == null || _productname == "") return;
                        _databaseService.addProduct(_productid!, _productname!,
                            _productdesc!, _productprice!);
                        setState(
                          () {
                            _productname = null;
                          },
                        );
                        Navigator.pop(
                          context,
                        );
                      },
                      child: const Text("Done",
                          style: TextStyle(
                            color: Colors.white,
                          ))),
                ],
              )),
        );
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }

  Widget _productsList() {
    return FutureBuilder(
      future: _databaseService.getProducts(),
      builder: (productName, snapshot) {
        // return Container();
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (productName, index) {
            Product product = snapshot.data![index];
            return ListTile(
              title: Text(
                "${product.productName}  ${product.productPrice}",
              ),
            );
          },
        );
      },
    );
  }
}
