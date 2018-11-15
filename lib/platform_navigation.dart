import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voice/platform_widget.dart';

class PlatformNavigation
    extends PlatformWidget<CupertinoTabBar, BottomNavigationBar> {
  final onTapped;
  final currentIndex;
  final items;

  PlatformNavigation({this.onTapped, this.currentIndex, this.items});

  @override
  BottomNavigationBar createAndroidWidget(BuildContext context) {
    return new BottomNavigationBar(
      onTap: onTapped,
      currentIndex: currentIndex,
      items: items,
    );
  }

  @override
  CupertinoTabBar createIosWidget(BuildContext context) {
    return new CupertinoTabBar(
      onTap: onTapped,
      currentIndex: currentIndex,
      items: items,
    );
  }
}
