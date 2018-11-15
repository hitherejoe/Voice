import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voice/main.dart';
import 'package:voice/platform_progress.dart';
import 'package:url_launcher/url_launcher.dart';

class BookList extends StatelessWidget {
  final String documentName;
  final String country;
  final bool showFilter;

  BookList({this.documentName, this.country, this.showFilter});

  List<Widget> buildChildren(AsyncSnapshot<QuerySnapshot> snapshot) {
    var builder = [ ];
    if (this.showFilter) {
      builder.add(new SliverAppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: new Text(""),
        actions: this.showFilter
            ? <Widget>[
          PopupMenuButton<Choice>(
            // onSelected: this.onTap,
            icon: new Icon(
              Icons.filter_list,
              color: Colors.green,
            ),
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ]
            : new List(0),
      ));
    } else {
      builder.add(new SliverPadding(padding: EdgeInsets.all(6.0)));
    }
    builder.add(new SliverList(
      delegate: new SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          if (index >= snapshot.data.documents.length) return null;
          return getExpenseItems(snapshot.data.documents[index]);
        },
      ),
    ));
    return builder.cast<Widget>();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference collectionReference =
        Firestore.instance.collection(documentName);

    return StreamBuilder(
      stream: country != "All"
          ? collectionReference.where("country", isEqualTo: country).snapshots()
          : collectionReference.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(child: new PlatformProgress());
          default:
            return new CustomScrollView(slivers: buildChildren(snapshot));
        }
      },
    );
  }

  getExpenseItems(DocumentSnapshot document) {
    return Column(
      children: <Widget>[
        new ListTile(
          leading: new Container(
              width: 42,
              height: 42,
              child: new ClipOval(
                  child: new FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                placeholder: '',
                image: document['image'],
              ))),
          onTap: () => _launchURL(document['url']),
          title: new Text(document['name']),
          subtitle: document['city'] != null && document['country'] != null
              ? new Text(document['city'] + ", " + document['country'])
              : null,
        ),
        new Padding(
          padding: const EdgeInsets.only(
            left: 74.0,
          ),
          child: new Divider(
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
