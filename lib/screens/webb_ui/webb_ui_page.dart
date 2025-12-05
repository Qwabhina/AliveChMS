import 'package:flutter/material.dart';
import 'package:webb_ui/webb_ui.dart';

import 'webb_ui_analytics_page.dart';
import 'webb_ui_dashboard_page.dart';
import 'webb_ui_settings_page.dart';
import 'webb_ui_users_page.dart';

class WebbUIPage extends StatefulWidget {
  const WebbUIPage({super.key});

  @override
  State<WebbUIPage> createState() => _WebbUIPageState();
}

class _WebbUIPageState extends State<WebbUIPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  // Navigation items
  final List<WebbUISideNavItem> _navItems = [
    const WebbUISideNavItem(
      icon: Icons.dashboard,
      label: 'Dashboard',
      semanticLabel: 'Navigate to Dashboard',
    ),
    const WebbUISideNavItem(
      icon: Icons.people_outline,
      activeIcon: Icon(Icons.people, color: Colors.white),
      label: 'Users',
      badgeCount: 5,
      semanticLabel: 'Navigate to Users',
    ),
    const WebbUISideNavItem(
      icon: Icons.analytics_outlined,
      activeIcon: Icon(Icons.analytics, color: Colors.white),
      label: 'Analytics',
      semanticLabel: 'Navigate to Analytics',
    ),
    const WebbUISideNavItem(
      icon: Icons.settings_outlined,
      activeIcon: Icon(Icons.settings, color: Colors.white),
      label: 'Settings',
      semanticLabel: 'Navigate to Settings',
    ),
  ];

  // Page titles for app bar
  final List<String> _pageTitles = [
    'Dashboard Overview',
    'User Management',
    'Analytics & Reports',
    'Application Settings',
  ];

  void _handleNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  Widget _buildAppHeader(BuildContext webbTheme) {
    return Padding(
      padding: EdgeInsets.all(webbTheme.spacingGrid.spacing(2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: webbTheme.colorPalette.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.rocket_launch,
                  color: webbTheme.colorPalette.onPrimary,
                  size: 18,
                ),
              ),
              SizedBox(width: webbTheme.spacingGrid.spacing(1)),
              InkWell(
                onTap: () => Navigator.pop(webbTheme),
                child: Text(
                  'WebbUI',
                  style: webbTheme.typography.headlineMedium.copyWith(
                    color: webbTheme.colorPalette.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: webbTheme.spacingGrid.spacing(1)),
          Text(
            'Admin Panel',
            style: webbTheme.typography.labelMedium.copyWith(
              color: webbTheme.colorPalette.neutralDark.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WebbUISideNavScaffold(
      // Navigation Configuration
      sideNavHeader: _buildAppHeader(context),
      sideNavItems: _navItems,
      selectedIndex: _selectedIndex,
      onItemSelected: _handleNavigation,

      // App Bar Configuration
      appBarTitle: Text(_pageTitles[_selectedIndex]),
      appBarActions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () => _showNotifications(context),
          tooltip: 'View notifications',
        ),
        IconButton(
          icon: const Icon(Icons.help_outline),
          onPressed: () => _showHelp(context),
          tooltip: 'Get help',
        ),
        WebbUIBadge(
          content: 'Admin',
          colorType: WebbUIBadgeColorType.success,
          size: WebbUIBadgeSize.small,
          child: CircleAvatar(
            radius: 16,
            backgroundColor: context.colorPalette.primary,
            child: Text(
              'JD',
              style: context.typography.labelMedium.copyWith(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
        ),
        SizedBox(width: context.spacingGrid.spacing(1)),
      ],

      // Body Content
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe
        children: const [
          WebbUIDashboardPage(),
          WebbUIUsersPage(),
          WebbUIAnalyticsPage(),
          WebbUISettingsPage(),
        ],
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    WebbUIModal.show(
      context,
      title: 'Notifications',
      type: WebbUIModalType.small,
      child: Container(
        padding: EdgeInsets.all(context.spacingGrid.spacing(2)),
        child: const Column(
          children: [
            ListTile(
              leading: Icon(Icons.security_update_good, color: Colors.green),
              title: Text('System updated successfully'),
              subtitle: Text('2 hours ago'),
            ),
            ListTile(
              leading: Icon(Icons.warning_amber, color: Colors.orange),
              title: Text('High memory usage detected'),
              subtitle: Text('4 hours ago'),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelp(BuildContext context) {
    WebbUIModal.show(
      context,
      title: 'Help & Support',
      type: WebbUIModalType.medium,
      actions: [
        WebbUIButton(
          label: 'Close',
          onPressed: () => Navigator.pop(context),
          variant: WebbUIButtonVariant.tertiary,
        ),
        WebbUIButton(
          label: 'Contact Support',
          onPressed: () => _contactSupport(context),
        ),
      ],
      child: Container(
        padding: EdgeInsets.all(context.spacingGrid.spacing(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Need help with WebbUI?',
              style: context.typography.headlineMedium,
            ),
            SizedBox(height: context.spacingGrid.spacing(2)),
            WebbUICard(
              child: Padding(
                padding: EdgeInsets.all(context.spacingGrid.spacing(2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Documentation',
                      style: context.typography.labelLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: context.spacingGrid.spacing(1)),
                    Text(
                      'Check out our comprehensive documentation for guides and API references.',
                      style: context.typography.bodyMedium,
                    ),
                    SizedBox(height: context.spacingGrid.spacing(2)),
                    WebbUIButton(
                      label: 'View Documentation',
                      onPressed: () => _openDocumentation(context),
                      fullWidth: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _contactSupport(BuildContext context) {
    // Implementation for contact support
    Navigator.pop(context);
  }

  void _openDocumentation(BuildContext context) {
    // Implementation for opening documentation
    Navigator.pop(context);
  }
}
