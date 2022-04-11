import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robinhoodtv/cubits/cubits.dart';
import 'package:robinhoodtv/screens/history_screen.dart';
import 'package:robinhoodtv/screens/movie/homescreens.dart';
import 'package:robinhoodtv/screens/screen.dart';
import 'package:robinhoodtv/screens/search_screen.dart';
import 'package:robinhoodtv/screens/serie/homescreenserie.dart';

class NavScreen extends StatefulWidget {
  final int cureentIndex;

  const NavScreen({Key key, this.cureentIndex}) : super(key: key);
  @override
  _NavScreenState createState() => _NavScreenState(cureentIndex);
}

class _NavScreenState extends State<NavScreen> {
  int cureentIndex;
  final List<Widget> _screen = [
    HomeScreen(key: PageStorageKey('homescreen')),
    SearchScreen(key: PageStorageKey('searchscreen')),
    Scaffold(),
    HistoryScreen(
      key: PageStorageKey('historique'),
    ),
    Scaffold(),
    HomeScreenSerie(
      key: PageStorageKey('seriehomescreen'),
    ),
    HomeScreenAnime(
      key: PageStorageKey('animehomescreen'),
    ),
  ];
  final Map<String, IconData> _icons = const {
    'Home': Icons.home,
    'Search': Icons.search,
    'Live Stream': Icons.live_tv,
    'Historique': Icons.history,
  };

  _NavScreenState(this.cureentIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AppBarCubit>(
        create: (_) => AppBarCubit(),
        child: _screen[cureentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: _icons
            .map((title, icon) => MapEntry(
                title,
                BottomNavigationBarItem(
                  icon: Icon(
                    icon,
                    size: 30.0,
                  ),
                  title: Text(title),
                )))
            .values
            .toList(),
        currentIndex: cureentIndex > 4 ? 0 : cureentIndex,
        selectedFontSize: 11.0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 11.0,
        onTap: (index) => setState(() => cureentIndex = index),
      ),
    );
  }
}
