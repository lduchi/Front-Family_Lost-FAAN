import 'dart:async';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';

class DBRepository {
  DatabaseClient? _db;
  late StoreRef _store = StoreRef.main();

  /// Singleton pattern
  static final DBRepository _instance = DBRepository._internal();

  DBRepository._internal() {
    this.onInit();
  }

  factory DBRepository() => _instance;

  /// Default constructor
  void onInit() {
    this.initDB();
    this._store = StoreRef.main();
  }

  /// DB Instance
  Future<void> initDB() async {
    final _docDir = await getApplicationDocumentsDirectory();
    await _docDir.create(recursive: true);
    if (this._db == null) {
      this._db =
          await databaseFactoryIo.openDatabase(join(_docDir.path, 'db1.db'));
    }
  }

  dynamic getDB() => this._db;

  /// Add docs
  Future<void> set(String key, Map? value) async {
    if (value == null) {
      value = {}; //return;
    }
    await this._store.record(key).put(this._db!, value);
  }

  Future<void> setStr(String key, String value) async {
    await this._store.record(key).put(this._db!, value);
  }

  Future<void> setInt(String key, int value) async {
    await this._store.record(key).put(this._db!, value);
  }

  /// Retrieve docs
  Future<Map> get(String key) async {
    try {
      if (_db == null) {
        await initDB();
      }
      return await this._store.record(key).get(this._db!) as Map;
    } catch (e) {}
    return {};
  }

  Future<String> getStr(String key) async {
    return await this._store.record(key).get(this._db!) as String;
  }

  Future<int> getInt(String key) async {
    return await this._store.record(key).get(this._db!) as int;
  }

  /// Remove docs
  Future<String> del(String key) async {
    await this._store.record(key).delete(this._db!);
    return "";
  }
}
