import 'package:flutter/material.dart';
import 'package:metro_beom/provider/mydata.dart';
import 'package:provider/provider.dart';
import 'package:time_planner/time_planner.dart';
import 'package:intl/intl.dart';
import 'addDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Weekcalendar extends StatefulWidget {
  const Weekcalendar({Key? key}) : super(key: key);

  @override
  _WeekcalendarState createState() => _WeekcalendarState();
}

final _authentication = FirebaseAuth.instance;
late Mydata data;
late DateTime starttime;
late DateTime endtime;
final User? user = _authentication.currentUser;

class _WeekcalendarState extends State<Weekcalendar> {
  List<Color?> colors = [
    // 색깔을 저장하는 변수
    Colors.purple,
    const Color.fromRGBO(33, 150, 243, 1),
    Colors.green,
    Colors.orange,
    Colors.lime[600],
    Colors.pink[200]
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
  List<TimePlannerTask> tasks = []; //화면에 시간표를 추가하는 List

  int i = 0;
  List<String> list = <String>['월', '화', '수', '목', '금'];
  String? dropdownValue;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    data = Provider.of<Mydata>(context); //처음 시작시 같이 실행됨
    //앱 전체 데이터 클래스를 받아옴
    super.didChangeDependencies();

    for (var key in data.datas.keys) {
      i++;
      for (final value in data.datas[key]!) {
        if (i >= colors.length - 2) {
          i = 0;
        }
        int day = value[0];
        int hour = value[1];
        int minutes = value[2];
        tasks.add(
          TimePlannerTask(
            color: colors[i],
            dateTime: TimePlannerDateTime(
                day: value[0], hour: value[1], minutes: value[2]),
            minutesDuration: value[3],
            daysDuration: 1,
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('You click on $key')));
                tasks.removeWhere((task) =>
                    task.dateTime.day == value[0] &&
                    task.dateTime.hour == value[1] &&
                    task.dateTime.minutes == value[2]);
                setState(() {
                  data.scheduledataremove(key, day, hour, minutes);
                });
              },
              child: Text(
                key,
                style: TextStyle(color: Colors.grey[350], fontSize: 12),
              ),
            ),
          ),
        );
      }
    }
  }

  void retunrdata(
    Map<String, List<List<dynamic>>> adddatas,
    //데이터를 추가하는 부분
  ) {
    setState(() {
      data.retunrscheduledata(adddatas); //데이터 저장
      for (var key in data.datas.keys) {
        i++;
        if (i >= colors.length - 1) {
          i = 0;
        }
        for (final value in data.datas[key]!) {
          int day = value[0];
          int hour = value[1];
          int minutes = value[2];
          tasks.add(
            TimePlannerTask(
              color: colors[i],
              dateTime: TimePlannerDateTime(
                  day: value[0], hour: value[1], minutes: value[2]),
              minutesDuration: value[3],
              daysDuration: 1,
              child: GestureDetector(
                onTap: () {
                  //터치시 해당 데이터를 삭제함
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('You click on $key')));
                  tasks.removeWhere((task) =>
                      task.dateTime.day == value[0] &&
                      task.dateTime.hour == value[1] &&
                      task.dateTime.minutes == value[2]);
                  setState(() {
                    data.scheduledataremove(key, day, hour, minutes); //
                  });
                },
                child: Text(
                  key,
                  style: TextStyle(color: Colors.grey[350], fontSize: 12),
                ),
              ),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          child: Center(
            child: TimePlanner(
                currentTimeAnimation: false,
                startHour: 9,
                endHour: 18,
                style: TimePlannerStyle(
                  // cellHeight: 30,
                  //cellWidth: 60,
                  showScrollBar: true,
                ),
                headers: [
                  //각 요일 아래 해당 요일이 오는 가장 빠른 날짜 표기
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
          tooltip: '시간표를 추가합니다',
          child: const Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return addDialog(onAdd: (newTimes) {
                print("받아온값");
                print(newTimes);
                // 다이얼로그에서  입력한 수업명, 시간 List를 받아옴
                setState(() {
                  retunrdata(newTimes); //전달 받은 데이터를 시간표에 추가한다
                });
              });
            },
          ),
        ));
  }
}
