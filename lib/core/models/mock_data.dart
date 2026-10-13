import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class RouteItem {
  final String id;
  final String routeNumber;
  final String title;
  final String stopsSummary;
  final List<String> stops;
  final bool isFavorite;

  RouteItem({
    required this.id,
    required this.routeNumber,
    required this.title,
    required this.stopsSummary,
    required this.stops,
    this.isFavorite = false,
  });
}

class BusItem {
  final String id;
  final String number;
  final String destination;
  final String routeName;
  final String status;
  final String eta;
  final String distance;
  final String occupancy;
  final String driverName;

  BusItem({
    required this.id,
    required this.number,
    required this.destination,
    required this.routeName,
    required this.status,
    required this.eta,
    required this.distance,
    required this.occupancy,
    required this.driverName,
  });

  Color get occupancyColor {
    switch (occupancy.toLowerCase()) {
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
}

class NotificationItem {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  });
}

class MockData {
  static final List<RouteItem> routes = [
    RouteItem(
      id: 'r1',
      routeNumber: '01',
      title: 'Route 01',
      stopsSummary: 'Farmgate → University',
      stops: ['Farmgate', 'Mohakhali', 'University'],
      isFavorite: false,
    ),
    RouteItem(
      id: 'r2',
      routeNumber: '02',
      title: 'Route 02',
      stopsSummary: 'Banani → University',
      stops: ['Banani', 'Gulshan', 'Kalabagan', 'University'],
      isFavorite: true,
    ),
    RouteItem(
      id: 'r3',
      routeNumber: '03',
      title: 'Route 03',
      stopsSummary: 'Dhanmondi → University',
      stops: ['Dhanmondi', 'Shankar', 'Central Library', 'University'],
      isFavorite: true,
    ),
    RouteItem(
      id: 'r4',
      routeNumber: '04',
      title: 'Route 04',
      stopsSummary: 'Mirpur → University',
      stops: ['Mirpur 10', 'Pallabi', 'Agargaon', 'University'],
      isFavorite: true,
    ),
  ];

  static final BusItem activeBus = BusItem(
    id: 'b3',
    number: 'Bus 03',
    destination: 'To University',
    routeName: 'Farmgate → University',
    status: 'On Route',
    eta: '7 min',
    distance: '1.2 km',
    occupancy: 'Almost Full',
    driverName: 'Rafiq Ahmed',
  );

  static final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Bus 03 is 5 minutes away',
      subtitle: 'Your bus is approaching your stop.',
      time: '10:24 AM',
      icon: Icons.directions_bus,
      iconBgColor: Color(0xFFEFF6FF),
      iconColor: AppColors.primary,
    ),
    NotificationItem(
      title: 'Route 02 is delayed',
      subtitle: 'Due to traffic, the bus is 10 mins late.',
      time: '09:45 AM',
      icon: Icons.warning_amber_rounded,
      iconBgColor: Color(0xFFFEF2F2),
      iconColor: AppColors.danger,
    ),
    NotificationItem(
      title: 'Bus 01 has arrived',
      subtitle: 'At Mohakhali stop.',
      time: '08:32 AM',
      icon: Icons.check_circle_outline,
      iconBgColor: Color(0xFFF0FDF4),
      iconColor: AppColors.success,
    ),
    NotificationItem(
      title: 'New announcement',
      subtitle: 'University will remain closed tomorrow...',
      time: 'Yesterday',
      icon: Icons.campaign_outlined,
      iconBgColor: Color(0xFFFEF3C7),
      iconColor: AppColors.warning,
    ),
    NotificationItem(
      title: 'Feedback received',
      subtitle: 'Your complaint has been submitted.',
      time: 'Yesterday',
      icon: Icons.favorite_border,
      iconBgColor: Color(0xFFEEF2FF),
      iconColor: AppColors.primary,
    ),
  ];
}
