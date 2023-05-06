import 'package:flutter/material.dart';

class btmappbar extends StatelessWidget {
  btmappbar({super.key});
  int abs = 0;
  final List<Widget> _pages = [
    //각 페이지 이동 시 사용하는 리스트형 위젯 각 페이지 클래스를 실행한다
  ];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '검색',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.messenger_outline),
          label: '체팅방',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: '마이페이지',
        ),
      ],
    );
  }
}
