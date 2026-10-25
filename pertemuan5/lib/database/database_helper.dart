import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/app_user.dart';
import '../models/transaction_model.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _db;

  Future<Database> get database async {
    _db ??= await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final path = join(await getDatabasesPath(), 'expense_tracker.db');
    return openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL
          )
        ''');
        await db.execute('''
          CREATE TABLE transactions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER NOT NULL,
            title TEXT NOT NULL,
            amount INTEGER NOT NULL,
            category TEXT NOT NULL,
            type TEXT NOT NULL,
            date TEXT NOT NULL,
            FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  // ---------- USER ----------
  Future<int> registerUser(
      String name, String email, String passwordHash) async {
    final db = await database;
    return db.insert('users', {
      'name': name.trim(),
      'email': email.trim().toLowerCase(),
      'password': passwordHash,
    });
  }

  Future<AppUser?> getUserByEmail(String email) async {
    final db = await database;
    final rows = await db.query('users',
        where: 'email = ?', whereArgs: [email.trim().toLowerCase()], limit: 1);
    return rows.isEmpty ? null : AppUser.fromMap(rows.first);
  }

  Future<AppUser?> login(String email, String passwordHash) async {
    final db = await database;
    final rows = await db.query('users',
        where: 'email = ? AND password = ?',
        whereArgs: [email.trim().toLowerCase(), passwordHash],
        limit: 1);
    return rows.isEmpty ? null : AppUser.fromMap(rows.first);
  }

  Future<AppUser?> getUserById(int id) async {
    final db = await database;
    final rows =
        await db.query('users', where: 'id = ?', whereArgs: [id], limit: 1);
    return rows.isEmpty ? null : AppUser.fromMap(rows.first);
  }

  // ---------- TRANSAKSI ----------
  Future<int> insertTransaction(TransactionModel t) async {
    final db = await database;
    final map = t.toMap()..remove('id');
    return db.insert('transactions', map);
  }

  Future<int> deleteTransaction(int id) async {
    final db = await database;
    return db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TransactionModel>> getTransactions(int userId,
      {int? limit}) async {
    final db = await database;
    final rows = await db.query(
      'transactions',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'date DESC, id DESC',
      limit: limit,
    );
    return rows.map(TransactionModel.fromMap).toList();
  }

  /// Mengembalikan {'income': x, 'expense': y}
  Future<Map<String, int>> getTotals(int userId) async {
    final db = await database;
    final rows = await db.rawQuery(
      'SELECT type, SUM(amount) AS total FROM transactions WHERE user_id = ? GROUP BY type',
      [userId],
    );
    int income = 0;
    int expense = 0;
    for (final r in rows) {
      final total = (r['total'] as num?)?.toInt() ?? 0;
      if (r['type'] == 'income') {
        income = total;
      } else {
        expense = total;
      }
    }
    return {'income': income, 'expense': expense};
  }
}
