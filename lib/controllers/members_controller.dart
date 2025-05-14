import 'package:alivechms/controllers/app_api.dart';
import 'package:alivechms/controllers/app_state.dart';
import 'package:flutter/material.dart';

class MembersController {
  final MyAppState appState;

  MembersController(this.appState);
  AppAPI api = AppAPI();

  openAddForm() {
    return showBottomSheet(
        context: appState.navigatorKey.currentContext!,
        builder: (c) {
          return Center(
            child: Container(
              width: MediaQuery.of(c).size.width * 0.275,
              height: MediaQuery.of(c).size.height * 0.4,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Theme.of(c).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView(
                  children: [
                    Text(
                      "Form",
                      textAlign: TextAlign.center,
                      style: Theme.of(c)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Theme.of(c).colorScheme.onSurface),
                    ),
                  ]),
            ),
          );
        });
  }
}
