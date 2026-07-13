import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {

    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  static Future<Database> _initDatabase() async {

    final dbPath = await getDatabasesPath();

    return openDatabase(

      join(dbPath, "medicare.db"),

      version: 3,

      onCreate: (db, version) async {

       await db.execute("""

CREATE TABLE booking(
  id INTEGER PRIMARY KEY AUTOINCREMENT,

  patient TEXT,
  complaint TEXT,

  doctor TEXT,
  speciality TEXT,
  image TEXT,
  location TEXT,
  rating TEXT,
  price TEXT,
  date TEXT,
  time TEXT,
  status TEXT
)

""");

      },

    );

  }

}