import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // use controller to show what user typed
  final _textController = TextEditingController();

  String userNameEntry = '';
  String greeting = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display text
              Expanded(
                child: Container(
                  child: Center(
                    child: Text('$greeting'),
                  ),
                ),
              ),

              TextField(
                controller: _textController,
                decoration: InputDecoration(
                    hintText: 'What is your name?',
                    border: OutlineInputBorder()),
              ),
              MaterialButton(
                onPressed: () {
                  // Update userName string with text box contents
                  setState(() {
                    userNameEntry = _textController.text;
                    greeting = 'Hello Hoser $userNameEntry';
                  });
                },
                color: Colors.blue,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )),
    );
  }
}
