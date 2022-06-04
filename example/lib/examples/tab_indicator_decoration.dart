import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class TabIndicatorAndDecorationExample extends StatefulWidget {
  const TabIndicatorAndDecorationExample({Key? key}) : super(key: key);

  @override
  _TabIndicatorAndDecorationExampleState createState() =>
      _TabIndicatorAndDecorationExampleState();
}

class _TabIndicatorAndDecorationExampleState
    extends State<TabIndicatorAndDecorationExample>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tab Indicator and Decoration"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildUnderLineTabIndicatorTabBar(),
          const SpaceY(24),
          buildDotTabIndicatorTabBar(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Username",
                helperStyle: TextStyle(color: Colors.red),
                helperText: "Username is not allow to be empty",
                border: ShadowInputBorder(
                  elevation: 2.0,
                  fillColor: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildUnderLineTabIndicatorTabBar() {
    return TabBar(
      labelColor: Colors.blue,
      isScrollable: true,
      unselectedLabelColor: Colors.grey,
      indicator: const SmallUnderLineTabIndicator(
        color: Colors.blue,
        paddingLeft: 16,
      ),
      tabs: const [
        Tab(text: "Car"),
        Tab(text: "Bike"),
        Tab(text: "Boat"),
      ],
      controller: tabController,
    );
  }

  Widget buildDotTabIndicatorTabBar() {
    return TabBar(
      labelColor: Colors.blue,
      //isScrollable: true,
      unselectedLabelColor: Colors.grey,
      indicator: const DotTabIndicator(
        color: Colors.blue,
      ),
      tabs: const [
        Tab(text: "Car"),
        Tab(text: "Bike"),
        Tab(text: "Boat"),
      ],
      controller: tabController,
    );
  }
}
