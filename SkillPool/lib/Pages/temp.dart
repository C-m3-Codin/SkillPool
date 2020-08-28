import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ExpansionTile Test',
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<http.Response> _responseFuture;

  @override
  void initState() {
    super.initState();
    _responseFuture = http.get('http://174.138.61.246:8080/support/dc/1');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ExpansionTile Test'),
      ),
      body: new FutureBuilder(
        future: _responseFuture,
        builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
          if (!response.hasData) {
            return const Center(
              child: const Text('Loading...'),
            );
          } else if (response.data.statusCode != 200) {
            return const Center(
              child: const Text('Error loading data'),
            );
          } else {
            List<dynamic> json = JSON.decode(response.data.body);
            return new MyExpansionTileList(json);
          }
        },
      ),
    );
  }
}

class MyExpansionTileList extends StatelessWidget {
  final List<dynamic> elementList;

  MyExpansionTileList(this.elementList);

  List<Widget> _getChildren() {
    List<Widget> children = [];
    elementList.forEach((element) {
      children.add(
        new MyExpansionTile(element['did'], element['dname']),
      );
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: _getChildren(),
    );
  }
}

class MyExpansionTile extends StatefulWidget {
  final int did;
  final String name;
  MyExpansionTile(this.did, this.name);
  @override
  State createState() => new MyExpansionTileState();
}

class MyExpansionTileState extends State<MyExpansionTile> {
  PageStorageKey _key;
  Future<http.Response> _responseFuture;

  @override
  void initState() {
    super.initState();
    _responseFuture =
        http.get('http://174.138.61.246:8080/support/dcreasons/${widget.did}');
  }

  @override
  Widget build(BuildContext context) {
    _key = new PageStorageKey('${widget.did}');
    return new ExpansionTile(
      key: _key,
      title: new Text(widget.name),
      children: <Widget>[
        new FutureBuilder(
          future: _responseFuture,
          builder:
              (BuildContext context, AsyncSnapshot<http.Response> response) {
            if (!response.hasData) {
              return const Center(
                child: const Text('Loading...'),
              );
            } else if (response.data.statusCode != 200) {
              return const Center(
                child: const Text('Error loading data'),
              );
            } else {
              List<dynamic> json = JSON.decode(response.data.body);
              List<Widget> reasonList = [];
              json.forEach((element) {
                reasonList.add(new ListTile(
                  dense: true,
                  title: new Text(element['reason']),
                ));
              });
              return new Column(children: reasonList);
            }
          },
        )
      ],
    );
  }
}
