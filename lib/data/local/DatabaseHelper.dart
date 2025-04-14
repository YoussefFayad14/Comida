import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _db;

  // Get database instance
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  // Initialize database
  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_data.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(''' 
        CREATE TABLE orders (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          item_name TEXT NOT NULL,
          item_category TEXT Not NULL,
          image_path TEXT NOT NULL,
          quantity INTEGER  NULL,
        )
      ''');
    }
  }

  // Create tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
  }

  // Insert user
  Future<int> insertUser(String name, String email, String password) async {
    final db = await database;
    return await db.insert(
      'users',
      {'name': name, 'email': email, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update user
  Future<int> updateUser(String email, String password) async {
    final db = await database;
    return await db.update(
      'users',
      {'email': email, 'password': password},
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  // Get user
  Future<List<Map<String, dynamic>>> getUser(String email, String password) async {
    final db = await database;
    return await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
  }

  // Delete user
  Future<int> deleteUser(String email) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  // Insert order
  Future<int> insertOrder(String itemName,String itemCategory, String imagePath, int quantity) async {
    final db = await database;
    return await db.insert(
      'orders',
      {
        'item_name': itemName,
        'item_category': itemCategory,
        'image_path': imagePath,
        'quantity': quantity,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get orders by user
  Future<List<Map<String, dynamic>>> getOrdersByUser(int userId) async {
    final db = await database;
    return await db.query(
      'orders',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  // Delete order by id
  Future<int> deleteOrder(int orderId) async {
    final db = await database;
    return await db.delete(
      'orders',
      where: 'id = ?',
      whereArgs: [orderId],
    );
  }

  // Get all orders
  Future<List<Map<String, dynamic>>> getAllOrders() async {
    final db = await database;
    return await db.query('orders');
  }

}
