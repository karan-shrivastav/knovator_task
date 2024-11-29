import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:knovator_task/models/post_model.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  factory LocalDatabase() => _instance;
  static Database? _database;

  LocalDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'posts.db');
    return openDatabase(path, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE posts(
          userId INTEGER,
          id INTEGER PRIMARY KEY,
          title TEXT,
          body TEXT
        )
      ''');
    }, version: 1);
  }

  Future<void> insertPost(PostModel post) async {
    final db = await database;
    await db.insert(
      'posts',
      post.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PostModel>> getPosts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('posts');
    return List.generate(maps.length, (i) {
      return PostModel.fromJson(maps[i]);
    });
  }
}
