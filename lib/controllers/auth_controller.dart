import 'dart:async';

import 'package:alivechms/controllers/app_api.dart';
import 'package:alivechms/controllers/app_controller.dart';
import 'package:alivechms/controllers/app_state.dart';
import 'package:alivechms/main.dart';
// import 'package:aamusted_sp/models/student_model.dart';
import 'package:flutter/material.dart';

class AuthController {
  final MyAppState appState;

  AuthController(this.appState);
  AppAPI api = AppAPI();

  Future<void> loginUser(
    String userName,
    String password,
  ) async {
    appState.startLoading();

    try {
      final bool okStatus;
      String errMessage = '';

      Map<String, dynamic> responseData = await api.login(
        userName,
        password,
      );

      okStatus = responseData['type'] == 'ok';

      appState.stopLoading();    
          
      if (okStatus) {
            // PERSIST USER DATA
            // ADD FETCHED USER DATA TO LOCAL STORAGE
        // aspBox.put('user', responseData);
        aspBox.put('user', responseData);
        print(aspBox.get('user'));
            // aspBox.put('userToken', responseData['token']);
            // AppController.setFirstRun();

            //REDIRECT TO PROFILE PAGE
        appState.navigatorKey.currentState!.pushReplacementNamed('/dashboard');

            appState.isLoggedIn = true;
      }
      // DISPLAY THE RETURNED ERROR
      else {
        errMessage = responseData['content'];
      }

      // SHOW [CUSTOM] ALERT DIALOG
      if (errMessage.isNotEmpty && !appState.isLoggedIn) {
        AppController.showAlert(
          appState.navigatorKey.currentContext!,
          errMessage,
          'error',
        );
      }
      
    } catch (error) {
      // ERROR HANDLING
      AppController.showAlert(
        appState.navigatorKey.currentContext!,
        "An Error Ocurred: ${error.toString()}",
        // "An Error Ocurred.\nCheck your internet settings and try again.",
        'error',
      );
      
    } finally {
      appState.stopLoading();
    }
  }

  Future<void> resetPassword(
    String oldPassword,
    String newPassword,
    String confirmNewPassword,
    String indexNo, {
    bool firstTime = true,
  }) async {
    appState.startLoading();

    try {
      // CALL APP API's RESET PASSWORD METHOD
      Map<String, dynamic> responseData = await api.changePassword(
        newPassword,
        confirmNewPassword,
        oldPassword,
        indexNo,
      );

      if (responseData['status'] == 'Ok') {
        AppController.showAlert(
          appState.navigatorKey.currentContext!,
          responseData['msg'],
          'success',
        );

        Future.delayed(const Duration(seconds: 3), () {
          if (firstTime) {
            Navigator.pushReplacementNamed(
              appState.navigatorKey.currentContext!,
              '/login',
            );
          } else {
            //REDIRECT TO PROFILE PAGE
            appState
              ..currentPage = 'profile'
              ..navigatorKey.currentState!.pushReplacementNamed('/profile');
          }
        });
      } else {
        AppController.showAlert(
          appState.navigatorKey.currentContext!,
          responseData['msg'],
          'error',
        );
      }
    } catch (error) {
      AppController.showAlert(
        appState.navigatorKey.currentContext!,
        // error.toString(),
        "An Error Ocurred.\nCheck your internet settings and try again.",
        'error',
      );
      // appState.stopLoading();
    } finally {
      appState.stopLoading();
    }
  }

  void logoutUser() async {
    await aspBox.delete("user");
    appState.logout();

    Navigator.pushReplacementNamed(
      appState.navigatorKey.currentContext!,
      '/login',
    );
  }

  Future<void> forgotPassword(String indexNo) async {
    appState.startLoading();
    try {
      // CALL APP API's LOGIN METHOD
      Map<String, dynamic> responseData = await api.resetPassword(indexNo);
      if (responseData['status'] == 'Ok') {
        AppController.showAlert(
          appState.navigatorKey.currentContext!,
          responseData['msg'],
          'success',
        );

        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(
            appState.navigatorKey.currentContext!,
            '/login',
          );
        });
      } else {
        AppController.showAlert(
          appState.navigatorKey.currentContext!,
          responseData['msg'],
          'error',
        );
      }
    } catch (error) {
      AppController.showAlert(
        appState.navigatorKey.currentContext!,
        // error.toString(),
        "An Error Ocurred.\nCheck your internet settings and try again.",
        'error',
      );
    } finally {
      appState.stopLoading();
    }
  }
}
