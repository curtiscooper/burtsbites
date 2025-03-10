import 'dart:io';

import 'globals.dart' as globals;

import 'package:burtsbites/database.dart';
import 'package:burtsbites/models/user.dart';
import 'package:burtsbites/myorders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // use controller to show what user typed

  final DatabaseService _databaseService = DatabaseService.instance;
  // final _textController = TextEditingController();

  String? _username = null;
  int? _userid = 0;
  String? _firstname = null;
  String? _lastname = null;
  String? _password = null;
  String? _avatar = "blankprofile.jpg";

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display text
              // Expanded(
              //   child: Container(
              //     child: Center(
              //       child: Text('$greeting'),
              //     ),
              //   ),
              // ),
              // image != null ? Image.file(image!) : Text('No image selected')
              Expanded(
                child: _userList(),
              ),
              // Image.asset('assets/$_avatar', width: 100, height: 100),
              // Text(_firstname.toString()),

              // TextField(
              //   onChanged: (value) {
              //     setState(() {
              //       _userid = int.parse(value);
              //     });
              //   },
              //   // controller: _textController,
              //   decoration: InputDecoration(
              //       hintText: globals.userid.toString(),
              //       border: OutlineInputBorder()),
              // ),
              // TextField(
              //   onChanged: (value) {
              //     setState(() {
              //       _username = value;
              //     });
              //   },
              //   // controller: _textController,
              //   decoration: InputDecoration(
              //       hintText: 'Username', border: OutlineInputBorder()),
              // ),
              // TextField(
              //   onChanged: (value) {
              //     setState(() {
              //       _password = value;
              //     });
              //   },
              //   // controller: _textController,
              //   decoration: InputDecoration(
              //       hintText: 'Password', border: OutlineInputBorder()),
              // ),
              // TextField(
              //   onChanged: (value) {
              //     setState(() {
              //       _firstname = value;
              //     });
              //   },
              //   // controller: _textController,
              //   decoration: InputDecoration(
              //       hintText: 'First Name', border: OutlineInputBorder()),
              // ),
              // TextField(
              //   onChanged: (value) {
              //     setState(() {
              //       _lastname = value;
              //     });
              //   },
              //   // controller: _textController,
              //   decoration: InputDecoration(
              //       hintText: 'Last Name', border: OutlineInputBorder()),
              // ),
              // TextField(
              //   onChanged: (value) {
              //     setState(() {
              //       _avatar = value;
              //     });
              //   },
              //   // controller: _textController,
              //   decoration: InputDecoration(
              //       hintText: 'Avatar', border: OutlineInputBorder()),
              // ),
              // MaterialButton(
              //   onPressed: () {
              //     // Update userName string with text box contents
              //     _databaseService.updateUser(_userid!, _username!, _firstname!,
              //         _lastname!, _password!, _avatar!);
              //     setState(() {
              //       // userNameEntry = _textController.text;
              //       // userNameEntry = _username! + " " + _password!;
              //       // greeting = 'Hello $userNameEntry';
              //     });
              //   },
              //   color: Colors.blue,
              //   child: Text(
              //     'Submit',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
              MaterialButton(
                color: Colors.blue,
                child: const Text("Update Profile",
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                        title: const Text('Update Profile'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // TextField(
                            //   onChanged: (value) {
                            //     setState(() {
                            //       _userid = int.parse(value);
                            //     });
                            //   },
                            //   // controller: _textController,
                            //   decoration: InputDecoration(
                            //       hintText: globals.userid.toString(),
                            //       border: OutlineInputBorder()),
                            // ),
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  _username = value;
                                });
                              },
                              // controller: _textController,
                              decoration: InputDecoration(
                                  hintText: globals.username,
                                  border: OutlineInputBorder()),
                            ),
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  _password = value;
                                  globals.password = value;
                                  _username = globals.username;
                                  _userid = globals.userid;
                                  _firstname = globals.firstname;
                                  _lastname = globals.lastname;
                                  _avatar = globals.useravatar;
                                });
                              },
                              // controller: _textController,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  border: OutlineInputBorder()),
                            ),
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  _firstname = value;
                                  globals.firstname = value;
                                  _username = globals.username;
                                  _userid = globals.userid;
                                  _lastname = globals.lastname;
                                  _password = globals.password;
                                  _avatar = globals.useravatar;
                                });
                              },
                              // controller: _textController,
                              decoration: InputDecoration(
                                  hintText: globals.firstname,
                                  border: OutlineInputBorder()),
                            ),
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  _lastname = value;
                                  globals.lastname = value;
                                  _username = globals.username;
                                  _userid = globals.userid;
                                  _firstname = globals.firstname;
                                  _password = globals.password;
                                  _avatar = globals.useravatar;
                                });
                              },
                              // controller: _textController,
                              decoration: InputDecoration(
                                  hintText: globals.lastname,
                                  border: OutlineInputBorder()),
                            ),
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  _avatar = value;
                                  globals.useravatar = value;
                                  _username = globals.username;
                                  _userid = globals.userid;
                                  _firstname = globals.firstname;
                                  _lastname = globals.lastname;
                                  _password = globals.password;
                                });
                              },
                              // controller: _textController,
                              decoration: InputDecoration(
                                  hintText: globals.useravatar,
                                  border: OutlineInputBorder()),
                            ),
                            MaterialButton(
                                color: Colors.blue,
                                child: const Text(
                                    "Change Avatar Image from Gallery",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  pickImage();
                                }),
                            MaterialButton(
                                color: Colors.blue,
                                // minWidth: 10,
                                // height: 10,
                                child: const Text(
                                    "Change Avatar Image from Camera",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  pickImageCamera();
                                }),
                            MaterialButton(
                              onPressed: () {
                                // Update userName string with text box contents
                                print(_firstname);
                                _databaseService.updateUser(
                                    globals.userid!,
                                    _username!,
                                    _firstname!,
                                    _lastname!,
                                    _password!,
                                    _avatar!);
                                setState(() {
                                  // userNameEntry = _textController.text;
                                  // userNameEntry = _username! + " " + _password!;
                                  // greeting = 'Hello $userNameEntry';
                                });
                                Navigator.pop(
                                  context,
                                );
                              },
                              color: Colors.blue,
                              child: Text(
                                'UPDATE',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              ),

              MaterialButton(
                color: Colors.blue,
                child: const Text("My Orders",
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold)),
                onPressed: () {
                  print("${globals.username}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyOrders(
                              useridin: globals.userid.toString(),
                            )),
                  );
                },
              ),

              MaterialButton(
                color: Colors.red,
                child: const Text("DB Execute",
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold)),
                onPressed: () {
                  _databaseService.executeStatement();
                },
              ),
              // SizedBox(
              //   height: 30,
              // ),
            ],
          )),
    );
  }

  Widget _userList() {
    return FutureBuilder(
      future: _databaseService.getUser(globals.userid!),
      builder: (userName, snapshot) {
        // return Container();
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (userName, index) {
            User user = snapshot.data![index];

            globals.useravatar = user.avatar;
            globals.firstname = user.firstName;
            globals.lastname = user.lastName;
            globals.userid = user.userID;
            globals.password = user.avatar;

            return ListTile(
              title: Text("${user.userName}"),
              subtitle: Text("${user.firstName} ${user.lastName}"),
              leading: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('assets/${user.avatar}',
                    width: 300, height: 300),
              ),
            );
          },
        );
      },
    );
  }
}
