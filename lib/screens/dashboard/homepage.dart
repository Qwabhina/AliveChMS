import 'package:alivechms/constants/widgets/page_section_header.dart';
import 'package:alivechms/main.dart';
import 'package:alivechms/screens/dashboard/dashboard_highlights.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> user = aspBox.get('user');
    final List<dynamic> memberData = user['recent_registrations'];
    final List<Map<String, dynamic>> members =
        memberData.cast<Map<String, dynamic>>();

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView(children: [
        const PageSectionHeader(text: 'Overview'),
        const SizedBox(height: 16),
        const DashboardHighlights(),
        const SizedBox(height: 24),
        const PageSectionHeader(text: 'Recent Member Registrations'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            
          ),
          child: Column(
            children: members.map((member) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text(member['MbrFirstName']![0]),
                ),
                title: Text(
                  '${member['MbrFirstName']} ${member['MbrFamilyName']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    'Registered: ${DateFormat.yMMMMEEEEd().format(DateTime.parse(member['MbrRegistrationDate']))}'),
                trailing: Text(member['MbrCustomID']!),
                onTap: () {
                  // Handle tap event
                },
              );
            }).toList(),
          ),
        )
      ]),
    );
  }
}
