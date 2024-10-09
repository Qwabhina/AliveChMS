import 'package:alivechms/constants/widgets/page_section_header.dart';
import 'package:alivechms/controllers/app_state.dart';
import 'package:alivechms/controllers/members_controller.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    MyAppState appState = Provider.of<MyAppState>(context);
    MembersController ctrl = MembersController(appState);

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListView(children: [
          const PageSectionHeader(text: 'Manage Members'),
          const SizedBox(height: 16),
          Row(children: [
            ElevatedButton(
              onPressed: () {
                ctrl.openAddForm();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                elevation: 0,
                padding: const EdgeInsets.only(
                    left: 15, top: 15, right: 25, bottom: 15),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                foregroundColor: Colors.white.withOpacity(0.95),
              ),
              child: Row(children: [
                Icon(
                  Ionicons.add,
                  color: Colors.white.withOpacity(0.95),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Add Member",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ),
          ]),
          // const DashboardHighlights(),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ]),
      ),
    );
  }
}
