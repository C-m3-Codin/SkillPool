// import 'package:firebase/firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart
// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/'; // import 'package:cloud_firestore/';

class HomeSc extends StatefulWidget {
  @override
  _HomeScState createState() => _HomeScState();
}

class _HomeScState extends State<HomeSc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Skill Pool",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.network(
                      "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: SkillList()),
      floatingActionButton: FloatingActionButton(onPressed: () {
        final firestoreInstance = Firestore.instance;
        firestoreInstance
            .collection("Ban")
            .getDocuments()
            .then((querySnapshot) {
          querySnapshot.documents.forEach((result) {
            print("for each here \n\n\n\\n" + result.data.toString());
          });
        });
      }),
    );
  }
}

class SkillList extends StatefulWidget {
  const SkillList({
    Key key,
  }) : super(key: key);

  @override
  _SkillListState createState() => _SkillListState();
}

class _SkillListState extends State<SkillList> {
  Future getSkills() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Skl").getDocuments();
    print("\n\n\n\nSlill\n\n\n\n");
    print(qn);
    print("\n\n\n\nSlill\n\n\n\n");

    firestore.collection("Skl").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        print(result.data);
      });
    });

    return qn.documents;
  }

  Future data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getSkills();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Text("Loading");
            else {
              // return ListView.builder(
              //     itemCount: snapshot.data.length,
              //     itemBuilder: (_, index) {
              //       final item = snapshot.data[index];
              //       // print("\n\n\n\n" + snapshot.data);
              //       // print("\n\n\n\n\n\ns" + snapshot.data[index].data["name"]);
              //       return

              print(snapshot.data.toString());
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) =>
                      SkillPeople(snapshot.data[index]));
            }
          }),
    );
  }
}

class SkillPeople extends StatefulWidget {
  final DocumentSnapshot snapshot;
  SkillPeople(this.snapshot);

  @override
  _SkillPeopleState createState() => _SkillPeopleState();
}

class _SkillPeopleState extends State<SkillPeople> {
  List<String> people = ["Loading"];
  Map<String, dynamic> get skil {
    return widget.snapshot.data();
  }

  Widget get nam {
    return Text("${skil["name"]}");
  }

  Widget get pplList {
    return ListView.builder(
        itemCount: skil["People"].length,
        itemBuilder: (context, index) {
          return Text(skil["People"].data["name"]);
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    skil.forEach((key, value) {
      print("value:" + key + "\t" + value);
      people.add(value);
    });
    print("\n\n\n");
    print("People length  + ${people.length}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: nam,
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: people.length,
            itemBuilder: (_, index) {
              print(
                  "\n\n\n\n\n\n\n\n\ TAB ${people.length}\n\n\n\n\n\n\n\n\n\n\n\n\n");
              return Text(people[index]);
            })
      ],
    );
  }
}
