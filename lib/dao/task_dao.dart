import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/task.dart';

class TareaDAO {
  static final TareaDAO _instance = TareaDAO._();

  factory TareaDAO() => _instance;

  TareaDAO._() {
    _initDB();
  }

  Database? _db=null;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initDB();
    }
    return _db;
  }

  Future<Database> _initDB() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'tareas.db');

    return await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE tareas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT,
            descripcion TEXT,
            fecha_creacion TEXT,
            estatus TEXT,
            fecha_termino TEXT,
            imagen TEXT
          )
        ''');
    });
  }

  Future<int?> insert(Tarea tarea) async {
    final db = await this.db;
    return await db?.insert('tareas', tarea.toMap());
  }

  Future<int> update(Tarea tarea) async {
    final db = await this.db;
    return await db!.update('tareas', tarea.toMap(),
        where: 'id = ?', whereArgs: [tarea.id]);
  }

  Future<int> delete(int id) async {
    final db = await this.db;
    return await db!.delete('tareas', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Tarea>> getAll() async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db!.query('tareas');
    return List.generate(maps.length, (i) {
      return Tarea.fromMap(maps[i]);
    });
  }

  Future<List<Tarea>> getAllByStatus(String estatus) async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db!.query('tareas', where: 'estatus = ?', whereArgs: [estatus]);
    return List.generate(maps.length, (i) {
      return Tarea.fromMap(maps[i]);
    });
  }

  Future<Tarea?> getById(int id) async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps =
        await db!.query('tareas', where: 'id = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return Tarea.fromMap(maps.first);
    }
    return null;
  }
}
