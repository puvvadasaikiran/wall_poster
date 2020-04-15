import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

void main() => runApp(MaterialApp(
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpapersList;

  final CollectionReference collectionReference =
      Firestore.instance.collection("wallpapers");

  @override
  void initState() {
    initiate();
    subscription = collectionReference.snapshots().listen((datasnapshop) {
      setState(() {
        wallpapersList = datasnapshop.documents;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'WallPostr',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            print('Hell');
                          })
                    ],
                  ),
                ),
              ),
              wallpapersList != null
                  ? Container(
                      height: MediaQuery.of(context).size.height - 74,
                      padding: const EdgeInsets.all(20.0),
                      child: GridView.builder(
                        semanticChildCount: 113,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 2 / 2.1,
                        ),
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          return Container(
                            // height: 300,
                            // margin: EdgeInsets.only(bottom: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      wallpapersList[index].data['url']),
                                  fit: BoxFit.cover),
                            ),
                          );
                        },
                        itemCount: wallpapersList.length,
                      ),
                    )
                  : Container(
                      child: Center(
                        child: Text('No '),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void initiate() async {
    // Make API call to Hackernews homepage
    

    Response response = await client.get(
      'https://irobot.in/request.aspx?id=order000001030',
    );
    print(response.body);

    // Use html parser
    // var document = parser.parse(response.body);
    // List<Element> links = document.querySelectorAll('td.title > a.storylink');
    // List<Map<String, dynamic>> linkMap = [];

    // for (var link in links) {
    //   linkMap.add({
    //     'title': link.text,
    //     'href': link.attributes['href'],
    //   });
    // }

    // print(json.encode(linkMap));
  }
}
