import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:voice/constants/theme.dart';
import 'package:voice/model/category.dart';
import 'package:voice/model/country.dart';
import 'package:voice/widget/platform_category_tab.dart';
import 'package:voice/widget/platform_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlatformParent extends PlatformWidget<CupertinoTabScaffold, Scaffold> {
  final children;
  final selectedCountry;
  final onTapped;
  final showTabs;
  final onNavigationTap;
  final currentCategory;

  PlatformParent(
      {this.children,
      this.selectedCountry,
      this.onTapped,
      this.showTabs,
      this.onNavigationTap,
      this.currentCategory});

  @override
  Scaffold createAndroidWidget(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildTabBar(this.showTabs, context),
        body: TabBarView(
          children: this.children,
        ),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: VoiceTheme.blaze_orange,
          onTap: onNavigationTap,
          currentIndex: currentCategory,
          items: _buildNavigationItems(),
          type: BottomNavigationBarType.fixed,
        ));
  }

  Widget buildTabBar(bool showTabs, BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Padding(
          padding: new EdgeInsets.only(right: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new SvgPicture.asset(
                "assets/paw.svg",
                width: 48,
                color: VoiceTheme.blaze_orange,
              ),
              Text('Voice', style: TextStyle(color: VoiceTheme.blaze_orange)),
            ],
          )),
      elevation: 0.0,
      bottom: showTabs
          ? TabBar(
              indicatorColor: VoiceTheme.blaze_orange,
              tabs: _buildTabs(),
            )
          : null,
    );
  }

  @override
  CupertinoTabScaffold createIosWidget(BuildContext context) {
    final Map<int, Widget> children = <int, Widget>{
      0: Text(countries[0].label),
      1: Text(countries[1].label),
      2: Text(countries[2].label),
    };

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: VoiceTheme.blaze_orange,
        onTap: onNavigationTap,
        currentIndex: currentCategory,
        items: _buildNavigationItems(),
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: showTabs
                ? SizedBox(
                    width: 500.0,
                    child: CupertinoSegmentedControl(
                      selectedColor: VoiceTheme.blaze_orange,
                      borderColor: VoiceTheme.blaze_orange,
                      onValueChanged: onTapped,
                      pressedColor: VoiceTheme.blaze_orange,
                      children: children,
                      groupValue: selectedCountry,
                    ))
                : Container(),
          ),
          child: Scaffold(
            body: this.children[0],
          ),
        );
      },
    );
  }

  List<Widget> _buildTabs() {
    return <Widget>[
      PlatformTabs(label: countries[0].label),
      PlatformTabs(label: countries[1].label),
      PlatformTabs(label: countries[2].label),
    ];
  }

  List<BottomNavigationBarItem> _buildNavigationItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(
          FontAwesomeIcons.handHoldingHeart,
          size: 26,
        ),
        title: Text(categories[0].label),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          FontAwesomeIcons.binoculars,
          size: 26,
        ),
        title: Text(categories[1].label),
      ),
      BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.home,
            size: 26,
          ),
          title: Text(categories[2].label)),
      BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.globeAmericas,
            size: 26,
          ),
          title: Text(categories[3].label)),
    ];
  }
}
