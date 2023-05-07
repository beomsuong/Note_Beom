import 'package:flutter/material.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class addDialog extends StatefulWidget {
  final Function(String, int, DateTime, int) onAdd;
  const addDialog({Key? key, required this.onAdd}) : super(key: key);

  @override
  State<addDialog> createState() => _addDialogState();
}

int i = 1;

class _addDialogState extends State<addDialog> {
  DateTime starttime =
      DateTime(2023, 10, 3, 9, 0); //DateTime(DateTime.now().hour);
  @override
  void initState() {
    timeWidgets.add(addtime());
  }

  DateTime dateTimeSelected = DateTime.now();

  void _openTimePickerSheet(BuildContext context) async {
    final result = await TimePicker.show<DateTime?>(
      context: context,
      sheet: TimePickerSheet(
        sheetTitle: 'Select meeting schedule',
        minuteTitle: 'Minute',
        hourTitle: 'Hour',
        saveButtonText: 'Save',
      ),
    );

    if (result != null) {
      setState(() {
        dateTimeSelected = result;
      });
    }
  }

  DateTime endtime = DateTime(
      2023, 10, 3, 10, 0); //DateTime.now().add(const Duration(hours: 1));

  String classname = '월';
  String classday = '월';
  List<String> list = <String>['월', '화', '수', '목', '금'];
  Map<String, int> map = {'월': 0, '화': 1, '수': 2, '목': 3, '금': 4};
  List<Widget> timeWidgets = [];
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: AlertDialog(
          // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          //Dialog Main Title
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                onChanged: (text) {
                  setState(() {
                    classname = text;
                  });
                },
                decoration: const InputDecoration(
                  labelText: '수업 이름',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(80),
                    ), //둥글게
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 204, 199, 191),
                ),
              ),
              Column(
                children: [
                  Column(children: timeWidgets),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.black87,
                        backgroundColor: Colors.red),
                    onPressed: () {
                      setState(() {
                        // 버튼 비활성화

                        // timeWidgets.removeAt(timeWidgets.indexOf());
                        //timeWidgets.removeLast();
                      });
                    },
                    child: const Text(
                      '삭제',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      foregroundColor: Colors.black,
                      backgroundColor: const Color.fromARGB(255, 61, 184, 225),
                    ),
                    onPressed: timeWidgets.length >= 5
                        ? null
                        : () {
                            setState(() {
                              // 버튼 비활성화
                              timeWidgets.add(addtime());
                            });
                          },
                    child: const Text(
                      '추가',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        //버튼을 둥글게 처리
                        borderRadius: BorderRadius.circular(10),
                      ),
                      foregroundColor: Colors.black,
                      backgroundColor: const Color.fromARGB(255, 61, 184, 225),
                    ),
                    onPressed: () {
                      widget.onAdd(
                        classname,
                        map[classday]!,
                        starttime,
                        endtime.difference(starttime).inMinutes,
                      );
                      Navigator.of(context).pop();
                    }, //로그인 함수 호출
                    child: const Text(
                      '확인',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        //버튼을 둥글게 처리
                        borderRadius: BorderRadius.circular(10),
                      ),
                      foregroundColor: Colors.black,
                      backgroundColor: const Color.fromARGB(255, 61, 184, 225),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }, //로그인 함수 호출
                    child: const Text(
                      '종료',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  int i = 0;
  List<int> q = [1, 2, 3, 4];
  void delet() async {
    setState(() async {
      i++;
      timeWidgets.removeAt(0);
      print(timeWidgets.length);
      var snapshot = await FirebaseFirestore.instance
          .collection("!@#users12")
          .doc("수학")
          .get();
      print("ZZ");
      print(snapshot.data());
    });
  }

  @override
  Widget addtime() {
    print("!@# $i");
    return SizedBox(
      child: Column(
        children: [
          Text(
            '$i',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: Colors.black87,
                    backgroundColor: Colors.red),
                onPressed: () {
                  setState(() {
                    delet();
                    // 버튼 비활성화
                    i++;
                    // timeWidgets.removeAt();
                    // timeWidgets.removeAt(timeWidgets.indexOf());
                    //timeWidgets.removeLast();
                  });
                },
                child: const Text(
                  '삭1제',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
