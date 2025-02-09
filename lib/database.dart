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
}
