import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:myproject/models/model.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  static Database? _database;

  Future<Database> get database async => _database ??= await initDB();

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "UserDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE USER ("
            "id INTEGER PRIMARY KEY,"
            "name TEXT,"
            "gender TEXT,"
            "city TEXT,"
            "description TEXT,"
            "isLiked INTEGER"
            ")");
      },
    );
  }

  // get all users method
  Future<List<User>> getAllUsers({bool? isLiked}) async {
    final db = await database;
    List<Map> results ;
    if(isLiked != null && isLiked){
      results =  await db.query("User", columns: User.columns,where: "isLiked = ?",whereArgs: [1], orderBy: "id ASC");
    } else {
      results = await db.query("User", columns: User.columns, orderBy: "id ASC");
    }
    // await db.query("User", columns: User.columns, orderBy: "id ASC");
    List<User> users = [];
    for (var result in results) {
      User user = User.fromMap(result as Map<String, dynamic>);
      users.add(user);
    }
    return users;
  }

  //get user by id
  Future<User?> getUserById(int id) async {
    final db = await database;
    var result = await db.query("User", where: "id = ?", whereArgs: [id]);
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

  //insert user
  Future<int> insert(User user) async {
    final db = await database;
    var maxIdResult =
    await db.rawQuery("SELECT MAX(id+1) as last_inserted_id FROM User");
    var id = maxIdResult.first["last_inserted_id"];
    var result = await db.rawInsert(
      "INSERT into User (id, name, gender, city, description, isLiked) VALUES (?,?,?,?,?,?)",
      [id, user.name, user.gender, user.city, user.description, user.isLiked ? 1 : 0],
    );
    return result;
  }

  //update user
  update(User user) async {
    final db = await database;
    var result = await db
        .update("User", user.toMap(), where: "id = ?", whereArgs: [user.id]);
    return result;
  }

  //delete user
  delete(int id) async {
    final db = await database;
    db.delete("User", where: "id = ?", whereArgs: [id]);
  }

  //liked user
  Future<int> likedUser(User user) async {
    final db = await database;
    var result = await db.update("User", user.toMap(), where: "id = ?", whereArgs: [user.id]);
    // db.update("User", user.toMap(), where: "id = ?", whereArgs: [user.id]);
    return result;
  }
}