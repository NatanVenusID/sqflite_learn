import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_app/model/model_pegawai.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  static Database _database;

  final String tablePegawai = 'noteTable';
  final String columId = 'id';
  final String columnFirstName = 'firstname';
  final String columnLastName = 'lastname';
  final String columnMobileNo = 'mobileno';
  final String columnEmailId = 'emailid';

  DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'pegawai.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tablePegawai($columId INTEGER PRIMARY KEY, "
        "$columnFirstName TEXT, "
        "$columnLastName TEXT,"
        "$columnMobileNo TEXT, "
        "$columnEmailId TEXT)";
    await db.execute(sql);
  }

//Save Pegawai
  Future<int> savePegawai(ModelPegawai pegawai) async {
    var dbClient = await db;
    var result = await dbClient.insert(tablePegawai, pegawai.toMap());
    return result;
  }

//Get All Pegawai
  Future<List> getAllPegawai() async {
    var dbClient = await db;
    var result = await dbClient.query(tablePegawai, columns: [
      columId,
      columnFirstName,
      columnLastName,
      columnMobileNo,
      columnEmailId
    ]);
    return result.toList();
  }

//Update Pegawai
  Future<int> updatePegawai(ModelPegawai pegawai) async {
    var dbClient = await db;
    return await dbClient.update(tablePegawai, pegawai.toMap(),
        where: "$columId = ?", whereArgs: [pegawai.id]);
  }

//Delete Pegawai
  Future<int> deletePegawai(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tablePegawai, where: "$columId = ?", whereArgs: [id]);
  }
}
