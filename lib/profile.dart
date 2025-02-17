import 'dart:io';

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
  String? _avatar = 'blankprofile.jpg';

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
              Image.asset(
                'assets/$_avatar',
                width: 100,
                height: 100),                          
              TextField(
                onChanged: (value) {
                  setState(() {
                    _userid = int.parse(value);
                  });
                },
                // controller: _textController,
                decoration: InputDecoration(
                    hintText: 'User ID', border: OutlineInputBorder()),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _username = value;
                  });
                },
                // controller: _textController,
                decoration: InputDecoration(
                    hintText: 'Username', border: OutlineInputBorder()),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                // controller: _textController,
                decoration: InputDecoration(
                    hintText: 'Password', border: OutlineInputBorder()),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _firstname = value;
                  });
                },
                // controller: _textController,
                decoration: InputDecoration(
                    hintText: 'First Name', border: OutlineInputBorder()),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _lastname = value;
                  });
                },
                // controller: _textController,
                decoration: InputDecoration(
                    hintText: 'Last Name', border: OutlineInputBorder()),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _avatar = value;
                  });
                },
                // controller: _textController,
                decoration: InputDecoration(
                    hintText: 'Avatar', border: OutlineInputBorder()),
              ),
              MaterialButton(
                onPressed: () {
                  // Update userName string with text box contents
                  _databaseService.updateUser(_userid!, _username!, _firstname!,
                      _lastname!, _password!, _avatar!);
                  setState(() {
                    // userNameEntry = _textController.text;
                    // userNameEntry = _username! + " " + _password!;
                    // greeting = 'Hello $userNameEntry';
                  });
                },
                color: Colors.blue,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                  color: Colors.blue,
                  child: const Text("Pick Image from Gallery",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    pickImage();
                  }),
              MaterialButton(
                  color: Colors.blue,
                  // minWidth: 10,
                  // height: 10,
                  child: const Text("Pick Image from Camera",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    pickImageCamera();
                  }),
              MaterialButton(
                  color: Colors.blue,
                  child: const Text("My Orders",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyOrders()),
                    );
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
      future: _databaseService.getUser(_userid!),
      builder: (userName, snapshot) {
        // return Container();
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (userName, index) {
            User user = snapshot.data![index];
            return ListTile(
              title: Text(
                user.avatar,
              ),
            );
          },
        );
      },
    );
  }
}
