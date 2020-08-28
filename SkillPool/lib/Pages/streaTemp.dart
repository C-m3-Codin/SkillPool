import 'package:flutter/material.dart';

new StreamBuilder(
    stream: Firestore.instance.collection("collection").snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Text(
          'No Data...',
        );
      } else { 
          <DocumentSnapshot> items = snapshot.data.documents;

          return Text("DATA") 
          // Lost_Card(
          // headImageAssetPath : items[0]["url"]
          // );
      }



       return new ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.documents[index];
              return new Lost_Card(
                headImageAssetPath : ds["url"];

);



