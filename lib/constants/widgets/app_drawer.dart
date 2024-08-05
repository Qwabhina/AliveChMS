import 'package:alivechms/controllers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // MyAppState appState = Provider.of<MyAppState>(context);
    return Consumer<MyAppState>(builder: (context, appState, child) {
    return Container(
        width: 300,
        color: Theme.of(context).colorScheme.background,
        child: ListView(
        children: [
            DrawerHeader(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
            ),
              child: const Text('Menu', style: TextStyle(color: Colors.white)),
          ),
            AppDrawerItem(
              icon: Icons.dashboard,
              title: 'Dashboard',
              selected: appState.selectedIndex == 0,
              onTap: () => appState.setCurrentPage(0, 'Dashboard'),
          ),
            AppDrawerItem(
              icon: Icons.group_add,
              title: 'Members & People',
              selected: appState.selectedIndex == 1,
              onTap: () => appState.setCurrentPage(1, 'Members & People'),
          ),
            AppDrawerItem(
              icon: Icons.dashboard,
              title: 'Groups',
              selected: appState.selectedIndex == 2,
              onTap: () => appState.setCurrentPage(2, 'Groups'),
            ),
            AppDrawerItem(
              icon: Icons.dashboard,
              title: 'Contributions',
              selected: appState.selectedIndex == 3,
              onTap: () => appState.setCurrentPage(3, 'Contributions'),
            ),
            AppDrawerItem(
              icon: Icons.dashboard,
              title: 'Events & Calendar',
              selected: appState.selectedIndex == 4,
              onTap: () => appState.setCurrentPage(4, 'Events & Calendar'),
            ),
            AppDrawerItem(
              icon: Icons.dashboard,
              title: 'Finance',
              selected: appState.selectedIndex == 5,
              onTap: () => appState.setCurrentPage(5, 'Finance'),
            ),
            AppDrawerItem(
              icon: Icons.dashboard,
              title: 'Settings',
              selected: appState.selectedIndex == 6,
              onTap: () => appState.setCurrentPage(6, 'Settings'),
          ),
          const Spacer(), // Ensures footer buttons are positioned at the bottom
        ],
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
    return Container(
      padding: const EdgeInsets.only(left: 35),
      color: Theme.of(context).colorScheme.background,
      child: ListTile(
        selectedTileColor: Theme.of(context).colorScheme.secondary,
        selected: selected,
        leading: Icon(
          icon,
          color: selected
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.tertiary,
        ),
        title: Text(title,
            style: selected
                ? TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.bold)
                : TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
        hoverColor: Theme.of(context).colorScheme.secondary,
        onTap: onTap,
      ),
    );
  }
}
