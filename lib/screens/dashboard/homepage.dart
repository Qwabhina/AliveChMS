
import 'package:alivechms/constants/widgets/page_section_header.dart';
import 'package:alivechms/main.dart';
import 'package:alivechms/models/dashboard/overview_models.dart';
import 'package:alivechms/screens/dashboard/dashboard_highlights.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OverviewModel overview =
        OverviewModel.fromJson(aspBox.get("user").cast<String, dynamic>());
    // print(overview.toString());
    // final Map<String, dynamic> user =
    //     aspBox.get('user').cast<String, dynamic>();
    final List<RecentRegistration> memberData = overview.recentRegistrations;
    // final List<dynamic> memberData = user['recent_registrations'] as List;
    // final List<Map<String, dynamic>> members =
    //     memberData.cast<Map<String, dynamic>>();

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
            children: memberData.map((member) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text(member.mbrFirstName),
                ),
                title: Text(
                  '${member.mbrFirstName} ${member.mbrFamilyName}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    'Registered: ${DateFormat.yMMMMEEEEd().format(DateTime.parse(member.mbrRegistrationDate))}'),
                trailing: Text(member.mbrCustomID),
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
