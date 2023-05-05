import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:time_planner/time_planner.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time planner Demo',
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Time planner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String startime, endtime, classmean;
  List<Color?> colors = [
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.lime[600]
  ];
  List<TimePlannerTask> tasks = [
    TimePlannerTask(
      color: Colors.purple,
      dateTime: TimePlannerDateTime(
          day: 0,
          hour: Random().nextInt(18) + 6,
          minutes: Random().nextInt(60)),
      minutesDuration: Random().nextInt(90) + 30,
      daysDuration: 1,
      child: Text(
        'this is a demo',
        style: TextStyle(color: Colors.grey[350], fontSize: 12),
      ),
    ),
  ];

  void _addObject(BuildContext context) {
    List<Color?> colors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.lime[600]
    ];

    setState(() {
      tasks.add(
        TimePlannerTask(
          color: colors[Random().nextInt(colors.length)],
          dateTime: TimePlannerDateTime(
              day: 0,
              hour: Random().nextInt(18) + 6,
              minutes: Random().nextInt(60)),
          minutesDuration: Random().nextInt(90) + 30,
          daysDuration: 1,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('You click on time planner object')));
          },
          child: Text(
            'this is a demo',
            style: TextStyle(color: Colors.grey[350], fontSize: 12),
          ),
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Random task added to time planner!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: TimePlanner(
          startHour: 9,
          endHour: 23,
          style: TimePlannerStyle(
            // cellHeight: 30,
            //cellWidth: 60,
            showScrollBar: true,
          ),
          headers: const [
            TimePlannerTitle(
              title: "sunday",
            ),
            TimePlannerTitle(
              title: "monday",
            ),
            TimePlannerTitle(
              title: "tuesday",
            ),
            TimePlannerTitle(
              title: "wednesday",
            ),
            TimePlannerTitle(
              title: "thursday",
            ),
            TimePlannerTitle(
              title: "friday",
            ),
            TimePlannerTitle(
              title: "saturday",
            ),
          ],
          tasks: tasks,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => FlutterDialog(),
        // onPressed: () => _addObject(context),
        tooltip: 'Add random task',
        child: const Icon(Icons.add),
      ),
    );
  }

  String? _selectedItem;
  void FlutterDialog() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: const <Widget>[
                Text("시간표 추가"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "시작 시간",
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      startime = text;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: '시작 시간입력',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(80)), //둥글게
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 204, 199, 191),
                  ),
                ),
                Positioned(
                    left: 30,
                    top: 60,
                    child: TimePickerSpinnerPopUp(
                      mode: CupertinoDatePickerMode.time,
                      initTime: DateTime.now(),
                      onChange: (dateTime) {
                        // Implement your logic with select dateTime
                      },
                    )),
              ],
            ),
          );
        });
  }
}
