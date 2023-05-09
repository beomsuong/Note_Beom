import 'dart:math';

import 'package:flutter/material.dart';
import 'package:time_planner/time_planner.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'save2.dart';

class Weekcalendar extends StatefulWidget {
  const Weekcalendar({Key? key}) : super(key: key);

  @override
  _WeekcalendarState createState() => _WeekcalendarState();
}

late DateTime starttime;
late DateTime endtime;
Map<String, List<List<dynamic>>> datas = {
  '수학': [
    [1, 9, 30, 60],
    [2, 9, 30, 60],
  ],
  '과학': [
    [3, 9, 30, 60],
  ]
}; //데이터는 이렇게 여러게로 저장할래요

class _WeekcalendarState extends State<Weekcalendar> {
  List<Color?> colors = [
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.lime[600]
  ];
  late List<List<dynamic>> data12;
  List<String> days = [
    //가장 빠른 요일을 저장하는 리스트
    DateFormat('MM-dd').format(DateTime.now()
        .add(Duration(days: (DateTime.monday - DateTime.now().weekday) % 7))),
    DateFormat('MM-dd').format(DateTime.now()
        .add(Duration(days: (DateTime.tuesday - DateTime.now().weekday) % 7))),
    DateFormat('MM-dd').format(DateTime.now().add(
        Duration(days: (DateTime.wednesday - DateTime.now().weekday) % 7))),
    DateFormat('MM-dd').format(DateTime.now()
        .add(Duration(days: (DateTime.thursday - DateTime.now().weekday) % 7))),
    DateFormat('MM-dd').format(DateTime.now()
        .add(Duration(days: (DateTime.friday - DateTime.now().weekday) % 7))),
  ];
  List<TimePlannerTask> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          child: Center(
            child: TimePlanner(
                startHour: 9,
                endHour: 18,
                style: TimePlannerStyle(
                  // cellHeight: 30,
                  //cellWidth: 60,
                  showScrollBar: true,
                ),
                headers: [
                  TimePlannerTitle(
                    title: "monday",
                    date: days[0].toString(),
                  ),
                  TimePlannerTitle(
                    title: "tuesday",
                    date: days[1].toString(),
                  ),
                  TimePlannerTitle(
                    title: "wednesday",
                    date: days[2].toString(),
                  ),
                  TimePlannerTitle(
                    title: "thursday",
                    date: days[3].toString(),
                  ),
                  TimePlannerTitle(
                    title: "friday",
                    date: days[4].toString(),
                  ),
                ],
                tasks: tasks),
          ),
        ),
        // bottomNavigationBar: btmappbar(),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add random task',
          child: const Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return addDialog1(onAdd: (newTimes) {
                setState(() {
                  retunrdata(newTimes);
                });
              });
            },
          ),
        ));
  }

  int i = 0;
  List<String> list = <String>['월', '화', '수', '목', '금'];
  String? dropdownValue;
  @override
  void initState() {
    for (var key in datas.keys) {
      final usercol =
          FirebaseFirestore.instance.collection("!@#users12").doc(key);
      usercol.set({});
      i++;
      for (final value in datas[key]!) {
        final usercol =
            FirebaseFirestore.instance.collection("!@#users12").doc(key);
        usercol.update({
          i.toString(): value,
        });
        int day = value[0];
        int hour = value[1];
        int minutes = value[2];
        tasks.add(
          TimePlannerTask(
            color: colors[i - 1],
            dateTime: TimePlannerDateTime(
                day: value[0], hour: value[1], minutes: value[2]),
            minutesDuration: value[3],
            daysDuration: 1,
            onTap: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('You click on $key')));
              tasks.removeWhere((task) =>
                  task.dateTime.day == value[0] &&
                  task.dateTime.hour == value[1] &&
                  task.dateTime.minutes == value[2]);
              datas[key]?.removeWhere((value) =>
                  value[0] == day && value[1] == hour && value[2] == minutes);
              if (datas[key]?.isEmpty ?? false) {
                datas.remove(key);
              }
              setState(() {});
            },
            child: Text(
              key,
              style: TextStyle(color: Colors.grey[350], fontSize: 12),
            ),
          ),
        );
      }
    }
    super.initState();
    dropdownValue = list.first;
  }

  void retunrdata(
    Map<String, List<List<dynamic>>> adddatas,
    //데이터를 추가하는 부분
  ) {
    setState(() {
      datas.addAll(adddatas);
      for (var key in datas.keys) {
        for (final value in datas[key]!) {
          i++;

          int day = value[0];
          int hour = value[1];
          int minutes = value[2];
          tasks.add(
            TimePlannerTask(
              color: colors[Random().nextInt(colors.length)],
              dateTime: TimePlannerDateTime(
                  day: value[0], hour: value[1], minutes: value[2]),
              minutesDuration: value[3],
              daysDuration: 1,
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('You click on $key')));
                tasks.removeWhere((task) =>
                    task.dateTime.day == value[0] &&
                    task.dateTime.hour == value[1] &&
                    task.dateTime.minutes == value[2]);
                datas[key]?.removeWhere((value) =>
                    value[0] == day && value[1] == hour && value[2] == minutes);
                if (datas[key]?.isEmpty ?? false) {
                  datas.remove(key);
                }
                setState(() {});
              },
              child: Text(
                key,
                style: TextStyle(color: Colors.grey[350], fontSize: 12),
              ),
            ),
          );
        }
      }
    });
  }
}
