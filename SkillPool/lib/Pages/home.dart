// import 'package:firebase/firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart
import 'package:cloud_firestore/cloud_firestore.dart';
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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Skills").snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    print("\n\nreceivedvaye\n\n\n\n");
                    return new ExpansionTile(
                      title: new Text(
                        "het",
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      children: <Widget>[
                        new Column(
                          children: [Text("hhhh"), Text("haaaa")],
                        ),
                      ],
                    );
                  });
        });
  }
}

class _buildExpandableContent {}
