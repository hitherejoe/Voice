import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:voice/widget/platform_content.dart';
import 'package:voice/widget/platform_parent.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => new _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  int _currentCategory = 0;
  int _selectedCountry = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _currentCategory == 3 ? 1 : 3,
        child: PlatformParent(
          onNavigationTap: _onNavigationTapped,
          currentCategory: _currentCategory,
          selectedCountry: _selectedCountry,
          children:
              PlatformContent().generate(_currentCategory, _selectedCountry),
          onTapped: (int) => _onTabTapped(int),
          showTabs: _currentCategory != 3,
        ));
  }

  void _onNavigationTapped(int index) {
    setState(() {
      _currentCategory = index;
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedCountry = index;
    });
  }
}
