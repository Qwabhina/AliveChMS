import 'dart:async';

import 'package:alivechms/controllers/app_controller.dart';
import 'package:alivechms/controllers/app_state.dart';
import 'package:alivechms/main.dart';
import 'package:alivechms/models/data/data_bank.dart';
import 'package:flutter/material.dart';

class AuthController {
  final MyAppState appState;

  AuthController(this.appState);

  Future<void> loginUser(
    String indexNumber,
    String password,
  ) async {
    appState.startLoading();

    bool isLoginSuccessful;

    if (indexNumber == 'admin' && password == '@123Four!!') {
      isLoginSuccessful = true;
    } else {
      isLoginSuccessful = false;
    }

    if (isLoginSuccessful) {
      try {
        if (studentData['firstTime']) {
          Navigator.pushReplacementNamed(
              appState.navigatorKey.currentContext!, '/resetPass',
              arguments: {
                'index': studentData['bio'][0]['IndexNumber'],
              });
          appState.stopLoading();
        } else {
          aspBox.put('user', studentData);

          // Navigate to the ProfilePage with the user object
          Timer(const Duration(seconds: 2), () {
            appState.loginSuccess();
            AppController.setFirstRun();

            Navigator.pushReplacementNamed(
                appState.navigatorKey.currentContext!, '/dashboard');
          });
        }
      } catch (e) {
        appState.loginFailed('Login Failed. An error occurred: $e');
        AppController.showAlert(
          appState.navigatorKey.currentContext!,
          appState.errorMessage,
          'error',
        );
      }
    } else {
      appState.stopLoading();
      appState.loginFailed('Login Failed. Please try again.');
      AppController.showAlert(
        appState.navigatorKey.currentContext!,
        appState.errorMessage,
        'error',
      );
    }
  }

  void logoutUser() async {
    Navigator.pushReplacementNamed(
      appState.navigatorKey.currentContext!,
      '/login',
    );
    await aspBox.delete("user");
    appState.logout();
  }

  Future<bool> forgotPassword({required Map<String, dynamic> options}) async {
    // Logic to handle forgot password functionality
    // Return true if the process is successful, else return false
    return false;
  }
}
