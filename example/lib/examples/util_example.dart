import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class SuraUtilExamples extends StatefulWidget {
  const SuraUtilExamples({Key? key}) : super(key: key);

  @override
  _SuraUtilExamplesState createState() => _SuraUtilExamplesState();
}

class _SuraUtilExamplesState extends State<SuraUtilExamples> {
  TokenPayload? tokenPayload;

  final ages = [1, 2, 3, 4, 5];
  Map data = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sura Utils')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.connected_tv),
      ),
    );
  }
}
