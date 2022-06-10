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
                children: const [
                  NotifierWrapper(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotifierWrapper extends StatelessWidget {
  const NotifierWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueNotifierWrapper<bool>(
      initialValue: true,
      builder: (notifier, value, child) {
        return Column(
          children: [
            Text("Value is: $value"),
            TextButton(
              onPressed: () {
                notifier.value = !notifier.value;
              },
              child: const Text("Change"),
            ),
          ],
        );
      },
    );
  }
}
