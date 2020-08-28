// import 'package:firebase/firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart
// import 'dart:js';

import 'package:SkillPool/Pages/person.dart';
import 'package:SkillPool/database/database.dart';
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
                      "https://scontent.fccu10-1.fna.fbcdn.net/v/t31.0-8/s960x960/20989033_112314066115856_1256227463991323205_o.jpg?_nc_cat=109&_nc_sid=e3f864&_nc_ohc=KIS9mL7Ff3YAX865oDL&_nc_ht=scontent.fccu10-1.fna&tp=7&oh=200d2249b2b640c6b802d0ce21515794&oe=5F6E187B",
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
              // return Text("loading");
              return CircularProgressIndicator();
            else {
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
  List<String> people = [];
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
      if (key != "name") {
        people.add(value);
      }
    });
    print("\n\n\n");
    print("People length  + ${people.length}");
    setState(() {});
  }

  navToUser(String DocString) {
    print("\n\n\n\n\n\n\n\nEntered nav to deets\n\n\n\n\t $DocString \n\n\n");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PersonDeets(
                  docStr: DocString,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: nam,
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: people.length,
            itemBuilder: (BuildContext context, index) {
              print(
                  "\n\n\n\n\n\n\n\ TAB ${people.length}\n\n\n\n\n\n\n\n\n\n\n\n\n");

              return ListTile(
                leading: Icon(
                  Icons.person,
                ),
                title:
                    Text(people[index].substring(0, people[index].length - 7)),
                // onTap: navToUser(people[index] + skil["name"]),
                onTap: () {
                  print(
                      "\n\n\n\n\n\n\nentered\n\n\n\n\pressed\n\ ${people[index]} \n\n\n");
                  String na = people[index];
                  navToUser(na);
                },
              );
            })
      ],
    );
  }
}
