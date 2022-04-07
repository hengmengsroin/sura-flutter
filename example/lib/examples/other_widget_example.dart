import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class OtherWidgetsExample extends StatefulWidget {
  const OtherWidgetsExample({Key? key}) : super(key: key);

  @override
  State<OtherWidgetsExample> createState() => _OtherWidgetsExampleState();
}

class _OtherWidgetsExampleState extends State<OtherWidgetsExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SuraToolbar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
