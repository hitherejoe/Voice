import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voice/widget/platform_widget.dart';

class PlatformProgress extends PlatformWidget<CupertinoActivityIndicator,
    CircularProgressIndicator> {
  PlatformProgress();

  @override
  CircularProgressIndicator createAndroidWidget(BuildContext context) {
    return CircularProgressIndicator();
  }

  @override
  CupertinoActivityIndicator createIosWidget(BuildContext context) {
    return CupertinoActivityIndicator();
  }
}
