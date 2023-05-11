import 'package:flutter/material.dart';

class Mydata with ChangeNotifier {
  final Map<String, List<List<dynamic>>> _datas = {}; //수업의 날짜 데이터를 저장한다
  final Map<String, List<String>> _memodatas = {}; //수업의 메모 데이터를 저장한다.

  Map<String, List<List<dynamic>>> get datas => _datas;
  Map<String, List<String>> get memodatas => _memodatas;
  void retunrdatas(Map<String, List<List<dynamic>>> adddata) {
    if (adddata.isNotEmpty) {
      datas.addAll(adddata);
    }
    notifyListeners();
  }

  initState() {}
  void removedata(String key1, int day, int hour, int minutes) {
    //날짜 데이터를 삭제한다
    _datas[key1]?.removeWhere(//입력된 날짜와 해당 수업에 일치하는 날짜를 삭제함
        (value) => value[0] == day && value[1] == hour && value[2] == minutes);
    emptydatas(); //날짜 데이터가 모두 삭제되어 빈 깡통인 경우
    notifyListeners();
  }

  void emptydatas() {
    //날짜 데이터가 모두 지워졌을 경우 호출
    for (var i in _datas.keys) {
      if (_datas[i]!.isEmpty) {
        _datas.removeWhere((key, value) => value.isEmpty);
        break;
      }
    }
  }
}
