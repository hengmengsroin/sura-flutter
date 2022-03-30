import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:sura_flutter_example/examples/other_buttons_example.dart';
import 'package:sura_flutter_example/examples/sura_accordian_and_sura_expandable.dart';
import 'package:sura_flutter_example/examples/tab_indicator_decoration.dart';

import 'examples/util_example.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sura Flutter Example',
      navigatorKey: SuraNavigator.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        typography: Typography.material2018(),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      builder: (context, child) {
        debugPrint(context.mediaQuery.toString());
        return SuraResponsiveBuilder(builder: (context) => child!);
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SuraFormMixin {
  void onViewPage(Widget page) {
    SuraPageNavigator.push(context, page);
  }

  final List<ExampleButton> examples = [
    ExampleButton(
      name: "Sura Buttons example",
      child: OtherButtonExample(),
    ),
    ExampleButton(
      name: "Sura Accordion and Expandable",
      child: SuraAccordianAndExpandable(),
    ),
    ExampleButton(
      name: "Sura Utils",
      child: SuraUtilExamples(),
    ),
    ExampleButton(
      name: "Tab Indicator and Decoration",
      child: TabIndicatorAndDecorationExample(),
    ),
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
        title: Text("Sura Flutter Example"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: examples.map((example) {
            return SuraAsyncButton(
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

  ExampleButton({required this.name, required this.child});
}
