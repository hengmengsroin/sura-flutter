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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SuraAccordion and SuraExpandable')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SuraAccordion(
              title: const Text("SuraAccordion"),
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
            const SuraExpandable(
              padding: EdgeInsets.zero,
              topChild: SuraListTile(
                title: Text("SuraExpandable"),
                subtitle: Text("Click this to show more content"),
                trailing: Icon(Icons.arrow_circle_down),
              ),
              bottomChild: SuraListTile(
                title: Text("To show this"),
                leading: SuraPlatformChecker(androidWidget: CircleAvatar()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
