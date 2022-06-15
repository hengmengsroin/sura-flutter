import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:sura_flutter_example/examples/other_widget_example.dart';
import 'package:sura_flutter_example/examples/stream_future_example.dart';

import 'examples/buttons_example.dart';
import 'examples/dialog_popup_example.dart';
import 'examples/mixin_example.dart';
import 'examples/sura_accordion_and_sura_expandable.dart';
import 'examples/tab_indicator_decoration.dart';
import 'examples/util_example.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuraProvider(
      ellipsisText: "No data",
      child: MaterialApp(
        title: 'SuraFlutter Example',
        navigatorKey: SuraNavigator.navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          typography: Typography.material2018(),
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
        builder: (context, child) {
          return SuraResponsiveBuilder(
            builder: (context) => LoadingOverlayBuilder(
              child: child!,
            ),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SuraFormMixin {
  void onViewPage(Widget page) {
    SuraPageNavigator.push(context, page);
  }

  @override
  Widget build(BuildContext context) {
    final List<ExampleButton> examples = [
      ExampleButton(
        name: "Sura Buttons example",
        child: const ButtonsExample(),
      ),
      ExampleButton(
        name: "Sura Accordion and Expandable",
        child: const SuraAccordionAndExpandable(),
      ),
      ExampleButton(
        name: "Sura Utils",
        child: const SuraUtilExamples(),
      ),
      ExampleButton(
        name: "Tab Indicator and Decoration",
        child: const TabIndicatorAndDecorationExample(),
      ),
      ExampleButton(
        name: "Other widgets example",
        child: const OtherWidgetsExample(),
      ),
      ExampleButton(
        name: "Dialog and Popup",
        child: const DialogPopupExample(),
      ),
      ExampleButton(
        name: "Mixin example",
        child: const MixinExample(),
      ),
      ExampleButton(
        name: "Future and Stream Handler example",
        child: const StreamAndFutureExample(),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sura Flutter Example"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: examples.map((example) {
            return SuraAsyncButton(
              child: Text(example.name),
              height: 50,
              margin: const EdgeInsets.only(top: 16),
              onPressed: () => onViewPage(example.child),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ExampleButton {
  final String name;
  final Widget child;

  ExampleButton({required this.name, required this.child});
}
