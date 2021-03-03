import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class OtherButtonExample extends StatefulWidget {
  @override
  _OtherButtonExampleState createState() => _OtherButtonExampleState();
}

class _OtherButtonExampleState extends State<OtherButtonExample> {
  final isLoading = ValueNotifier<bool>(false);

  SuraLoadingDialog loadingDialog;

  @override
  void dispose() {
    isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loadingDialog = SuraLoadingDialog(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SuraToolbar(
              title: "Header",
              //icon: Icon(Icons.arrow_back_ios),
              titleAlignment: Alignment.centerLeft,
              backgroundColor: Colors.lightBlueAccent,
            ),
            SpaceY(),
            buildButtonCategory(
              name: "Sura Icon Button",
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
              name: "Sura Flat Button",
              buttons: [
                SuraFlatButton(
                  icon: Icon(Icons.add_a_photo_rounded, color: Colors.white),
                  child: Text("Click me").textColor(),
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SuraConfirmationDialog(
                          content: Text("You sure?"),
                          swapButtonsPosition: true,
                          onConfirm: () {
                            print("confirm");
                          },
                          onCancel: () {
                            print("cancel");
                          },
                        );
                      },
                    );
                  },
                  backgroundColor: Colors.lightGreen,
                ),
                SuraFlatButton(
                  child: Text("No Icon"),
                  margin: EdgeInsets.symmetric(vertical: 4),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SuraSimpleDialog(
                          content: "You sure?",
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            buildButtonCategory(
              name: "Action Button",
              buttons: [
                SuraRaisedButton(
                  loadingNotifier: isLoading,
                  icon: Icon(Icons.notifications, color: Colors.white),
                  margin: EdgeInsets.symmetric(vertical: 4),
                  onPressed: () async {
                    isLoading.value = true;
                    loadingDialog.show();
                    await Future.delayed(Duration(seconds: 3));
                    loadingDialog.hide();
                    isLoading.value = false;
                  },
                  child: Text("Click me"),
                  color: Colors.red,
                  fullWidth: false,
                )
              ],
            ),
            buildButtonCategory(
              name: "Sura Async Button",
              buttons: [
                SuraAsyncButton(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 45),
                  onPressed: () async {
                    isLoading.value = true;
                    await Future.delayed(Duration(seconds: 3));
                    isLoading.value = false;
                  },
                  child: Text("Click me"),
                  fullWidth: true,
                  loadingType: LoadingType.Disable,
                ),
              ],
            ),
            buildButtonCategory(
              name: "Sura Async Button",
              buttons: [
                SuraAsyncButton(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 45),
                  elevation: 0.0,
                  loadingColor: Colors.red,
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    isLoading.value = true;
                    await Future.delayed(Duration(seconds: 3));
                    isLoading.value = false;
                  },
                  child: Text(
                    "Click me",
                    style: TextStyle(color: Colors.red),
                  ),
                  fullWidth: true,
                  startIcon: Icon(Icons.add, color: Colors.red),
                  alignment: MainAxisAlignment.start,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonCategory({String name, List<Widget> buttons}) {
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
