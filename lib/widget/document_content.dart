import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voice/model/country.dart';
import 'package:voice/constants/keys.dart';
import 'package:voice/widget/error_widget.dart';
import 'package:voice/widget/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentContent extends StatefulWidget {
  final String selectedCategory;
  final String selectedCountry;

  DocumentContent({this.selectedCategory, this.selectedCountry});

  @override
  State<StatefulWidget> createState() {
    return new _DocumentState();
  }
}

class _DocumentState extends State<DocumentContent> {
  var stream;

  @override
  Widget build(BuildContext context) {
    _initialiseContentStream();
    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                child: LoadingWidget(
              document: widget.selectedCategory,
            ));
          } else if (snapshot.data.documents.length > 0) {
            return new ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  _buildDocumentTile(
                      snapshot.data.documents[index],
                      index > 0 ? snapshot.data.documents[index - 1] : null,
                      index,
                      snapshot.data.documents.length),
              itemCount: snapshot.data.documents.length,
            );
          } else {
            return Container(
                child: ContentErrorWidget(onTryAgain: _reloadContent));
          }
        });
  }

  _buildDocumentTile(DocumentSnapshot document,
      DocumentSnapshot previousDocument, int index, int itemCount) {
    if (index >= itemCount) return null;
    bool showHeader = widget.selectedCountry != countries[3].label &&
        (previousDocument == null ||
            previousDocument.data[Keys.KEY_CITY] !=
                document.data[Keys.KEY_CITY]);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          showHeader
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    bottom: 16.0,
                  ),
                  child: Text(
                    capitalize(document[Keys.KEY_CITY]),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ))
              : index != 0
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: 74.0,
                      ),
                      child: Divider(
                        color: Colors.grey[400],
                      ),
                    )
                  : Container(),
          ListTile(
            leading: Container(
                width: 42,
                height: 42,
                child: ClipOval(
                  child: Center(
                    child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: 'assets/preload.png',
                        image: document[Keys.KEY_IMAGE]),
                  ),
                )),
            onTap: () => _launchURL(document[Keys.KEY_URL]),
            title: Text(capitalize(document[Keys.KEY_NAME])),
            subtitle: document[Keys.KEY_CITY] != null &&
                    document[Keys.KEY_COUNTRY] != null
                ? Text(capitalize(document[Keys.KEY_CITY]) +
                    ", " +
                    capitalize(document[Keys.KEY_COUNTRY]))
                : null,
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _reloadContent() {
    setState(() {
      _initialiseContentStream();
    });
  }

  _initialiseContentStream() {
    CollectionReference collectionReference =
        Firestore.instance.collection(widget.selectedCategory);

    stream = widget.selectedCountry != countries[3].label
        ? collectionReference
            .where(Keys.KEY_GROUP, isEqualTo: widget.selectedCountry)
            .orderBy(Keys.KEY_CITY, descending: false)
            .snapshots()
        : collectionReference.snapshots(); // initial stream
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
