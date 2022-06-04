import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class SuraAccordianAndExpandable extends StatefulWidget {
  const SuraAccordianAndExpandable({Key? key}) : super(key: key);

  @override
  _SuraAccordianAndExpandableState createState() =>
      _SuraAccordianAndExpandableState();
}

class _SuraAccordianAndExpandableState
    extends State<SuraAccordianAndExpandable> {
  int selectedAccordionIndex = 0;

  bool toggled = false;

  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SuraAccordion and SuraExpandable')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SuraAccordion(
              title: const Text("SuraAccordion"),
              value: toggled,
              onToggle: (value) {
                setState(() {
                  toggled = value;
                });
              },
              childrenPadding: EdgeInsets.zero,
              titleDecoration: const BoxDecoration(),
              children: List.generate(
                5,
                (index) => SuraListTile(
                  title: const Text("Flutter"),
                  onTap: () {},
                  leading: const CircleAvatar(child: Icon(Icons.sd_card)),
                ),
              ),
            ),
            const SpaceY(16),
            SuraExpandable(
              value: expanded,
              onToggle: (value) {
                setState(() {
                  expanded = value;
                });
              },
              padding: EdgeInsets.zero,
              topChild: const SuraListTile(
                title: Text("SuraExpandable"),
                subtitle: Text("Click this to show more content"),
                trailing: Icon(Icons.arrow_circle_down),
              ),
              bottomChild: const SuraListTile(
                title: Text("To show this"),
                leading: SuraPlatformChecker(androidWidget: CircleAvatar()),
              ),
            ),
            const Text("Accordion group"),
            const SpaceY(),
            for (var i in [1, 2, 3])
              SuraAccordion(
                title: Text("Number $i"),
                value: selectedAccordionIndex == i,
                onToggle: (value) {
                  setState(() {
                    selectedAccordionIndex = value ? i : 0;
                  });
                },
                childrenPadding: EdgeInsets.zero,
                titleDecoration: const BoxDecoration(),
                children: List.generate(
                  5,
                  (index) => SuraListTile(
                    title: const Text("Flutter"),
                    onTap: () {},
                    leading: const CircleAvatar(child: Icon(Icons.sd_card)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
