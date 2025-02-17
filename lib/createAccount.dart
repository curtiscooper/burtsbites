import 'dart:ffi';

import 'package:burtsbites/database.dart';
import 'package:flutter/material.dart';
import 'package:burtsbites/models/user.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  // use controller to show what user typed
  // final _textController = TextEditingController();

  String userNameEntry = '';
  String greeting = '';

  final DatabaseService _databaseService = DatabaseService.instance;

  String? _username = null;
  int? _userid = 0;
  String? _firstname = null;
  String? _lastname = null;
  String? _password = null;
  String? _avatar = "none";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _addUserButton(),
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: _usersList(),
      // Padding(
      //   padding: const EdgeInsets.all(5.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }

  Widget _addUserButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
              title: const Text('Add User'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _userid = int.parse(value);
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'UserID', border: OutlineInputBorder()),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _username = value;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Username', border: OutlineInputBorder()),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _firstname = value;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'First Name', border: OutlineInputBorder()),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _lastname = value;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Last Name', border: OutlineInputBorder()),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Password', border: OutlineInputBorder()),
                  ),
                  MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        if (_username == null || _username == "") return;
                        _databaseService.addUser(_userid!, _username!,
                            _firstname!, _lastname!, _password!, _avatar!);
                        setState(
                          () {
                            _username = null;
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

  Widget _usersList() {
    return FutureBuilder(
      future: _databaseService.getUsers(),
      builder: (userName, snapshot) {
        // return Container();
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (username, index) {
            User user = snapshot.data![index];
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
