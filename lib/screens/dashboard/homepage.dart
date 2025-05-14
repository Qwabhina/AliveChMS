import 'package:alivechms/constants/widgets/page_section_header.dart';
import 'package:alivechms/controllers/app_api.dart';
import 'package:alivechms/models/member.model.dart';
import 'package:alivechms/screens/dashboard/dashboard_highlights.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  Future<List<Member>> fetchRecentMembers() async {
    final response = await AppAPI().getRecentMembers();
    // print(response.toString());
    return response.map((json) => Member.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView(
        children: [
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

            child: FutureBuilder<List<Member>>(
              future: fetchRecentMembers(),

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());

                } else if (snapshot.hasError) {
                  print(snapshot.error.toString());

                  return Center(
                      child: Text(
                    'Error loading members: ${snapshot.error.toString()}',
                    ),
                  );
                  
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final members = snapshot.data!;
                  return SingleChildScrollView(
                    child: Column(
                      children: members.map((member) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(member.mbrFirstName.isNotEmpty
                                ? member.mbrFirstName[0]
                                : ''),
                          ),
                          title: Text(
                            '${member.mbrFirstName} ${member.mbrFamilyName}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Registered: ${DateFormat.yMMMMEEEEd().format(DateTime.parse(member.mbrRegistrationDate))}',
                          ),
                          trailing: Text(member.mbrID),
                          onTap: () {
                            // Handle tap event (e.g., navigate to member details)
                          },
                        );
                      }).toList(),
                    ),
                  );
                }
                return const Center(child: Text('No recent registrations'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
