import 'dart:io';

import 'package:burtsbites/cart.dart';
import 'package:burtsbites/createAccount.dart';
import 'package:burtsbites/giftcard.dart';
import 'package:burtsbites/login.dart';
import 'package:burtsbites/loginscreen.dart';
import 'package:burtsbites/products.dart';
import 'package:burtsbites/profile.dart';
import 'package:burtsbites/showusers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class  HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        title: Text("GFG Slider"),
      ),
      body: ListView(
        children: [
          CarouselSlider(
              items: [
                
                //1st Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage("https://plus.unsplash.com/premium_photo-1669742928112-19364a33b530?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZGVsaWNpb3VzJTIwZm9vZHxlbnwwfHwwfHx8MA%3D%3D"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                //2nd Image of Slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage("https://media.istockphoto.com/id/1206323282/photo/juicy-hamburger-on-white-background.webp?a=1&b=1&s=612x612&w=0&k=20&c=2BLwdPMO_VyOaPaOXx3X3Q1lSaXXunhCf8VfBkhvAWw="),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // //3rd Image of Slider
                // Container(
                //   margin: EdgeInsets.all(6.0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8.0),
                //     image: DecorationImage(
                //       image: NetworkImage("ADD IMAGE URL HERE"),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                
                // //4th Image of Slider
                // Container(
                //   margin: EdgeInsets.all(6.0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8.0),
                //     image: DecorationImage(
                //       image: NetworkImage("ADD IMAGE URL HERE"),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                
                // //5th Image of Slider
                // Container(
                //   margin: EdgeInsets.all(6.0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8.0),
                //     image: DecorationImage(
                //       image: NetworkImage("ADD IMAGE URL HERE"),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),

          ],
            
            //Slider Container properties
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
          ),
        ],
      ),

    );
  }
}
void main() => runApp(MyApp());
// class User {
//   final int? id;
//   final String name;
//   final int age;
//   final String country;
//   final String? email;

//   User(
//       { this.id,
//       required this.name,
//       required this.age,
//       required this.country,
//       this.email});

//   User.fromMap(Map<String, dynamic> res)
//       : id = res["id"],
//         name = res["name"],
//         age = res["age"],
//         country = res["country"],
//         email = res["email"];

//   Map<String, Object?> toMap() {
//     return {'id':id,'name': name, 'age': age, 'country': country, 'email': email};
//   }
// }

// var db = openDatabase('userdata.db');

// WidgetsFlutterBinding.ensureInitialized();
// // Open the database and store the reference.
// final database = openDatabase(
//   // Set the path to the database. Note: Using the `join` function from the
//   // `path` package is best practice to ensure the path is correctly
//   // constructed for each platform.
//   join(await getDatabasesPath(), 'userdata.db'),
// );

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Burts Bites',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Burts Bites'),
//     );
//   }
// }



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Burts Bites',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Burts Bites'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeScreen(),
    ProductsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Burts Bites'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.favorite), text: 'Products'),
              Tab(icon: Icon(Icons.person), text: 'Profile'),
            ],
          ),
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ),
    );
  }
}

// class _MyHomePageState extends State<MyHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     final DeviceOrientation = MediaQuery.of(context).orientation;
//     print(DeviceOrientation);
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Burts Bites"),
//         ),
//         body: Center(
//             child: DeviceOrientation == Orientation.portrait
//                 ? displayPortrait()
//                 : displayLandscape()));
//   }
// }

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DeviceOrientation = MediaQuery.of(context).orientation;
    print(DeviceOrientation);
    return Scaffold(
        appBar: AppBar(
          // title: const Text("Burts Bites"),
        ),
        body: Center(
            child: DeviceOrientation == Orientation.portrait
                ? displayPortrait()
                : displayLandscape()));
  }
}

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          // title: const Text("Burts Bites"),
        ),
        body: Center(
            child: 
        MaterialButton(
          color: Colors.blue,
          child: const Text("Products",
              style: TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Products()),
            );
          },
        ),            
        )
      );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
            children:[
              SizedBox(
                height: 30,
              ),
              // image != null ? Image.file(image!) : Text('No image selected'),

              MaterialButton(
                color: Colors.blue,
                child: const Text("Login",
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
              MaterialButton(
                color: Colors.blue,
                child: const Text("Create Account",
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateAccount()),
                  );
                },
              ),
              MaterialButton(
                color: Colors.blue,
                child: const Text("Show Users",
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowUsers()),
                  );
                },
              ),

              MaterialButton(
                color: Colors.blue,
                child: const Text("My Profile",
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                },
              ),      
            ]
        ), 
      
      )
    );
  }
}

class displayPortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // MaterialButton(
        //     color: Colors.blue,
        //     child: const Text("Pick Image from Gallery",
        //         style: TextStyle(
        //             color: Colors.white70, fontWeight: FontWeight.bold)),
        //     onPressed: () {
        //       pickImage();
        //     }),
        // MaterialButton(
        //     color: Colors.blue,
        //     child: const Text("Pick Image from Camera",
        //         style: TextStyle(
        //             color: Colors.white70, fontWeight: FontWeight.bold)),
        //     onPressed: () {
        //       pickImageCamera();
        //     }),
        SizedBox(
          height: 30,
        ),
        // image != null ? Image.file(image!) : Text('No image selected'),

MaterialApp(
      debugShowCheckedModeBanner: false,
      
      // Title of App
      title: 'GFG slider',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData.dark(),
      
      //First Screen of Slider App
      home: HomePage(),
    ),

        MaterialButton(
          color: Colors.blue,
          child: const Text("Show Users",
              style: TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShowUsers()),
            );
          },
        ),


        MaterialButton(
          color: Colors.blue,
          child: const Text("Cart",
              style: TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cart()),
            );
          },
        ),




        MaterialButton(
          color: Colors.blue,
          child: const Text("Get your gift card",
              style: TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.bold)),
          onPressed: () async {
            final url = 'http://192.168.50.85/ict4580/registration.html';

              await launchUrlString(url);
          },
        ),


        MaterialButton(
          color: Colors.blue,
          child: const Text("Call Customer Support",
              style: TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.bold)),
          onPressed: () async {
            final url = 'tel:910-555-1212';

              await launchUrlString(url);
          },
        ),


      ], // Children
    );
  }
}



class displayLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // MaterialButton(
        //     color: Colors.blue,
        //     child: const Text("Pick Image from Gallery",
        //         style: TextStyle(
        //             color: Colors.white70, fontWeight: FontWeight.bold)),
        //     onPressed: () {
        //       pickImage();
        //     }),
        // MaterialButton(
        //     color: Colors.blue,
        //     child: const Text("Pick Image from Camera",
        //         style: TextStyle(
        //             color: Colors.white70, fontWeight: FontWeight.bold)),
        //     onPressed: () {
        //       pickImageCamera();
        //     }),
        SizedBox(
          height: 30,
        ),
        // image != null ? Image.file(image!) : Text('No image selected'),

        MaterialButton(
          color: Colors.blue,
          child: const Text("Login",
              style: TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
        ),
        MaterialButton(
          color: Colors.blue,
          child: const Text("Products",
              style: TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Products()),
            );
          },
        ),
        MaterialButton(
          color: Colors.blue,
          child: const Text("Create Account",
              style: TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateAccount()),
            );
          },
        ),
        MaterialButton(
          color: Colors.blue,
          child: const Text("Show Users",
              style: TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShowUsers()),
            );
          },
        ),

        MaterialButton(
          color: Colors.blue,
          child: const Text("My Profile",
              style: TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
          },
        ),

        MaterialButton(
          color: Colors.blue,
          child: const Text("Cart",
              style: TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cart()),
            );
          },
        ),        
      ],
    );
  }
}
