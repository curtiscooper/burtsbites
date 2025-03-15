import 'package:burtsbites/database.dart';
import 'package:burtsbites/models/cartDataModel.dart';
import 'package:burtsbites/models/user.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
// import 'cartservices.dart'; // Import the file

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  // use controller to show what user typed

  final DatabaseService _databaseService = DatabaseService.instance;
  // final _textController = TextEditingController();

  // static List<cartItem = "Item1";

  // final cartData = [
  //   CartDataModel(id: 1, productID: 1, productName: "Product 1", productPrice: 1.99),
  //   CartDataModel(id: 2, productID: 2, productName: "Product 2", productPrice: 2.99)
  // ];
  // var idCounter = 1;

  // final List<CartDataModel> CartDataList = List.generate(
  //     1,
  //     (index) => CartDataModel(
  //         id: index, productID: 1, productName: 'ITEM 1', productPrice: 11.99));



  // void addItemToCart(int prodid, String prodname, double prodprice) {
  //   idCounter = idCounter++;
  //   CartDataList.add(CartDataModel(
  //       id: 1,
  //       productID: prodid,
  //       productName: prodname,
  //       productPrice: prodprice));

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.asset('assets/$_avatar', width: 100, height: 100),
            // Text(
            //   'Users',
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            Expanded(
              child: _cartList(),
            ),
            MaterialButton(
              color: Colors.red,
              child: const Text("CHECKOUT",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold)),
              onPressed: () {
                print("Before run CHECKOUT");

                // cartservices.displayCart(); // Call the function

                // cart.add
              },
            ),            
          ],
        ),
      ),
    );
  }

  Widget _cartList() {
    return FutureBuilder(
      future: _databaseService.getCart(),
      builder: (context, snapshot) {
        // return Container();
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            CartDataModel cart = snapshot.data![index];

            return ListTile(
              title: Text(
                "${cart.productID}  ${cart.productQty} ${cart.productName} ${cart.productPrice}",
              ),
            );
          },
        );
      },
    );
  }
}
