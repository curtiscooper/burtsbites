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
    final databasePath = join(databaseDirPath, "ict4580.db");
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
                password char (13) NOT NULL
              )
         ''');
        db.execute('''
         CREATE TABLE products (
                productID INTEGER PRIMARY KEY NOT NULL,
                productName char (55) NOT NULL,
                productDesc char (255) NOT NULL,
                productPrice float NOT NULL
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
      },
    );
  }

  void addProduct(
    int productID,
    String productName,
    String productDesc,
    double productPrice,
  ) async {
    final db = await database;
    await db.insert(
      "products",
      {
        "productID": productID,
        "productName": productName,
        "productDesc": productDesc,
        "productPrice": productPrice,
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
            productPrice: e["productPrice"] as double))
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
            username: e["username"] as String,
            firstName: e["firstName"] as String,
            lastName: e["lastName"] as String,
            password: e["password"] as String))
        .toList();
    return users;
  }
}
