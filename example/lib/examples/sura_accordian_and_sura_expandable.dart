import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class SuraAccordianAndExpandable extends StatefulWidget {
  SuraAccordianAndExpandable({Key key}) : super(key: key);
  @override
  _SuraAccordianAndExpandableState createState() =>
      _SuraAccordianAndExpandableState();
}

class _SuraAccordianAndExpandableState
    extends State<SuraAccordianAndExpandable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SuraAccordion(
              title: Text("Members"),
              childrenPadding: EdgeInsets.zero,
              children: List.generate(
                10,
                (index) => SuraListTile(
                  title: Text("Name"),
                  onTap: () {},
                  leading: CircleAvatar(),
                ),
              ),
            ),
            SuraExpandable(
              topChild: SuraListTile(
                title: Text("Click this"),
                leading: CircleAvatar(),
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
