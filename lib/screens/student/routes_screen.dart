import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/models/mock_data.dart';

class RoutesScreen extends StatefulWidget {
  final Function(RouteItem route) onRouteSelected;

  const RoutesScreen({
    super.key,
    required this.onRouteSelected,
  });

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final displayedRoutes = selectedTab == 0
        ? MockData.routes
        : MockData.routes.where((r) => r.isFavorite).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Routes'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton(
                    title: 'All Routes',
                    isSelected: selectedTab == 0,
                    onTap: () => setState(() => selectedTab = 0),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTabButton(
                    title: 'My Favorites',
                    isSelected: selectedTab == 1,
                    onTap: () => setState(() => selectedTab = 1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: displayedRoutes.length,
              itemBuilder: (context, index) {
                final route = displayedRoutes[index];
                return _buildRouteCard(route);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(24),
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 1.5)
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildRouteCard(RouteItem route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: () => widget.onRouteSelected(route),
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
              route.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            if (route.isFavorite)
              const Icon(Icons.star, color: Colors.amber, size: 20),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              route.stopsSummary,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.location_on_outlined,
                    size: 14, color: AppColors.textMuted),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    route.stops.join(', '),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.textMuted,
        ),
      ),
    );
  }

  Color _getRouteBadgeColor(String number) {
    switch (number) {
      case '01':
        return AppColors.danger;
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
