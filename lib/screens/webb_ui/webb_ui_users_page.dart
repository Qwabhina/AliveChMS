import 'package:flutter/material.dart';
import 'package:webb_ui/webb_ui.dart';

class WebbUIUsersPage extends StatelessWidget {
  const WebbUIUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.spacingGrid.spacing(3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'User Management',
                style: context.typography.headlineLarge,
              ),
              WebbUIButton(
                label: 'Add User',
                onPressed: () => _addUser(context),
                icon: Icons.add,
              ),
            ],
          ),

          SizedBox(height: context.spacingGrid.spacing(2)),

          // Search and filters
          Row(
            children: [
              Expanded(
                child: WebbUISearchBar(
                  hintText: 'Search users...',
                  onChanged: (query) => _searchUsers(query),
                ),
              ),
              SizedBox(width: context.spacingGrid.spacing(1)),
              WebbUIButton(
                label: 'Filter',
                onPressed: () => _showFilters(context),
                variant: WebbUIButtonVariant.secondary,
                icon: Icons.filter_list,
              ),
            ],
          ),

          SizedBox(height: context.spacingGrid.spacing(3)),

          // Users table/list
          Expanded(
            child: WebbUICard(
              elevated: true,
              child: WebbUIList(
                items: _buildUserList(context),
                wrappedInCard: false,
                showSeparator: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildUserList(BuildContext context) {
    final users = [
      {
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'Admin',
        'status': 'Active'
      },
      {
        'name': 'Jane Smith',
        'email': 'jane@example.com',
        'role': 'User',
        'status': 'Active'
      },
      {
        'name': 'Bob Johnson',
        'email': 'bob@example.com',
        'role': 'Editor',
        'status': 'Inactive'
      },
    ];

    return users.map((user) {
      return WebbUIListTile(
        leading: CircleAvatar(
          backgroundColor: context.colorPalette.primary,
          child: Text(
            user['name']!.substring(0, 1),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: user['name']!,
        subtitle: user['email']!,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            WebbUIBadge(
              content: user['role']!,
              colorType: WebbUIBadgeColorType.neutral,
              size: WebbUIBadgeSize.small,
            ),
            SizedBox(width: context.spacingGrid.spacing(1)),
            WebbUIBadge(
              content: user['status']!,
              colorType: user['status'] == 'Active'
                  ? WebbUIBadgeColorType.success
                  : WebbUIBadgeColorType.error,
              size: WebbUIBadgeSize.small,
            ),
          ],
        ),
        onTap: () => _viewUserDetails(context, user),
      );
    }).toList();
  }

  void _addUser(BuildContext context) {
    // Implementation for adding user
  }

  void _searchUsers(String query) {
    // Implementation for searching users
  }

  void _showFilters(BuildContext context) {
    // Implementation for showing filters
  }

  void _viewUserDetails(BuildContext context, Map<String, String> user) {
    WebbUIModal.show(
      context,
      title: 'User Details',
      type: WebbUIModalType.medium,
      actions: [
        WebbUIButton(
          label: 'Close',
          onPressed: () => Navigator.pop(context),
          variant: WebbUIButtonVariant.tertiary,
        ),
        WebbUIButton(
          label: 'Edit User',
          onPressed: () => _editUser(context, user),
        ),
      ],
      child: Container(
        padding: EdgeInsets.all(context.spacingGrid.spacing(2)),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User details form/view
            Text('User details implementation...'),
          ],
        ),
      ),
    );
  }

  void _editUser(BuildContext context, Map<String, String> user) {
    // Implementation for editing user
  }
}
