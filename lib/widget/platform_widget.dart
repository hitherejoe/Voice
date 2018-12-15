import 'dart:io';

import 'package:flutter/widgets.dart';

abstract class PlatformWidget<I extends Widget, A extends Widget>
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return createAndroidWidget(context);
    } else {
      return createIosWidget(context);
    }
  }

  I createIosWidget(BuildContext context);

  A createAndroidWidget(BuildContext context);
}
