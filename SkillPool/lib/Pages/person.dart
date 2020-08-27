class PersonDeets extends StatefulWidget {
  @override
  final String docStr;
  PersonDeets({this.docStr});

  @override
  _PersonDeetsState createState() => _PersonDeetsState();
}

class _PersonDeetsState extends State<PersonDeets> {
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Container(child: Text(widget.docStr))));
  }
}
