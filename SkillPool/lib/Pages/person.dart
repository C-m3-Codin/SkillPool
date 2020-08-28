// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersonDeets extends StatefulWidget {
  // @override
  final String docStr;
  PersonDeets({this.docStr});

  // @override
  // State<StatefulWidget> createState() {
  //   // TODO: implement createState
  //   throw UnimplementedError();
  // }

  @override
  _PersonDeetsState createState() => _PersonDeetsState();
}

class _PersonDeetsState extends State<PersonDeets> {
  var data;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: StreamBuilder(
            // ignore: deprecated_member_use
            stream: Firestore.instance.collection("Skills").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                // return Center(child: CircleAvatar(),);
                return CircularProgressIndicator();
              else {
                for (var i = 0; i < snapshot.data.documents.length; i++) {
                  print("\n\n\n$i\n here we are at $i\n\n");
                  print(
                      "\n\n\nsearching for ${widget.docStr} here we are at \n\n");
                  print(
                      "\n\n\COMPARING WITH for ${snapshot.data.documents[i].get("docStr").toString()} here we are at \n\n");

                  if (snapshot.data.documents[i].get("docStr").toString() ==
                      widget.docStr) {
                    // print(object)
                    print("\n\n\n\n\t\tMatch Found Yay\n\n\n\n\n");
                    // return Column(
                    //   children: [
                    //     Text("Here"),
                    //     Text(snapshot.data.documents[i].get("CP").toString()),
                    //     Text(snapshot.data.documents.length.toString()),
                    //   ],
                    // );

                    return SingleChildScrollView(
                      child: Column(children: <Widget>[
                        Container(
                            decoration: BoxDecoration(),
                            child: Container(
                                width: double.infinity,
                                height: 150.0,
                                child: Center(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                      CircleAvatar(
                                        backgroundImage: NetworkImage((snapshot
                                                    .data.documents[i]
                                                    .get("pic") !=
                                                "-1")
                                            ? (snapshot.data.documents[i]
                                                .get("pic"))
                                            : ("https://upload.wikimedia.org/wikipedia/commons/d/de/Mpgh-annon.png")),
                                        radius: 50.0,
                                      ),
                                    ])))),
                        Card(
                          child: ListTile(
                              title: Text((snapshot.data.documents[i]
                                  .get("name")
                                  .toString()))),
                        ),
                        // Card(
                        //   child: ListTile(
                        //       title: Text((snapshot.data.documents[i]
                        //           .get("CP")
                        //           .toString()))),
                        // ),
                        // Card(
                        //   child: ListTile(
                        //       title: Text((snapshot.data.documents[i]
                        //           .get("CP")
                        //           .toString()))),
                        // ),
                        // Card(
                        //   child: ListTile(
                        //       title: Text((snapshot.data.documents[i]
                        //           .get("CP")
                        //           .toString()))),
                        // ),
                      ]),
                    );
                  }
                }
                print("\n\n\n\n\t\tMatch Not Found Nooo\n\n\n\n\n");
                print("\n\n\n\n\nEntered Else\n\n\n\n\n");
                return Column(
                  children: [
                    Text("Here"),
                    // Text(snapshot.data.documents[1].get("CP").toString()),
                    Text(snapshot.data.documents.length.toString()),
                    Text(widget.docStr),
                  ],
                );
              }
            }));
  }
}
