// import 'dart:html';
import 'package:url_launcher/url_launcher.dart';

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
  Future<void> _launched;
  String _phone = '';

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget build(BuildContext context) {
    // const String toLaunch = 'https://www.cylog.org/headers/';
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
                      physics: ScrollPhysics(),
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
                              title: Text(
                            (snapshot.data.documents[i].get("name").toString()),
                            textAlign: TextAlign.center,
                          )),
                        ),
                        ListTile(
                          leading: Text("busy"),
                          title: Text(snapshot.data.documents[i].get("busy")
                              ? "yes"
                              : "no"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              onPressed: () => setState(() {
                                _phone = snapshot.data.documents[i]
                                    .get("number")
                                    .toString();

                                _launched = _makePhoneCall('tel:$_phone');
                              }),
                              child: const Text('Make phone call'),
                            ),
                            Text("Contact whatsapp")
                          ],
                        ),
                        // const Padding(
                        //   padding: EdgeInsets.all(16.0),
                        //   child: Text(toLaunch),
                        // ),
                        // Card(
                        //   child: ListTile(
                        //       title: Text((snapshot.data.documents[i]
                        //           .get("CP")
                        //           .toString()))),
                        // ),
                        // ListView.builder(itemBuilder: (_.))
                        ListView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                snapshot.data.documents[i].get("works").length,
                            itemBuilder: (context, index) {
                              print((snapshot.data.documents[i]
                                  .get("works")[index]));
                              return ListTile(
                                  leading: Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  ),
                                  title: Text(snapshot.data.documents[i]
                                      .get("works")[index]));
                              // rpint("asd");

                              // SkillPeople(snapshot.data[index]));
                            })
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
