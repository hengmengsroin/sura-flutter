import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class DialogPopupExample extends StatefulWidget {
  const DialogPopupExample({Key? key}) : super(key: key);

  @override
  State<DialogPopupExample> createState() => _DialogPopupExampleState();
}

class _DialogPopupExampleState extends State<DialogPopupExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dialog and Popup Example")),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          SuraAsyncButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return const SuraSimpleDialog(
                    content:
                        "By using our package, You agree to our term and condition",
                    title: "Information",
                    confirmText: "Yes",
                  );
                },
              );
            },
            child: const Text("Show SuraSimpleDialog"),
          ),
          SuraAsyncButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return const SuraConfirmationDialog(
                    content: Text("Are you sure you want to logout?"),
                    title: "Information",
                    swapButtonsPosition: true,
                    confirmText: "No",
                    cancelText: "Logout",
                  );
                },
              );
            },
            child: const Text("Show SuraConfirmationDialog"),
          ),
          SuraAsyncButton(
            onPressed: () async {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return SuraActionSheet(
                    title: "Choose image source",
                    options: const ["Gallery", "Camera"],
                    builder: (option, index) => EllipsisText(option),
                  );
                },
              );
            },
            child: const Text("Show SuraActionSheet"),
          ),
        ],
      ),
    );
  }
}
