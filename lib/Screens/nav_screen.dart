import 'package:flutter/material.dart';
import 'package:netflix_clone/Screens/screens.dart';
import 'package:netflix_clone/Widgets/widgets.dart';

class NabScreen extends StatefulWidget {
  const NabScreen({Key? key}) : super(key: key);

  @override
  State<NabScreen> createState() => _NabScreenState();
}

class _NabScreenState extends State<NabScreen> {
  final List<Widget> _screen = const [
    HomeScreen(key: PageStorageKey('homeScreen'),),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold()
  ];

  final Map<String, IconData> _icons = const {
    'Home' : Icons.home,
    'Searh' : Icons.search,
    'Comming Soon' : Icons.queue_play_next,
    'Downloads' : Icons.file_download,
    'More' : Icons.menu
  };

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_currentIndex],
      bottomNavigationBar: !Responsive.isDesktop(context) ? BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
          items: _icons.map((title, icon) => MapEntry(
              title,
              BottomNavigationBarItem(
                icon: Icon(icon,size: 30,),
                label: title
              ))).values.toList(),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        selectedFontSize: 11,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 11,
        onTap: (index){ setState((){
          _currentIndex = index;
        });},
      ) : null,
    );
  }
}
