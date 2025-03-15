import 'dart:ffi';

import 'package:burtsbites/models/cartDataModel.dart';
import 'package:burtsbites/models/order.dart';
import 'package:burtsbites/models/ordersProducts.dart';
import 'package:burtsbites/models/product.dart';
import 'package:burtsbites/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseService {
  static Database? _db;

  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "ict4580-2.db");
    print(databasePath);
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
         CREATE TABLE users (
                userID INTEGER PRIMARY KEY,
                firstName char (15) NOT NULL,
                lastName char (15) NOT NULL,
                userName char (13) NOT NULL,
                password char (13) NOT NULL,
                avatar char
              )
         ''');
        db.execute('''
         CREATE TABLE products (
                productID INTEGER PRIMARY KEY NOT NULL,
                productName char (55) NOT NULL,
                productDesc char (255) NOT NULL,
                productPrice float NOT NULL,
                productImage char
                )
         ''');

        db.execute('''
         CREATE TABLE orders (
                orderID int primary key NOT NULL,
                userID int NOT NULL,
                orderDate char (11) NOT NULL,
                orderTotal float NOT NULL
               )
         ''');
        db.execute('''
         CREATE TABLE orderedProducts (
                orderedID int NOT NULL,
                orderID int NOT NULL,
                userID int NOT NULL,
                productID int NOT NULL
                )
         ''');
        // db.execute('''
        //   .database''');
      },
    );
    return database;
  }


  Future<List<CartDataModel>> getCart() async {
    final db = await database;
    final data = await db.query("cart");
    print(data);
    List<CartDataModel> cart = data
        .map((e) => CartDataModel(
            id: e["id"] as int,
            productID: e["productID"] as int,
            productName: e["productName"] as String,
            productPrice: e["productPrice"] as double,
            productQty: e["productQty"] as int))
        .toList();
    return cart;
  }

  void addCartItem(
    int id,
    int productID,
    String productName,
    double productPrice,
    int productQty,

  ) async {
    final db = await database;
    await db.insert(
      "cart",
      {
        "id": id,
        "productID": productID,
        "productName": productName,
        "productPrice": productPrice,
        "productQty": productQty,
      },
    );
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final data = await db.query("users");
    print(data);
    List<User> users = data
        .map((e) => User(
            userID: e["userID"] as int,
            userName: e["userName"] as String,
            firstName: e["firstName"] as String,
            lastName: e["lastName"] as String,
            password: e["password"] as String,
            avatar: e["avatar"] as String))
        .toList();
    return users;
  }

  void addUser(
    int userID,
    String username,
    String firstName,
    String lastName,
    String password,
    String avatar,
  ) async {
    final db = await database;
    await db.insert(
      "users",
      {
        "userID": userID,
        "userName": username,
        "firstName": firstName,
        "lastName": lastName,
        "password": password,
        "avatar": avatar,
      },
    );
  }

  void addProduct(
    int productID,
    String productName,
    String productDesc,
    double productPrice,
    String productImage,
  ) async {
    final db = await database;
    // db.execute('''
    //      ALTER TABLE users
    //      ADD avatar char
    //      ''');

    // db.execute('''
    //      DELETE from users where userID = 1
    //      ''');
    await db.insert(
      "products",
      {
        "productID": productID,
        "productName": productName,
        "productDesc": productDesc,
        "productPrice": productPrice,
        "productImage": productImage,
      },
    );
  }

  Future<List<Product>> getProducts() async {
    final db = await database;
    final data = await db.query("products");
    // print(data);
    List<Product> products = data
        .map((e) => Product(
            productID: e["productID"] as int,
            productName: e["productName"] as String,
            productDesc: e["productDesc"] as String,
            productPrice: e["productPrice"] as double,
            productImage: e["productImage"] as String))
        .toList();
    return products;
  }



  Future<List<Order>> getOrders(
    int? userID,
  ) async {
    print("USERID COMING INTO getOrders");
    // print(userID);
    final db = await database;
    final data = await db.query(
      "orders",
      where: 'userId = ?',
      whereArgs: [
        userID,
      ],
    );
    print("${userID}");
    print(data);
    List<Order> orders = data
        .map((e) => Order(
            orderID: e["orderID"] as int,
            userID: e["userID"] as int,
            orderDate: e["orderDate"] as String,
            orderTotal: e["orderTotal"] as double))
        .toList();
    return orders;
  }

  Future<List<OrdersProducts>> getOrdersProducts(
    int? userID,
  ) async {
    print("USERID COMING INTO getOrdersProducts");
    // print(userID);
    final db = await database;
    final data = await db.rawQuery(
        'select orders.userID, orders.orderID, orders.orderDate, orders.orderTotal, orderedProducts.productID, products.productName from orders inner join orderedProducts on orders.orderID = orderedProducts.orderID inner join products on products.productID = orderedProducts.productID where orders.userID = $userID');

    // final data = await db.query(
    //   "orders",
    //   where: 'userId = ?',
    //   whereArgs: [
    //     userID,
    //   ],
    // );
    
    print("${userID}");
    print(data);
    List<OrdersProducts> orders = data
        .map((e) => OrdersProducts(
            userID: e["userID"] as int,
            orderID: e["orderID"] as int,
            orderDate: e["orderDate"] as String,
            orderTotal: e["orderTotal"] as double,
            productID: e["productID"] as int,
            productName: e["productName"] as String            
            ))
        .toList();
    return orders;
  }



  Future<List<User>> getUser(
    int userID,
  ) async {
    final db = await database;
    final data = await db.query(
      "users",
      where: 'userID = ?',
      whereArgs: [
        userID,
      ],
    );
    // print(data);
    List<User> user = data
        .map((e) => User(
            userID: e["userID"] as int,
            userName: e["userName"] as String,
            firstName: e["firstName"] as String,
            lastName: e["lastName"] as String,
            password: e["password"] as String,
            avatar: e["avatar"] as String))
        .toList();
    return user;
  }

  void updateUser(int userID, String username, String firstName,
      String lastName, String password, String avatar) async {
    final db = await database;
    await db.update(
      "users",
      {
        "userID": userID,
        "userName": username,
        "firstName": firstName,
        "lastName": lastName,
        "password": password,
        "avatar": avatar,
      },
      where: 'userID = ?',
      whereArgs: [
        userID,
      ],
    );
  }

  Future close() async {
    final db = await database;
    db.close();
  }
  // Login Method

  Future<bool> login(User user) async {
    final db = await database;

    var result = await db.rawQuery(
        "select * from users where userName = '${user.userName}' AND password = '${user.password}'");

    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getUserID(User user) async {
    final db = await database;

    var result = await db.rawQuery(
        "select userid from users where userName = '${user.userName}' AND password = '${user.password}'");
    // print(result.first.values.first.toString());
    return result.first.values.first.toString();
  }

  void executeStatement(
      // int productID,
      // String productName,
      // String productDesc,
      // double productPrice,
      // String productImage,
      ) async {
    final db = await database;


        // db.execute('''
        //  CREATE TABLE cart (
        //         id INTEGER PRIMARY KEY,
        //         productID int NOT NULL,
        //         productName char (15) NOT NULL,
        //         productPrice float NOT NULL,
        //         productQty int NOT NULL
        //       )
        //  ''');




// db.execute('''insert into orderedProducts values(1, 6, 2, 1)''');

    // orders (orderId, userId, orderDate, orderTotal)

    // db.execute('''
    //      insert into orders values(1, 2, '02/01/2025', 99.99)
    //      ''');
    // db.execute('''
    //      insert into orders values(2, 2, '02/02/2025', 59.99)
    //      ''');
    // db.execute('''
    //      insert into orders values(3, 2, '02/03/2025', 69.99)
    //      ''');
    // db.execute('''
    //      insert into orders values(4, 2, '02/04/2025', 79.99)
    //      ''');


    // db.execute('''insert into orders values(5, 2, '02/05/2025', 49.99)''');

    // db.execute('''insert into orders values(6, 1, '02/01/2025', 54.49)''');
    // db.execute('''insert into orders values(7, 1, '02/02/2025', 59.49)''');
    // db.execute('''insert into orders values(8, 1, '02/03/2025', 69.49)''');

    // db.execute(
    //     '''insert into users values(1, 'Melissa', 'Cooper', 'mcooper', 'password', 'blankprofile.jpg')''');
    // db.execute(
    //     '''insert into users values(3, 'Kaylee', 'Cooper', 'kcooper', 'password', 'blankprofile.jpg')''');

    // db.execute('''insert into orders values(1, 1, 2, 1)''');
    // db.execute('''insert into orders values(2, 1, 2, 2)''');
    // db.execute('''insert into orders values(3, 1, 2, 3)''');

    // db.execute('''insert into orders values(4, 6, 1, 1)''');
    // db.execute('''insert into orders values(5, 6, 1, 2)''');
    // db.execute('''insert into orders values(6, 6, 1, 3)''');
    // orders (orderId, userId, orderDate, orderTotal)


//  orderedProducts (orderedID,orderID,userID,productID)

    // db.execute('''insert into orderedProducts values(1, 6, 2, 1)''');
    // db.execute('''insert into orderedProducts values(2, 6, 2, 2)''');
    // db.execute('''insert into orderedProducts values(3, 6, 2, 3)''');
    // db.execute('''insert into orderedProducts values(4, 1, 1, 1)''');
    // db.execute('''insert into orderedProducts values(5, 1, 1, 1)''');
    // db.execute('''insert into orderedProducts values(6, 1, 1, 1)''');
    // db.execute('''insert into orderedProducts values(7, 2, 1, 1)''');
    // db.execute('''insert into orderedProducts values(8, 2, 1, 2)''');
    // db.execute('''insert into orderedProducts values(9, 2, 1, 2)''');
    // db.execute('''insert into orderedProducts values(10, 7, 2, 2)''');
    // db.execute('''insert into orderedProducts values(11, 7, 2, 3)''');
    // db.execute('''insert into orderedProducts values(12, 1, 1, 3)''');
        


    // db.execute('''
    //      ALTER TABLE users
    //      ADD avatar char
    //      ''');

    // db.execute('''
    //      DELETE from cart where id = 1
    //      ''');

    // Delete ALL records from Cart
    db.execute('''
         DELETE from cart
         ''');         
  }
}
