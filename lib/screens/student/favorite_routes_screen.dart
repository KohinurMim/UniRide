import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/models/mock_data.dart';

class FavoriteRoutesScreen extends StatelessWidget {
  final VoidCallback onBack;
  final Function(RouteItem route) onRouteSelected;

  const FavoriteRoutesScreen({
    super.key,
    required this.onBack,
    required this.onRouteSelected,
  });

  @override
  Widget build(BuildContext context) {
    final favorites = MockData.routes.where((r) => r.isFavorite).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        title: const Text('My Routes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final route = favorites[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              onTap: () => onRouteSelected(route),
              leading: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _getRouteBadgeColor(route.routeNumber),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  route.routeNumber,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              title: Row(
                children: [
                  Text(
                    'Home → University',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.star, color: Colors.amber, size: 22),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  route.title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getRouteBadgeColor(String number) {
    switch (number) {
      case '02':
        return AppColors.primary;
      case '03':
        return AppColors.success;
      case '04':
        return const Color(0xFF8B5CF6);
      default:
        return AppColors.primary;
    }
  }
}
