import 'package:familylost_faan/storage/db_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:sembast/utils/value_utils.dart';

class AppDatabase {
  DBRepository _base = DBRepository();

  AppDatabase();

  Future<void> prepareConfig() async {
    try {
      var localConfig = await this._base.get("localConfig");
      Map _localConfigEdit = cloneMap(localConfig);
      if (localConfig.isEmpty) {
        _localConfigEdit['firstStart'] = true;
      } else {
        _localConfigEdit['firstStart'] = false;
      }
      _base.set("localConfig", _localConfigEdit);
    } catch (e) {
      debugPrint("Error al preparar app config. " + e.toString());
    }
  }

  /// obtiene config de la db local
  Future<Map> getLocalConfig() async {
    try {
      return await _base.get("localConfig");
    } catch (e) {
      debugPrint(e.toString());
    }
    return {};
  }
}
