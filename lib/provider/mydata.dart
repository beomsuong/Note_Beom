import 'package:flutter/material.dart';

class Mydata with ChangeNotifier {
  final Map<String, List<List<dynamic>>> _datas = {};
  int _qwe = 0;
  int get qwe => _qwe;
  Map<String, List<List<dynamic>>> get datas => _datas;
  void retunrdatas(Map<String, List<List<dynamic>>> adddata) {
    if (adddata.isNotEmpty) {
      datas.addAll(adddata);
    }

    notifyListeners();
  }

  void addqwer() {
    _qwe++;
    notifyListeners();
  }

  initState() {}
  void removedata(String key1, int day, int hour, int minutes) {
    _datas[key1]?.removeWhere(
        (value) => value[0] == day && value[1] == hour && value[2] == minutes);
    _datas.remove(key1);

    notifyListeners();
  }
}
