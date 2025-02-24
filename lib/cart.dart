import 'package:burtsbites/database.dart';
import 'package:burtsbites/models/user.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  // use controller to show what user typed

  final DatabaseService _databaseService = DatabaseService.instance;
  // final _textController = TextEditingController();

  // String userNameEntry = '';
  // String greeting = '';
  // String? _username = null;
  // String? _password = null;
  String? _avatar = 'blankprofile.jpg';

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
            Image.asset('assets/$_avatar', width: 100, height: 100),
            Text(
              'Users',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: _usersList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _usersList() {
    return FutureBuilder(
      future: _databaseService.getUsers(),
      builder: (userName, snapshot) {
        // return Container();
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (username, index) {
            User user = snapshot.data![index];
            _avatar = user.avatar;
            
            return ListTile(
              title: Text(
                "${user.userName}  ${user.firstName} ${user.lastName}",
              ),
            );
          },
        );
      },
    );
  }
}
