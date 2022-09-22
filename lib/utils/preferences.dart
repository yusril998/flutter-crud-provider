import 'package:hive/hive.dart';

class Preferences {
  static const HIVE_BOX = "HiveBox";
  static const HIVE_AUTH = "UserAuth";
  static const HIVE_USER_INFO = "UserInfo";

  /** ini adalah contoh yang benar */

  static Future<void> saveUid(String data) async {
    var box = await Hive.openBox(HIVE_BOX);
    await box.put(HIVE_AUTH, data);
  }

  static Future<String?> getUid() async {
    var box = await Hive.openBox(HIVE_BOX);
    return box.get(HIVE_AUTH);
  }

  static Future<void> deleteUid() async {
    var box = await Hive.openBox(HIVE_BOX);
    return box.delete(HIVE_AUTH);
  }

  /** ini adalah contoh yang salah  */
  static Future<void> simpanUid(String data) async {
    var box = await Hive.openBox(HIVE_BOX);
    await box.put(HIVE_AUTH, data);
  }

  static Future<String?> tampilkanUid() async {
    var box = await Hive.openBox(HIVE_BOX);
    return box.get(HIVE_AUTH);
  }

  static Future<void> hapusUid() async {
    var box = await Hive.openBox(HIVE_BOX);
    return box.delete(HIVE_AUTH);
  }
}
