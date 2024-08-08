import 'package:alivechms/constants/widgets/form_submit_button.dart';
import 'package:alivechms/constants/widgets/form_textbox.dart';
import 'package:alivechms/constants/widgets/page_section_header.dart';
import 'package:alivechms/constants/widgets/page_title.dart';
import 'package:alivechms/controllers/app_state.dart';
import 'package:alivechms/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  // TEXT EDITING CONTROLLERS
  final TextEditingController _indexController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // APP STATE
    MyAppState appState = Provider.of<MyAppState>(context);
    // AUTH CONTROLLER
    final AuthController authController = AuthController(appState);
    // FORM KEY
    final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

    return Form(
      key: loginFormKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const PageTitle(pageName: 'Welcome!', textSize: 24),
          const PageSectionHeader(
            text:
                "Please enter your Username and Password to log into your account",
            fontSize: 14,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.normal,
          ),
          const SizedBox(height: 36),
          // USERNAME
          FormTextBox(
            ctrl: _indexController,
            label: "Username",
            hint: "Enter Your Username",
            inputType: TextInputType.text,
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  value.trim().length < 3) {
                return "Please enter a valid Username";
              }
              return null;
            },
          ),
          const SizedBox(height: 22),
          // PASSWORD FIELD
          FormTextBox(
            ctrl: _passwordController,
            label: "Password",
            hint: "Type Your Password",
            inputType: TextInputType.visiblePassword,
            passwdBox: !appState.isPasswordVisible,
            icon: IconButton(
              icon: Icon(
                color: Theme.of(context).colorScheme.onSurface,
                appState.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () => appState.togglePasswordVisibility(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Please enter your Password";
              }
              return null;
            },
          ),
          const SizedBox(height: 32),

          // LOGIN BUTTON
          FormSubmitButton(
            title: 'Login',
            onTap: appState.isLoading
                ? () {}
                : () {
                    if (loginFormKey.currentState!.validate()) {
                      authController.loginUser(
                        _indexController.text,
                        _passwordController.text,
                      );
                    } else if (_indexController.text.trim().isEmpty ||
                        _passwordController.text.trim().isEmpty) {
                      loginFormKey.currentState!.validate();
                    }
                  },
          ),

          // FORGOT PASSWORD BUTTONS
          const SizedBox(height: 18),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/forgotPass',
                arguments: {
                  'forgotType': 'email',
                  'indexNumber': _indexController.text
                }),
            child: Text(
              "Forgot Password (Email)",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              '/forgotPass',
              arguments: {
                'forgotType': 'sms',
                'indexNumber': _indexController.text
              },
            ),
            child: Text(
              "Forgot Password (SMS)",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
