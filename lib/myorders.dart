import 'package:burtsbites/database.dart';
import 'package:burtsbites/models/ordersProducts.dart';
import 'globals.dart' as globals;
import 'package:burtsbites/models/order.dart';
import 'package:burtsbites/models/user.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  // const MyOrders({Key? key}) : super(key: key);

  final String? useridin;
  
  // Constructor
  MyOrders({this.useridin});

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  // use controller to show what user typed

  final DatabaseService _databaseService = DatabaseService.instance;
  // final _textController = TextEditingController();

  // String userNameEntry = '';
  // String greeting = '';
  // String? _username = null;
  // String? _password = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.asset('assets/ChefBraad.jpeg', width: 100, height: 100),

            Text(
              "UserID: ${widget.useridin}"
               ?? 'No userid',
              style:
                  TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),            

            // Text(
            //   'My Orders',
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            Expanded(
              child: _orderList(),
            ),
          ],
        ),
      ),
      // body: Container(child: _orderList()),
    );
  }

  // Widget _orderList() {
  //   return FutureBuilder(
  //     future: _databaseService.getOrders(globals.userid),
  //     builder: (userName, snapshot) {
  //       // return Container();
  //       return ListView.builder(
  //         itemCount: snapshot.data?.length ?? 0,
  //         itemBuilder: (username, index) {
  //           Order order = snapshot.data![index];
  //           return ListTile(
  //             title: Text(
  //               "${order.orderDate}  ${order.orderID} ${order.orderTotal}",
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }



  

  Widget _orderList() {
    return FutureBuilder(
      future: _databaseService.getOrdersProducts(globals.userid),
      builder: (productName, snapshot) {
        // return Container();
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (productName, index) {
            OrdersProducts orderProducts = snapshot.data![index];
            return ListTile(
              title: Text(
                "${orderProducts.orderDate}  ${orderProducts.orderID} ${orderProducts.orderTotal} ${orderProducts.productID} ${orderProducts.productName}",
              ),
            );
          },
        );
      },
    );
  }

}
