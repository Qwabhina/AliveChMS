import 'package:alivechms/controllers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    MyAppState appState = Provider.of<MyAppState>(context);
    return Container(
      width: 250,
      color: Colors.blue,
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title:
                const Text('Dashboard', style: TextStyle(color: Colors.white)),
            selected: appState.selectedIndex == 0,
            selectedTileColor: Colors.blue[700],
            onTap: () {
              appState.setCurrentPage(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text('Profile', style: TextStyle(color: Colors.white)),
            selected: appState.selectedIndex == 1,
            selectedTileColor: Colors.blue[700],
            onTap: () {
              appState.setCurrentPage(1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_money, color: Colors.white),
            title: const Text('Finance', style: TextStyle(color: Colors.white)),
            selected: appState.selectedIndex == 2,
            selectedTileColor: Colors.blue[700],
            onTap: () {
              appState.setCurrentPage(2);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title:
                const Text('Settings', style: TextStyle(color: Colors.white)),
            selected: appState.selectedIndex == 3,
            selectedTileColor: Colors.blue[700],
            onTap: () {
              appState.setCurrentPage(3);
            },
          ),
          const Spacer(), // Ensures footer buttons are positioned at the bottom
        ],
      ),
    );
  }
}
