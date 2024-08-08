import 'package:alivechms/constants/widgets/app_titlebar.dart';
import 'package:alivechms/constants/widgets/hero_image.dart';
import 'package:alivechms/controllers/app_state.dart';
import 'package:alivechms/screens/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(builder: (context, appState, child) {
      return Scaffold(
        persistentFooterButtons: const [
          Text("AliveChMS"),
        ],
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const AppTitleBar(),
            Row(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(20),
                  color: Theme.of(context).colorScheme.inverseSurface,
                )),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const HeroImage(),
                      Card(
                        color: Theme.of(context).colorScheme.surface,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 18,
                          ),
                          child: LoginForm(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
