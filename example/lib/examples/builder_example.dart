import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class SuraBuilderExample extends StatefulWidget {
  @override
  _SuraBuilderExampleState createState() => _SuraBuilderExampleState();
}

class _SuraBuilderExampleState extends State<SuraBuilderExample> {
  FutureManager<int> counterManager = FutureManager();
  AsyncSubjectManager<int> counterSubject = AsyncSubjectManager();
  Future<int> counterFuture;
  ValueNotifier<int> counterNotifier = ValueNotifier(0);

  Future<int> fetchNumber([int data = 10]) async {
    await Future.delayed(Duration(seconds: 2));
    counterNotifier.value = data;
    counterManager.update(data);
    counterSubject.addData(data);
    return data;
  }

  @override
  void initState() {
    counterFuture = fetchNumber();

    //use asyncOperation to handle try catch
    //counterManager.asyncOperation(() => fetchNumber());
    //counterSubject.asyncOperation(() => fetchNumber());
    super.initState();
  }

  @override
  void dispose() {
    counterNotifier.dispose();
    counterSubject.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sura Builders Example")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuilderSection(
              title: "FutureManagerBuilder",
              child: FutureManagerBuilder<int>(
                futureManager: counterManager,
                ready: (context, count) => buildResult(count),
              ),
            ),
            BuilderSection(
              title: "SuraFutureHandler",
              child: SuraFutureHandler<int>(
                future: counterFuture,
                ready: (count) => buildResult(count),
              ),
            ),
            BuilderSection(
              title: "SuraStreamHandler",
              child: SuraStreamHandler(
                stream: counterSubject.stream,
                ready: (count) => buildResult(count),
              ),
            ),
            BuilderSection(
              title: "SuraNotifier",
              child: SuraNotifier<int>(
                valueNotifier: counterNotifier,
                builder: (count) => buildResult(count),
              ),
            ),
            SuraAsyncButton(
              child: Text("Update value"),
              margin: EdgeInsets.symmetric(vertical: 16),
              onPressed: () async {
                /// we have to use setState here to update a Future value
                setState(() {
                  counterFuture = fetchNumber(20);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResult(int data) {
    return Text("Number is: $data");
  }
}

class BuilderSection extends StatelessWidget {
  final String title;
  final Widget child;

  const BuilderSection({Key key, this.title, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Text(title),
          SpaceY(16),
          child,
        ],
      ),
    );
  }
}
