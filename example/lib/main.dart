import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:sura_flutter_example/examples/other_buttons_example.dart';
import 'package:sura_flutter_example/examples/sura_accordian_and_sura_expandable.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sura Flutter Example',
      navigatorKey: SuraNavigator.navigatorKey,
      theme: ThemeData(
        primarySwatch: SuraColor.toMaterial(0xFF4A6A2F),
        typography: Typography.material2018(),
        buttonColor: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SuraFormMixin {
  void onViewPage(Widget page) {
    PageNavigator.push(context, page);
  }

  final List<ExampleButton> examples = [
    ExampleButton(name: "Other Buttons example", child: OtherButtonExample()),
    ExampleButton(name: "Accordion", child: SuraAccordianAndExpandable()),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jin Widget Helper Example"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: examples.map((example) {
            return SuraRaisedButton(
              child: Text(example.name),
              fullWidth: true,
              margin: EdgeInsets.only(top: 16),
              onPressed: () => onViewPage(example.child),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ExampleButton {
  String name;
  Widget child;

  ExampleButton({this.name, this.child});
}
