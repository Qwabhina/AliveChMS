import 'package:alivechms/controllers/app_state.dart';
import 'package:alivechms/controllers/auth_controller_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'page_title.dart';

class PageHeader extends StatelessWidget {
  final String pageName;
  const PageHeader({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {
    final MyAppState appState = Provider.of<MyAppState>(context);
    final AuthController authCtrl = AuthController(appState);
    // final Map<dynamic, dynamic> user = aspBox.get('user');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMEEEEd().format(DateTime.now()),
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 14,
              ),
            ),
            PageTitle(pageName: pageName),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 10),
            InkWell(
              onTap: authCtrl.logoutUser,
              child: Container(
                height: 30,
                width: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
