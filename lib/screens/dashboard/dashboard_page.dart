import 'package:alivechms/controllers/app_api.dart';
import 'package:alivechms/main.dart';
import 'package:alivechms/models/member.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Future<List<Member>> fetchRecentMembers() async {
    final api = AppAPI();
    final response = await api.getRecentMembers();
    return response
        .map((json) => Member.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Map<String, dynamic>> fetchDashboardHighlights() async {
    final api = AppAPI();
    return await api.getDashboardHighlights();
  }

  Future<List<dynamic>> fetchUpcomingEvents() async {
    final api = AppAPI();
    final accessToken = aspBox.get('access_token') as String? ?? '';
    final res = await api.request(
      'get',
      '${AppAPI.baseURL}/events/upcoming',
      {},
      {'Authorization': 'Bearer $accessToken'},
    );
    return res is List<dynamic> ? res : (res['data'] as List<dynamic>);
  }

  Future<void> _handleLogout(BuildContext context) async {
    try {
      final api = AppAPI();
      await api.logout();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AliveChMS Dashboard'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleLogout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overview Section
              const Text(
                'Church Overview',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              FutureBuilder<Map<String, dynamic>>(
                future: fetchDashboardHighlights(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red));
                  } else if (snapshot.hasData) {
                    final highlights = snapshot.data!;
                    return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildOverviewCard(
                          title: 'Total Members',
                          value: highlights['total_members']?.toString() ?? '0',
                          icon: Icons.people,
                          color: Colors.blue,
                          context: context,
                          onTap: () {
                            // TODO: Navigate to members list
                          },
                        ),
                        _buildOverviewCard(
                          title: 'Recent Registrations',
                          value:
                              highlights['recent_registrations']?.toString() ??
                                  '0',
                          icon: Icons.person_add,
                          color: Colors.green,
                          context: context,
                          onTap: () {
                            // TODO: Navigate to recent members
                          },
                        ),
                        _buildOverviewCard(
                          title: 'Total Giving',
                          value:
                              '\$${highlights['total_giving']?.toString() ?? '0'}',
                          icon: Icons.attach_money,
                          color: Colors.orange,
                          context: context,
                          onTap: () {
                            // TODO: Navigate to giving report
                          },
                        ),
                        _buildOverviewCard(
                          title: 'Upcoming Events',
                          value:
                              highlights['upcoming_events']?.toString() ?? '0',
                          icon: Icons.event,
                          color: Colors.purple,
                          context: context,
                          onTap: () {
                            // TODO: Navigate to events
                          },
                        ),
                      ],
                    );
                  }
                  return const Text('No data available');
                },
              ),
              const SizedBox(height: 24),
              // Giving Trend
              FutureBuilder<Map<String, dynamic>>(
                future: fetchDashboardHighlights(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox.shrink();
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const SizedBox.shrink();
                  }
                  final trend =
                      snapshot.data!['giving_trend']?.toDouble() ?? 0.0;
                  final trendText = trend >= 0
                      ? 'Giving up ${trend * 100}%'
                      : 'Giving down ${trend.abs() * 100}%';
                  final trendColor = trend >= 0 ? Colors.green : Colors.red;
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            trend >= 0
                                ? Icons.trending_up
                                : Icons.trending_down,
                            color: trendColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            trendText,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: trendColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              // Recent Members Section
              const Text(
                'Recent Members',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<Member>>(
                future: fetchRecentMembers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red));
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final members = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: members.length,
                      itemBuilder: (context, index) {
                        final member = members[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue[100],
                              child: Text(
                                member.mbrFirstName[0],
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(
                              '${member.mbrFirstName} ${member.mbrFamilyName}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              'Registered: ${DateFormat.yMMMEd().format(DateTime.parse(member.mbrRegistrationDate))}',
                            ),
                            trailing: Text(
                              member.mbrID,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            onTap: () {
                              // TODO: Navigate to member details
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'View details for ${member.mbrFirstName}')),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                  return const Text('No recent members');
                },
              ),
              const SizedBox(height: 24),
              // Upcoming Events Section
              const Text(
                'Upcoming Events',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<dynamic>>(
                future: fetchUpcomingEvents(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('Events Error: ${snapshot.error}');
                    return const Text('Events not available',
                        style: TextStyle(color: Colors.grey));
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final events = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Mini Calendar Placeholder
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Events in ${DateFormat.yMMMM().format(DateTime.now())}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            final event = events[index];
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                leading: const Icon(Icons.event,
                                    color: Colors.purple),
                                title: Text(
                                  event['title'] ?? 'Untitled Event',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  'Date: ${DateFormat.yMMMEd().format(DateTime.parse(event['date']))}',
                                ),
                                trailing: Text(
                                  '${event['attendees']} attendees',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                onTap: () {
                                  // TODO: Navigate to event details
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'View details for ${event['title']}')),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                  return const Text('No upcoming events');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required BuildContext context,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: color),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
