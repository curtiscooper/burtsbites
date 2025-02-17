import 'package:burtsbites/database.dart';
import 'package:burtsbites/models/user.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // use controller to show what user typed

    final DatabaseService _databaseService = DatabaseService.instance;
  // final _textController = TextEditingController();

  String userNameEntry = '';
  String greeting = '';
  String? _username = null;
  String? _password = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: 
          Column(
            
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
              MaterialButton(
                onPressed: () {
                  // Update userName string with text box contents
                  setState(() {
                    // userNameEntry = _textController.text;
                    userNameEntry = _username! + " " + _password!;                    
                    greeting = 'Hello $userNameEntry';
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
                


  Widget _usersList() {
    return FutureBuilder(
      future: _databaseService.getUsers(),
      builder: (userName, snapshot) {
        // return Container();
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (userName, index) {
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
