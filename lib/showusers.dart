import 'package:burtsbites/database.dart';
import 'package:burtsbites/models/user.dart';
import 'package:flutter/material.dart';

class ShowUsers extends StatefulWidget {
  const ShowUsers({Key? key}) : super(key: key);

  @override
  _ShowUsersState createState() => _ShowUsersState();
}

class _ShowUsersState extends State<ShowUsers> {
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
        title: Text('Show Users'),
      ),
      body: _usersList(),
    );
  }
                


  Widget _usersList() {
    return FutureBuilder(
      future: _databaseService.getUsers(),
      builder: (username, snapshot) {
        // return Container();
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (username, index) {
            User user = snapshot.data![index];
            return ListTile(
              title: Text(
                "${user.username}  ${user.firstName} ${user.lastName}",
              ),
            );
          },
        );
      },
    );
  }


}
