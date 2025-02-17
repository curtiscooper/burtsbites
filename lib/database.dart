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
    print(data);
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

  Future<List<User>> getUser(int userID,) async {
    final db = await database;
    final data = await db.query("users",
          where: 'userID = ?',
            whereArgs: [
              userID,
            ],);
    print(data);
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

  void updateUser(int userID, String username, String firstName, String lastName,
      String password, String avatar) async {
    final db = await database;
    await db.update(
      "users", {
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
}
