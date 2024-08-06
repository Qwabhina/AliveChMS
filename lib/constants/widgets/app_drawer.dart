import 'package:alivechms/constants/app_constants.dart';
import 'package:alivechms/controllers/app_state.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // MyAppState appState = Provider.of<MyAppState>(context);
    return Consumer<MyAppState>(builder: (context, appState, child) {
      return Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: ListView(
        children: [
            DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: MoveWindow(
              child: Row(
                children: [
                  const SizedBox(width: 30),
                  // IMAGE
                  SizedBox(
                    width: 60,
                    child: ImgLinks.logoLight,
                  ),

                  // SPACER
                  const SizedBox(width: 10),

                  // TEXT
                  Text(
                    "MEANINGFUL LIFE\nCHRISTIAN CENTRE",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
            AppDrawerItem(
            icon: Ionicons.apps,
              title: 'Dashboard',
              selected: appState.selectedIndex == 0,
              onTap: () => appState.setCurrentPage(0, 'Dashboard'),
          ),
            AppDrawerItem(
            icon: Icons.group_add_rounded,
              title: 'Members & People',
              selected: appState.selectedIndex == 1,
              onTap: () => appState.setCurrentPage(1, 'Members & People'),
          ),
            AppDrawerItem(
            icon: Ionicons.people,
              title: 'Groups',
              selected: appState.selectedIndex == 2,
              onTap: () => appState.setCurrentPage(2, 'Groups'),
            ),
            AppDrawerItem(
            icon: Ionicons.cash,
              title: 'Contributions',
              selected: appState.selectedIndex == 3,
              onTap: () => appState.setCurrentPage(3, 'Contributions'),
            ),
            AppDrawerItem(
            icon: Ionicons.calendar,
              title: 'Events & Calendar',
              selected: appState.selectedIndex == 4,
              onTap: () => appState.setCurrentPage(4, 'Events & Calendar'),
            ),
            AppDrawerItem(
            icon: Icons.monetization_on,
              title: 'Finance',
              selected: appState.selectedIndex == 5,
              onTap: () => appState.setCurrentPage(5, 'Finance'),
            ),
            AppDrawerItem(
            icon: Icons.settings,
              title: 'Settings',
              selected: appState.selectedIndex == 6,
              onTap: () => appState.setCurrentPage(6, 'Settings'),
          ),
          const Spacer(), // Ensures footer buttons are positioned at the bottom
        ]
      ),
      );
    });
  }
}

class AppDrawerItem extends StatelessWidget {
  const AppDrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedTileColor: Colors.white,
      selected: selected,
      contentPadding: const EdgeInsets.only(left: 35),
      leading: Icon(
        icon,
        color: selected
            ? Theme.of(context).colorScheme.secondaryContainer
            : Theme.of(context).colorScheme.primaryContainer,
      ),
      title: Text(
        title,
        style: selected
            ? TextStyle(
                color: Theme.of(context).colorScheme.primaryContainer,
                fontWeight: FontWeight.bold)
            : const TextStyle(
                // color: Theme.of(context).colorScheme.onSurface,
                ),
      ),
      hoverColor: selected
          ? Colors.white
          : Theme.of(context).colorScheme.secondaryContainer,
      onTap: onTap,
    );
  }
}
