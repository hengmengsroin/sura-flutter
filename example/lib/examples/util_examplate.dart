import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class SuraUtilExamples extends StatefulWidget {
  SuraUtilExamples({Key key}) : super(key: key);
  @override
  _SuraUtilExamplesState createState() => _SuraUtilExamplesState();
}

class _SuraUtilExamplesState extends State<SuraUtilExamples> {
  TokenPayload tokenPayload;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sura Utils')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${tokenPayload?.toString()}"),
            Text("Is expired: ${tokenPayload?.isExpired}")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            tokenPayload = SuraJwtDecoder.decode(token);
          });
        },
        child: Icon(Icons.connected_tv),
      ),
    );
  }
}

String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c";
