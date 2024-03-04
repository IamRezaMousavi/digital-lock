import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';

import './models.dart';

class MessagesDB {
  MessagesDB._privateConstructor();
  static final MessagesDB instance = MessagesDB._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, 'messages.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS messages (
        id INTEGER PRIMARY KEY,
        address TEXT,
        text TEXT,
        date INTEGER
      )
    ''');
  }

  Future<List<Message>> getMessages() async {
    Database db = await instance.database;
    // reverse messages list
    var messages = await db.query('messages', orderBy: 'date DESC');
    List<Message> messagesList = messages.isNotEmpty
        ? messages.map((e) => Message.fromMap(e)).toList()
        : [];
    return messagesList;
  }

  Future<int> add(Message message) async {
    Database db = await instance.database;
    return await db.insert('messages', message.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('messages', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Message message) async {
    Database db = await instance.database;
    return await db.update('messages', message.toMap(),
        where: 'id = ?', whereArgs: [message.id]);
  }
}

class UsersDB {
  UsersDB._privateConstructor();
  static final UsersDB instance = UsersDB._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, 'users.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        date INTEGER
      )
    ''');
  }

  Future<List<User>> getUsers() async {
    Database db = await instance.database;
    // reverse list
    var users = await db.query('users', orderBy: 'date DESC');
    List<User> usersList =
        users.isNotEmpty ? users.map((e) => User.fromMap(e)).toList() : [];
    return usersList;
  }

  Future<int> add(User user) async {
    Database db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(User user) async {
    Database db = await instance.database;
    return await db
        .update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }
}
