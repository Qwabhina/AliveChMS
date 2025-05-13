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
        
        backgroundColor: Colors.white,
          body: Column(
            children: [
              const AppTitleBar(),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 420,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 42,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HeroImage(),
                        LoginForm(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
)
      );
    });
  }
}
