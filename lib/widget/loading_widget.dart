import 'package:flutter/widgets.dart';
import 'package:voice/constants/keys.dart';
import 'package:voice/constants/strings.dart';
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
      return Strings.quote_animal_rights;
    } else if (this.document == Keys.DOCUMENT_SAB_GROUPS) {
      return Strings.quote_hunt_sabs;
    } else if (this.document == Keys.DOCUMENT_SHELTERS) {
      return Strings.quote_shelters;
    } else {
      return Strings.quote_orgs;
    }
  }
}
