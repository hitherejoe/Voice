import 'package:flutter/material.dart';
import 'package:voice/content_list.dart';
import 'package:voice/platform_navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'Voice'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  Choice _selectedChoice = choices[0];

  final List<String> _children = [
    "Animal Rights",
    "Sab groups",
    "Global Organisations",
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new SafeArea(child: new BookList(
        documentName: _children[_currentIndex],
        country: _selectedChoice.title,
        showFilter: _currentIndex != 2,
      )),
      bottomNavigationBar: PlatformNavigation(
        onTapped: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(FontAwesomeIcons.handHoldingHeart),
            title: new Text('Animal Rights'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(FontAwesomeIcons.binoculars),
            title: new Text('Hunt Sabs'),
          ),
          BottomNavigationBarItem(
              icon: new Icon(FontAwesomeIcons.globeAmericas),
              title: Text('Global Orgs'))
        ],
      ),
    );
  }
}

class Choice {
  const Choice({this.title});

  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'All'),
  const Choice(title: 'United Kingdom'),
  const Choice(title: 'United States'),
  const Choice(title: 'France'),
  const Choice(title: 'Switzerland'),
];
