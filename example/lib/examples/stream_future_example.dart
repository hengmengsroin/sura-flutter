import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class StreamAndFutureExample extends StatefulWidget {
  const StreamAndFutureExample({Key? key}) : super(key: key);

  @override
  State<StreamAndFutureExample> createState() => _StreamAndFutureExampleState();
}

class _StreamAndFutureExampleState extends State<StreamAndFutureExample> {
  StreamController<int> numberCtl = StreamController();
  late Future<int> futureData = getNumber();

  Future<int> getNumber() async {
    await SuraUtils.wait(2400);
    numberCtl.add(20);
    return 10;
  }

  @override
  void dispose() {
    numberCtl.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Future and Stream Builder")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SuraFutureHandler<int>.function(
              futureFunction: getNumber,
              ready: (data) {
                return Text("Data: $data");
              },
            ),
            const SpaceY(24),
            SuraFutureHandler<int>(
              future: futureData,
              loading: const CupertinoActivityIndicator(),
              ready: (data) {
                return Text("Data: $data");
              },
            ),
            const SpaceY(24),
            SuraStreamHandler<int>(
              stream: numberCtl.stream,
              ready: (data) {
                return Text("Data: $data");
              },
            ),
          ],
        ),
      ),
    );
  }
}
