import 'package:flutter/material.dart';

class btmappbar extends StatelessWidget {
  btmappbar({super.key});
  final List<Widget> _pages = [
    //각 페이지 이동 시 사용하는 리스트형 위젯 각 페이지 클래스를 실행한다
  ];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '시간표',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note_alt_outlined),
          label: '메모하기',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: '사진',
        ),
      ],
    );
  }
}
