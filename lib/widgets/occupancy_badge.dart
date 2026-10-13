import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class OccupancyBadge extends StatelessWidget {
  final String status;

  const OccupancyBadge({
    super.key,
    required this.status,
  });

  Color get badgeColor {
    switch (status.toLowerCase()) {
      case 'empty':
        return AppColors.occupancyEmpty;
      case 'available':
        return AppColors.occupancyAvailable;
      case 'almost full':
        return AppColors.occupancyAlmostFull;
      case 'full':
        return AppColors.occupancyFull;
      default:
        return AppColors.occupancyAvailable;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: badgeColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          status,
          style: TextStyle(
            color: badgeColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
