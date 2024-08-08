import 'dart:async';

import 'package:alivechms/controllers/app_api.dart';
import 'package:alivechms/controllers/app_controller.dart';
import 'package:alivechms/controllers/app_state.dart';
// import 'package:aamusted_sp/models/student_model.dart';
import 'package:flutter/material.dart';

class AuthController {
  final MyAppState appState;

  AuthController(this.appState);
  AppAPI api = AppAPI();

  Future<void> loginUser(
    String indexNumber,
    String password,
  ) async {
    appState.startLoading();

    List<String> baseUrls = [
      // 'https://smgtcs.aamusted.edu.gh',
      'https://smgt2.aamusted.edu.gh',
      'https://collsmgt.aamusted.edu.gh',
      'https://smgt.aamusted.edu.gh',
    ];

    try {
      // CALL APP API's LOGIN METHOD
      // Map<String, dynamic> initialResponseData = await api.login(
      //   indexNumber,
      //   password,
      // );

      // // CHECK FOR SUCCESSFUL LOGIN
      // if (initialResponseData['status'] == 'Ok') {
      //   // STOP LOADING
      //   appState.stopLoading();

      //   // CHECK IF ITS A FIRST TIME LOGIN
      //   bool isFirstTimeLogin = initialResponseData['firstTime'];

      //   if (isFirstTimeLogin) {
      //     appState.navigatorKey.currentState?.pushReplacementNamed('/resetPass',
      //         arguments: {'index': indexNumber});
      //   } else {
      //     // PERSIST USER DATA

      //     // ADD SAVED USER DATA TO LOCAL STORAGE
      //     aspBox.put('user', initialResponseData);
      //     aspBox.put('userToken', initialResponseData['token']);
      //     AppController.setFirstRun();

      //     //REDIRECT TO PROFILE PAGE
      //     appState.navigatorKey.currentState!.pushReplacementNamed('/profile');
      //   }
      // } else {
      String errMessage = '';

      for (final endpoint in baseUrls) {
        // BUILD A NEW ENDPOINT URL STRING
        String newEndpoint = "$endpoint/${api.endpoints['login']}";

        // MAKE ANOTHER REQUEST
        Map<String, dynamic> responseData = await api.login(
          indexNumber,
          password,
          endpoint: newEndpoint,
        );
        final bool okStatus;
        final bool isFirstTimeLogin;

        // CHECK IF THE USER EXISTS IN THE CURRENT ENDPOINT
        if (responseData['exists']) {
          appState.stopLoading();

          // PERSIST THE CURRENT ENDPOINT
          // aspBox.put('baseUrl', endpoint);

          // SHORT-CIRCUITING
          okStatus = responseData['status'] == 'Ok';
          isFirstTimeLogin = responseData['firstTime'];

          // CHECK IF ITS A FIRST TIME LOGIN
          if (okStatus && isFirstTimeLogin) {
            // REDIRECT TO THE PASSWORD RESET PAGE
            appState.navigatorKey.currentState?.pushReplacementNamed(
              '/resetPass',
              arguments: {
                'index': indexNumber,
              },
            );
          }
          // IF IT'S NOT FIRST TIME LOGIN, CONTINUE
          else if (okStatus && !isFirstTimeLogin) {
            // PERSIST USER DATA
            // ADD FETCHED USER DATA TO LOCAL STORAGE
            // aspBox.put('user', responseData);
            // aspBox.put('userToken', responseData['token']);
            // AppController.setFirstRun();

            //REDIRECT TO PROFILE PAGE
            appState.navigatorKey.currentState!
                .pushReplacementNamed('/profile');

            appState.isLoggedIn = true;
          }
          // DISPLAY THE RETURNED ERROR
          else {
            errMessage = responseData['msg'];
          }

          break;
        }
        // IF ENDPOINT DOESN'T EXIST, CONTINUE
        else {
          errMessage = responseData['msg'];
          // continue;
        }
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
        // "An Error Ocurred: ${error.toString()}",
        "An Error Ocurred.\nCheck your internet settings and try again.",
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
    // await aspBox.delete("user");
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
