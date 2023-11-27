import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/scan_model.dart';

class DBProvider {
  static Database? _database;
  static final db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database as Database;
    return await initDB();
  }

  Future<Database> initDB() async {
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // final path = join(documentsDirectory.path, 'ScansDB.db');

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          )
          ''');
      },
    );
  }

  newScan(ScanModel scanModel) async {
    final db = await database;
    final scan = await db.insert('Scans', scanModel.toJson());
    return scan;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id == ?', whereArgs: [id]);

    if (res.isNotEmpty) return ScanModel.fromJson(res.first);
    return null;
  }

  Future<List<ScanModel>?> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');

    if (res.isNotEmpty) return res.map((e) => ScanModel.fromJson(e)).toList();
    return [];
  }

  Future<List<ScanModel>?> getScansByType(String type) async {
    final db = await database;
    final res = await db.query('Scans', where: 'type == ?', whereArgs: [type]);

    if (res.isNotEmpty) return res.map((e) => ScanModel.fromJson(e)).toList();
    return [];
  }

  Future<int> updateScan(ScanModel scanToUpdate) async {
    final db = await database;
    final res = await db.update('Scans', scanToUpdate.toJson(),
        where: 'id == ?', whereArgs: [scanToUpdate.id]);
    return res;
  }

  Future<int> deleteScanById(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id == ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }
}
