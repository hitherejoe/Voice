import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voice/widget/platform_widget.dart';
import 'package:voice/constants/theme.dart';

class PlatformTabs extends PlatformWidget<Text, Tab> {
  final label;

  PlatformTabs({this.label});

  @override
  Tab createAndroidWidget(BuildContext context) {
    return Tab(
        child: Text(
      label,
      style: TextStyle(color: VoiceTheme.blaze_orange),
    ));
  }

  @override
  Text createIosWidget(BuildContext context) {
    return Text(label);
  }
}
