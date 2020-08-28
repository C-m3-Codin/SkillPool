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

  // Future getPersonDe3ts(String PerVal) async {
  //   // docStr = "aa";
  //   print("\n\n\n\n\n\n entered \n\n\n\n");
  //   var firestore = Firestore.instance;
  //   // QuerySnapshot qn = await firestore.collection('Skills').getDocuments();

  //   // print(qn);
  //   // print("\n\n\n\nSlill\n\n\n\n");
  //   // final firestoreInstance = Firestore.instance;
  //   // firestoreInstance.collection("Skills").getDocuments().then((querySnapshot) {
  //   //   querySnapshot.documents.forEach((result) {
  //   //     print(result.data);
  //   // //   });
  //   // });
  //   print("\n\n\\n\n\n\nExiting the get state\n\n\n");
  //   return "aaa";
  // }

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
                return Text("nothing yet");
              else {
                for (var i = 0; i < snapshot.data.documents.length; i++) {
                  print("\n\n\n$i\n\n\nR");
                  if (snapshot.data.documents[i].get("CP").toString() ==
                      widget.docStr) {
                    print("\n\n\n\n\t\tMatch Found Yay\n\n\n\n\n");
                    return Column(
                      children: [
                        Text("Here"),
                        Text(snapshot.data.documents[i].get("CP").toString()),
                        Text(snapshot.data.documents.length.toString()),
                      ],
                    );
                  }
                }
                print("\n\n\n\n\t\tMatch Not Found Nooo\n\n\n\n\n");
                print("\n\n\n\n\nEntered Else\n\n\n\n\n");
                return Column(
                  children: [
                    Text("Here"),
                    Text(snapshot.data.documents[1].get("CP").toString()),
                    Text(snapshot.data.documents.length.toString()),
                    Text(widget.docStr),
                  ],
                );
              }
            }));
  }
}
