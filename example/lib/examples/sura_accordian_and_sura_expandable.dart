import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class SuraAccordianAndExpandable extends StatefulWidget {
  SuraAccordianAndExpandable({Key? key}) : super(key: key);
  @override
  _SuraAccordianAndExpandableState createState() =>
      _SuraAccordianAndExpandableState();
}

class _SuraAccordianAndExpandableState
    extends State<SuraAccordianAndExpandable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SuraAccordion and Expandable')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SuraAccordion(
              title: Text("SuraAccordion"),
              childrenPadding: EdgeInsets.zero,
              titleDecoration: BoxDecoration(),
              children: List.generate(
                5,
                (index) => SuraListTile(
                  title: Text("Flutter"),
                  onTap: () {},
                  leading: CircleAvatar(child: Icon(Icons.sd_card)),
                ),
              ),
            ),
            SpaceY(16),
            SuraExpandable(
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
            TextFormField(
              validator: (value) {},
            )
          ],
        ),
      ),
    );
  }
}
