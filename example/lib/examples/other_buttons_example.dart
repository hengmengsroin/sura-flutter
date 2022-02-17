import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class OtherButtonExample extends StatefulWidget {
  @override
  _OtherButtonExampleState createState() => _OtherButtonExampleState();
}

class _OtherButtonExampleState extends State<OtherButtonExample> {
  final isLoading = ValueNotifier<bool>(false);

  SuraLoadingDialog? loadingDialog;

  Future onButtonClick() async {
    await Future.delayed(Duration(seconds: 2));
  }

  Future onActionButtonClick() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    isLoading.value = false;
  }

  @override
  void dispose() {
    isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loadingDialog = SuraLoadingDialog(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sura Buttons Example"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SpaceY(24),
            buildButtonCategory(
              name: "SuraIconButton",
              buttons: [
                SuraIconButton(
                  icon: Icon(Icons.add_a_photo_rounded, color: Colors.white),
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  onTap: () {},
                  badge: SuraBadge(text: "2"),
                  backgroundColor: Colors.orangeAccent,
                ),
                SuraIconButton(
                  icon: Icon(Icons.add_alarm_rounded),
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  onTap: () {},
                ),
                SuraIconButton(
                  icon: Icon(Icons.add_alarm_rounded),
                  borderSide: BorderSide(),
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  onTap: () {},
                ),
                SuraIconButton(
                  icon: Icon(Icons.add_alarm_rounded),
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  onTap: () {},
                  badge: SuraBadge(text: "2"),
                ),
              ],
            ),
            buildButtonCategory(
              name: "SuraFlatButton",
              buttons: [
                SuraFlatButton(
                  icon: Icon(Icons.add_a_photo_rounded, color: Colors.white),
                  child: Text("Click me").textColor(),
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  onPressed: onButtonClick,
                  backgroundColor: Colors.lightGreen,
                ),
                SuraFlatButton(
                  child: Text("No Icon"),
                  margin: EdgeInsets.symmetric(vertical: 4),
                  onPressed: onButtonClick,
                ),
              ],
            ),
            buildButtonCategory(
              name: "SuraRaisedButton",
              buttons: [
                SuraRaisedButton(
                  loadingNotifier: isLoading,
                  icon: Icon(Icons.notifications, color: Colors.white),
                  margin: EdgeInsets.symmetric(vertical: 4),
                  onPressed: onActionButtonClick,
                  child: Text("Click me"),
                  color: Colors.red,
                  fullWidth: false,
                )
              ],
            ),
            buildButtonCategory(
              name: "SuraAsyncButton",
              buttons: [
                Column(
                  children: [
                    Text("Loading type: Disable"),
                    SuraAsyncButton(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 64),
                      onPressed: onButtonClick,
                      child: Text("Click me"),
                      fullWidth: false,
                      loadingType: LoadingType.disable,
                    ),
                    SpaceY(24),
                    Text("Loading type: Progress"),
                    SuraAsyncButton(
                      margin: EdgeInsets.symmetric(horizontal: 64),
                      onPressed: onButtonClick,
                      child: Text("Click me"),
                      fullWidth: true,
                      loadingType: LoadingType.progress,
                      height: SuraResponsive.value(50, 60, 70),
                    ),
                  ],
                ),
              ],
            ),
            buildButtonCategory(
              name: "Action sheet",
              buttons: [
                SuraRaisedButton(
                  onPressed: () async {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return SuraActionSheet(
                          builder: (value, index) {
                            return Text("$value");
                          },
                          title: "title",
                          options: ["options"],
                        );
                      },
                    );
                  },
                  child: Text("Show action sheet"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonCategory(
      {required String name, required List<Widget> buttons}) {
    return Column(
      children: [
        Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        SpaceY(),
        Row(
          children: buttons.map((button) => Flexible(child: button)).toList(),
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Divider(),
      ],
    );
  }
}
