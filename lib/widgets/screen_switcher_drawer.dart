import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class ScreenSwitcherDrawer extends StatelessWidget {
  final String activeScreen;
  final Function(String screenName) onSelectScreen;

  const ScreenSwitcherDrawer({
    super.key,
    required this.activeScreen,
    required this.onSelectScreen,
  });

  static const List<Map<String, dynamic>> allScreens = [
    {'title': 'Splash Screen', 'category': 'Auth', 'icon': Icons.space_dashboard_outlined},
    {'title': 'Login Screen', 'category': 'Auth', 'icon': Icons.login_rounded},
    {'title': 'Home Screen (Student)', 'category': 'Student', 'icon': Icons.home_rounded},
    {'title': 'Live Tracking Map', 'category': 'Student', 'icon': Icons.map_rounded},
    {'title': 'Route & Stops Screen', 'category': 'Student', 'icon': Icons.alt_route_rounded},
    {'title': 'ETA & Stop Details', 'category': 'Student', 'icon': Icons.timer_outlined},
    {'title': 'Bus Occupancy', 'category': 'Student', 'icon': Icons.groups_outlined},
    {'title': 'Notifications', 'category': 'Student', 'icon': Icons.notifications_none_rounded},
    {'title': 'Feedback / Complaint', 'category': 'Student', 'icon': Icons.chat_bubble_outline_rounded},
    {'title': 'Driver Dashboard', 'category': 'Driver', 'icon': Icons.directions_bus_rounded},
    {'title': 'Admin Panel', 'category': 'Admin', 'icon': Icons.admin_panel_settings_outlined},
    {'title': 'SOS Button', 'category': 'Safety', 'icon': Icons.sos_rounded},
    {'title': 'Favorite Routes', 'category': 'Student', 'icon': Icons.star_border_rounded},
    {'title': 'Settings / Profile', 'category': 'Student', 'icon': Icons.person_outline_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: AppColors.primary,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.layers_outlined, color: Colors.white, size: 28),
                      SizedBox(width: 10),
                      Text(
                        'UniRide Preview',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Select any of the 14 UI screens:',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allScreens.length,
                itemBuilder: (context, index) {
                  final item = allScreens[index];
                  final isSelected = activeScreen == item['title'];

                  return ListTile(
                    dense: true,
                    selected: isSelected,
                    selectedTileColor: AppColors.primaryLight,
                    leading: Icon(
                      item['icon'] as IconData,
                      color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    ),
                    title: Text(
                      item['title'] as String,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? AppColors.primary : AppColors.textPrimary,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item['category'] as String,
                        style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      onSelectScreen(item['title'] as String);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
