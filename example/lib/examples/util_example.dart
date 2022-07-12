import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class SuraUtilExamples extends StatefulWidget {
  const SuraUtilExamples({Key? key}) : super(key: key);

  @override
  _SuraUtilExamplesState createState() => _SuraUtilExamplesState();
}

class _SuraUtilExamplesState extends State<SuraUtilExamples> {
  void extensionExample() {
    var array = [1, 2, 3];
    Map<String, dynamic> data = {};
    data.addIfNotNull("age", 2);
    array.findOne((p0) => p0 == 2);
  }

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
    );
  }
}
