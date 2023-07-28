//수업에 대한 메모 작성
import 'package:flutter/material.dart';
import 'package:metro_beom/provider/mydata.dart';
import 'package:provider/provider.dart';

class Writememo extends StatefulWidget {
  final String classname;
  const Writememo({Key? key, required this.classname}) : super(key: key);

  @override
  _WritememoState createState() => _WritememoState();
}

class _WritememoState extends State<Writememo> {
  late String classname;
  String dropdownValue = 'One'; // dropdownValue 변수 추가
  final _controller = TextEditingController();
  late Mydata data;

  @override
  void initState() {
    super.initState();
    classname = widget.classname;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = Provider.of<Mydata>(context);
    dropdownValue =
        data.memodatas.keys.first; // 첫 번째 key를 DropdownButton의 value로 설정
  }

  void addmemo(BuildContext context) {
    //메모를 저장
    final data = context.read<Mydata>();
    data.memodataadd(classname, _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: data.memodatas.keys
              .toList()
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        centerTitle: true,
        actions: <Widget>[
          // actions 속성을 사용하여 IconButton을 AppBar의 오른쪽에 추가
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              addmemo(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(_controller.text)));
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '메모를 입력하세요',
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
        ),
      ),
    );
  }
}
