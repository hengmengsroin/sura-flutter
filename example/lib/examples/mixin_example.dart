import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class MixinExample extends StatefulWidget {
  const MixinExample({Key? key}) : super(key: key);

  @override
  State<MixinExample> createState() => _MixinExampleState();
}

class _MixinExampleState extends State<MixinExample> with BoolNotifierMixin, SuraFormMixin, AfterBuildMixin {
  @override
  void afterBuild(BuildContext context) {
    infoLog("This method called after build");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mixin Example")),
      body: KeyboardDismiss(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: ((value) {
                    return SuraFormValidator.validateField(value, field: "username");
                  }),
                  decoration: const InputDecoration(hintText: "Username"),
                ),
                const SpaceY(16),
                TextFormField(
                  validator: ((value) {
                    return SuraFormValidator.isNumber(value, field: "age");
                  }),
                  decoration: const InputDecoration(hintText: "Age"),
                ),
                const SpaceY(16),
                TextFormField(
                  validator: ((value) {
                    return SuraFormValidator.validateEmail(value, field: "email");
                  }),
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                const SpaceY(16),
                PasswordTextFieldBuilder(
                  builder: (obscure) {
                    return TextFormField(
                      obscureText: obscure,
                      initialValue: "mypassword",
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
                          onPressed: togglePasswordObscure,
                        ),
                      ),
                    );
                  },
                ),
                SuraRaisedButton(
                  padding: const EdgeInsets.all(24),
                  shape: const RoundedRectangleBorder(),
                  onPressed: () async {
                    if (true) {
                      toggleValue();
                      await SuraUtils.wait(2000);
                      toggleValue(false);
                    }
                  },
                  loadingNotifier: boolNotifier,
                  child: const Text("Loading using BoolNotifier"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
