import 'package:alivechms/constants/widgets/app_drawer.dart';
import 'package:alivechms/constants/widgets/app_titlebar.dart';
import 'package:alivechms/constants/widgets/page_header.dart';
import 'package:alivechms/controllers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppState>(builder: (context, appState, child) {
      return Scaffold(
      persistentFooterButtons: const [
        Text("Powered by Life Media"),
      ],
      backgroundColor: Colors.white,
      body: Row(
        children: <Widget>[
            const AppDrawer(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  const AppTitleBar(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PageHeader(pageName: appState.currentPage),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                      child: appState.drawerPages
                          .elementAt(appState.selectedIndex),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    });
  }
}
