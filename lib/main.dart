import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voice/widget/dashboard.dart';
import 'package:voice/constants/strings.dart';
import 'package:voice/constants/theme.dart';

void main() => runApp(new VoiceApp());

class VoiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
    ));
    return MaterialApp(
        title: Strings.APP_NAME,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          accentColor: VoiceTheme.light_orange,
          primaryColorDark: VoiceTheme.blaze_orange,
        ),
        home: Dashboard());
  }
}