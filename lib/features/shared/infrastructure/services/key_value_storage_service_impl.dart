import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future<SharedPreferences> getSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();
    
    if (T == int) return prefs.getInt(key) as T?;
  
    if (T == String) return prefs.getString(key) as T?;

    throw UnimplementedError('Set not implemented fot type ${T.runtimeType}');
  }

  @override
  Future<bool> removeKey(String key) async {

    final prefs = await getSharedPrefs();

    return prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();

    if (T == int) {
      prefs.setInt(key, value as int);
      return;
    }

    if (T == String) {
      prefs.setString(key, value as String);
      return;
    }

    throw UnimplementedError('Set not implemented fot type ${T.runtimeType}');
  }
}
