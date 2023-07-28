// 프로그램의 데이터 관리
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Mydata with ChangeNotifier {
  final user = FirebaseAuth.instance;
  late DateTime today = DateTime.now();
  late String formattedDate;
  final Map<String, List<List<dynamic>>> _datas = {}; //수업의 날짜 데이터를 저장한다
  final Map<String, List<List<dynamic>>> _memodatas = {}; //수업의 메모 데이터를 저장한다.
  Map<String, List<Map<String, dynamic>>> uploaddata =
      {}; //파이어베이스에 업로드 시 변형하여 저장
  Map<String, List<List<dynamic>>> get datas => _datas;
  Map<String, List<List<dynamic>>> get memodatas => _memodatas;

  Mydata() {
    //생성 시  데이터를 받아와 저장
    formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(today);
    final userDoc = FirebaseFirestore.instance
        .collection('User')
        .doc(user.currentUser?.uid)
        .collection('schedule');
    userDoc.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data.forEach((key, value) {
          memodatas[doc.id] = []; //데이터를 추가할때 빈 메모공간 추가
          if (_datas[doc.id] == null) {
            _datas[doc.id] = [];
          }
          _datas[doc.id]?.add([
            value['day'],
            value['hour'],
            value['minute'],
            value['value'],
          ]);
        });
      }
    });
  }

  void memodataadd(String key, String text) {
    today = DateTime.now();
    memodatas[key]!.add([text, today]);
    memodataupdatefirebase();
  }

  void memodataremove(String key, String text) {
    //특정 수업의 해당 메모 삭제
    memodatas[key]!.removeWhere((item) => item[0] == text);
    memodataupdatefirebase();
  }

  void memodataupdatefirebase() {
    //데이터 변경시 파이어베이스 수정내역 올리기
    final userDoc = FirebaseFirestore.instance
        .collection('User')
        .doc(user.currentUser?.uid)
        .collection('memo');

    for (var data in memodatas.keys) {
      userDoc.doc(data).set({
        for (var e in memodatas[data]!) '${memodatas[data]!.indexOf(e)}': e
      });
    }
  }

  void retunrscheduledata(Map<String, List<List<dynamic>>> adddata) {
    //데이터가 추가되어 넘어온 경우
    memodatas[adddata.keys.first] = []; //데이터를 추가할때 빈 메모공간 추가
    if (adddata.isNotEmpty) {
      datas.addAll(adddata);
    }
    scheduledataupdatefirebase();
    notifyListeners();
  }

  void scheduledataupdatefirebase() {
    //데이터 변경시 파이어베이스 수정내역 올리기
    final userDoc = FirebaseFirestore.instance
        .collection('User')
        .doc(user.currentUser?.uid)
        .collection('schedule');

    for (var data in datas.keys) {
      uploaddata[data] = [];
      if (datas[data] != null) {
        for (int i = 0; i < datas[data]!.length; i++) {
          uploaddata[data]!.add({
            'day': datas[data]![i][0],
            'hour': datas[data]![i][1],
            'minute': datas[data]![i][2],
            'value': datas[data]![i][3]
          });
        }
      }
      userDoc.doc(data).set({
        for (var e in uploaddata[data]!) '${uploaddata[data]!.indexOf(e)}': e
      });
    }
  }

  void scheduledataremove(String key1, int day, int hour, int minutes) {
    //날짜 데이터를 삭제한다
    _datas[key1]?.removeWhere(//입력된 날짜와 해당 수업에 일치하는 날짜를 삭제함
        (value) => value[0] == day && value[1] == hour && value[2] == minutes);
    notifyListeners();
    if (scheduledataempty()) {
      //날짜 데이터가 모두 지워진 경우
      final userCollection = FirebaseFirestore.instance
          .collection('User')
          .doc(user.currentUser?.uid)
          .collection('schedule')
          .doc(key1); // document ID that you want to delete
      userCollection.delete().then((_) {
        print("날짜가 지워져서 해당 데이터 삭제");
      }).catchError((error) {
        print("삭제 실패: $error");
      });
    } else {
      //모두 삭제된 경우가 아니라면 그냥 업데이트
      scheduledataupdatefirebase();
    }
  }

  bool scheduledataempty() {
    //날짜 데이터가 모두 지워졌는지 확인
    for (var i in _datas.keys) {
      if (_datas[i]!.isEmpty) {
        _datas.removeWhere((key, value) => value.isEmpty);
        return true; //모두 지워진 경우에는 true를 반환해서 파이어베이스 문서 삭제
      }
    }
    return false; //데이터가 남아있을떄
  }
}
