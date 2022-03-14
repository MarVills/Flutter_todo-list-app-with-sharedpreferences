import 'package:shared_preferences/shared_preferences.dart';

/*
  // to get value of method() to another file, use code below
  Crud().method("sharedpref_key").then((value) {
    data = value;
  });
*/
// Note: this way of deleting data is not unique.
// The value should not be the same with existing one.
class Crud {
  getDataList(String prefsKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dataList = <String>[];
    dataList = prefs.getStringList(prefsKey) ?? [];
    return dataList;
  }

  getDataLength(String prefsKey) async {
    int len = (await getDataList(prefsKey)).length;
    return len;
  }

  createData(String prefsKey, String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dataList = await getDataList(prefsKey);

    dataList.add(data);
    prefs.setStringList(prefsKey, dataList);
  }

  editData(String prefsKey, String toRemoveData, String toReplaceData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dataList = await getDataList(prefsKey);

    dataList.removeWhere((item) => item == toRemoveData);
    dataList.add(toReplaceData);
    prefs.setStringList(prefsKey, dataList);
  }

  deleteData(String toDeleteData, String prefsKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dataList = await getDataList(prefsKey);
    dataList.removeWhere((item) => item == toDeleteData);
    prefs.setStringList(prefsKey, dataList);
  }
}
