import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voice/platform_widget.dart';

class PlatformProgress extends PlatformWidget<CupertinoActivityIndicator,
    CircularProgressIndicator> {

  PlatformProgress();

  @override
  CircularProgressIndicator createAndroidWidget(BuildContext context) {
    return new CircularProgressIndicator();
  }

  @override
  CupertinoActivityIndicator createIosWidget(BuildContext context) {
    return new CupertinoActivityIndicator();
  }
}