import 'package:alivechms/constants/widgets/form_submit_button.dart';
import 'package:alivechms/constants/widgets/form_textbox.dart';
import 'package:alivechms/constants/widgets/page_section_header.dart';
import 'package:alivechms/constants/widgets/page_title.dart';
import 'package:alivechms/controllers/app_state.dart';
import 'package:alivechms/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // App State
    final MyAppState appState = Provider.of<MyAppState>(context);
    // Auth Controller
    final AuthController authController = AuthController(appState);

    return Form(
      key: _formKey,
      child: IgnorePointer(
        ignoring: appState.isLoading,
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

          // USERNAME FIELD
          FormTextBox(
            ctrl: _usernameController,
            label: "Username",
            hint: "Enter Your Username",
            inputType: TextInputType.text,
            autoFocus: true,
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  value.trim().length < 3) {
                return "Please enter a valid Username";
              }
              return null;
            },
              onFieldSubmitted: (value) {
                FocusScope.of(context).nextFocus();
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
              onFieldSubmitted: (value) {
                if (_formKey.currentState!.validate()) {
                  authController.loginUser(
                    _usernameController.text,
                    _passwordController.text,
                  );
                }
              },
          ),

          const SizedBox(height: 32),

          // LOGIN BUTTON
          FormSubmitButton(
            title: 'Login',
            loading: appState.isLoading,
            onTap: () {
              if (_formKey.currentState!.validate()) {
                authController.loginUser(
                  _usernameController.text,
                  _passwordController.text,
                );
              }
            },
          ),

          const SizedBox(height: 24),

          // FORGOT PASSWORD LINK
          InkWell(
            onTap: () =>
                Navigator.pushNamed(context, '/forgotPass', arguments: {
              'forgotType': 'email',
              'indexNumber': _usernameController.text,
            }),
            child: Text(
              "Forgot Password",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),

          const SizedBox(height: 10),
        ],
        ),
      ),
    );
  }
}
