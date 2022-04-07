import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class ButtonsExample extends StatefulWidget {
  const ButtonsExample({Key? key}) : super(key: key);

  @override
  _ButtonsExampleState createState() => _ButtonsExampleState();
}

class _ButtonsExampleState extends State<ButtonsExample> {
  final isLoading = ValueNotifier<bool>(false);

  SuraLoadingDialog? loadingDialog;
  var d = Debouncer();

  Future asyncCallbackOnPressed() async {
    infoLog();
    await Future.delayed(const Duration(seconds: 2));
  }

  Future onActionButtonClick() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
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
        title: const Text("Sura Buttons Example"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SpaceY(24),
            buildButtonCategory(
              name: "SuraIconButton",
              buttons: [
                SuraIconButton(
                  icon: const Icon(Icons.add_a_photo_rounded,
                      color: Colors.white),
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  onTap: () {},
                  badge: const SuraBadge(text: "2", radius: 8),
                  backgroundColor: Colors.orangeAccent,
                ),
                SuraIconButton(
                  icon: const Icon(Icons.add_alarm_rounded),
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  onTap: () {},
                ),
                SuraIconButton(
                  icon: const Icon(Icons.add_alarm_rounded),
                  borderSide: const BorderSide(),
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  onTap: () {},
                ),
                SuraIconButton(
                  icon: const Icon(Icons.add_alarm_rounded),
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  onTap: () {
                    LoadingOverlayProvider.toggle();
                  },
                  badge: const SuraBadge(text: "2"),
                ),
              ],
            ),
            buildButtonCategory(
              name: "SuraAsyncIconButton",
              buttons: [
                SuraAsyncIconButton(
                  icon: const Icon(Icons.add),
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  onTap: asyncCallbackOnPressed,
                )
              ],
            ),
            buildButtonCategory(
              name: "SuraFlatButton",
              buttons: [
                SuraFlatButton(
                  icon: const Icon(Icons.add_a_photo_rounded,
                      color: Colors.white),
                  child: const Text("Click me").textColor(),
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  onPressed: asyncCallbackOnPressed,
                  backgroundColor: Colors.lightGreen,
                ),
                SuraFlatButton(
                  child: const Text("No Icon"),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  onPressed: asyncCallbackOnPressed,
                ),
                const EllipsisText(null),
              ],
            ),
            buildButtonCategory(
              name: "SuraRaisedButton",
              buttons: [
                SuraRaisedButton(
                  loadingNotifier: isLoading,
                  icon: const Icon(Icons.notifications, color: Colors.white),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  onPressed: onActionButtonClick,
                  child: const Text("Click me"),
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
                    const Text("Loading type: Disable"),
                    SuraAsyncButton(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 64),
                      onPressed: asyncCallbackOnPressed,
                      child: const Text("Click me"),
                      fullWidth: false,
                      loadingType: LoadingType.disable,
                    ),
                    const SpaceY(24),
                    const Text("Loading type: Progress"),
                    SuraAsyncButton(
                      onPressed: asyncCallbackOnPressed,
                      child: const Text("Click me"),
                      loadingType: LoadingType.progress,
                      height: SuraResponsive.value(50, 60, 70),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonCategory({
    required String name,
    required List<Widget> buttons,
  }) {
    return Column(
      children: [
        Text(name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SpaceY(),
        Row(
          children: buttons.map((button) => Flexible(child: button)).toList(),
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        const Divider(),
      ],
    );
  }
}
