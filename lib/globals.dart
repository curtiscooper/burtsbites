library my_prj.globals;

import 'dart:ffi';

bool isLoggedIn = true;

String? username;
int? userid;
String? useravatar;
String? firstname;
String? lastname;
String? password;
int counter = 1;

void greetUser(String name) {
  print("Hello, $name!");
}
