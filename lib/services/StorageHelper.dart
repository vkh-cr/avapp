import 'package:get_storage/get_storage.dart';

class StorageHelper
{
  static final Map<String, GetStorage> storages = {};
  static final box = GetStorage("GetStorage");
  static Future<void> Initialize([String? storage]) async
  {
    if(storage == null)
    {
      await box.initStorage;
      return;
    }
    if(!storages.containsKey(storage))
    {
      storages[storage] = GetStorage(storage);
    }
    await storages[storage]!.initStorage;
  }
  static String? Get(String key, [String? storage]){
    if(storage == null)
    {
      return box.read(key);
    }
    if(!storages.containsKey(storage))
    {
      storages[storage] = GetStorage(storage);
    }
    return storages[storage]!.read(key);
  }
  static void Set(String key, String value, [String? storage]){
    if(storage == null)
    {
      box.write(key, value);
      return;
    }
    if(!storages.containsKey(storage))
    {
      storages[storage] = GetStorage(storage);
    }
    storages[storage]!.write(key, value);
  }
  static void Remove(String key, [String? storage]){
    if(storage == null)
    {
      box.remove(key);
      return;
    }
    if(!storages.containsKey(storage))
    {
      storages[storage] = GetStorage(storage);
    }
    storages[storage]!.remove(key);
  }
}