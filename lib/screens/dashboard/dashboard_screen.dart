import 'package:alivechms/constants/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:alivechms/screens/finance_screen.dart';
import 'package:alivechms/screens/profile_screen.dart';
import 'package:alivechms/screens/settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    ProfilePage(),
    FinancePage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: const [
        Text("Powered by Life Media"),
      ],
      backgroundColor: Colors.white,
      body: Row(
        children: <Widget>[
          Container(
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
                  title: const Text('Profile',
                      style: TextStyle(color: Colors.white)),
                  selected: _selectedIndex == 0,
                  selectedTileColor: Colors.blue[700],
                  onTap: () {
                    _onItemTapped(0);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.attach_money, color: Colors.white),
                  title: const Text('Finance',
                      style: TextStyle(color: Colors.white)),
                  selected: _selectedIndex == 1,
                  selectedTileColor: Colors.blue[700],
                  onTap: () {
                    _onItemTapped(1);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.white),
                  title: const Text('Settings',
                      style: TextStyle(color: Colors.white)),
                  selected: _selectedIndex == 2,
                  selectedTileColor: Colors.blue[700],
                  onTap: () {
                    _onItemTapped(2);
                  },
                ),
                const Spacer(), // Ensures footer buttons are positioned at the bottom
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER SECTION
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: PageHeader(pageName: "Dashboard"),
                ),
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _pages.elementAt(_selectedIndex),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
