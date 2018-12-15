import 'package:flutter/widgets.dart';
import 'package:voice/constants/keys.dart';
import 'package:voice/widget/platform_progress.dart';

class LoadingWidget extends StatelessWidget {
  final String document;

  LoadingWidget({this.document});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(32.0),
          child: Center(
              child: Text(
            _buildQuote(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          )),
        ),
        PlatformProgress()
      ],
    );
  }

  String _buildQuote() {
    if (this.document == Keys.DOCUMENT_ANIMAL_RIGHTS) {
      return "\"The greatness of a nation can be judged by the way its animals are treated\"";
    } else if (this.document == Keys.DOCUMENT_SAB_GROUPS) {
      return "\"Outdated and barbaric activities such as hunting should be consigned to the history books\"";
    } else if (this.document == Keys.DOCUMENT_SHELTERS) {
      return "\"Adopt, don't shop ❤\"️";
    } else {
      return "\"Anybody can make a difference and be a voice for the voiceless\"";
    }
  }
}
