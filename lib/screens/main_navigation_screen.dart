import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

import 'splash_screen.dart';
import 'auth/login_screen.dart';
import 'student/student_home_screen.dart';
import 'student/live_tracking_screen.dart';
import 'student/routes_screen.dart';
import 'student/eta_details_screen.dart';
import 'student/bus_occupancy_screen.dart';
import 'student/notifications_screen.dart';
import 'student/feedback_screen.dart';
import 'student/sos_screen.dart';
import 'student/favorite_routes_screen.dart';
import 'driver/driver_dashboard_screen.dart';
import 'admin/admin_dashboard_screen.dart';
import 'profile/profile_screen.dart';
import '../widgets/screen_switcher_drawer.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  String currentScreen = 'Splash Screen';
  int bottomNavIndex = 0; // 0: Home, 1: Routes, 2: Notifications, 3: Profile

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void navigateToScreen(String screenName) {
    setState(() {
      currentScreen = screenName;
      if (screenName == 'Home Screen (Student)') bottomNavIndex = 0;
      if (screenName == 'Route & Stops Screen') bottomNavIndex = 1;
      if (screenName == 'Notifications') bottomNavIndex = 2;
      if (screenName == 'Settings / Profile') bottomNavIndex = 3;
    });
  }

  void onBottomNavTapped(int index) {
    setState(() {
      bottomNavIndex = index;
      switch (index) {
        case 0:
          currentScreen = 'Home Screen (Student)';
          break;
        case 1:
          currentScreen = 'Route & Stops Screen';
          break;
        case 2:
          currentScreen = 'Notifications';
          break;
        case 3:
          currentScreen = 'Settings / Profile';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool showBottomNav = [
      'Home Screen (Student)',
      'Route & Stops Screen',
      'Notifications',
      'Settings / Profile',
    ].contains(currentScreen);

    return Scaffold(
      key: _scaffoldKey,
      drawer: ScreenSwitcherDrawer(
        activeScreen: currentScreen,
        onSelectScreen: navigateToScreen,
      ),
      body: Stack(
        children: [
          _buildActiveScreen(),

          // Floating UI Switcher Action Button for quick demo switching
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 12,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _scaffoldKey.currentState?.openDrawer(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.layers_rounded, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'UI Screens',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: showBottomNav
          ? BottomNavigationBar(
              currentIndex: bottomNavIndex,
              onTap: onBottomNavTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.alt_route_outlined),
                  activeIcon: Icon(Icons.alt_route),
                  label: 'Routes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_none_outlined),
                  activeIcon: Icon(Icons.notifications),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            )
          : null,
    );
  }

  Widget _buildActiveScreen() {
    switch (currentScreen) {
      case 'Splash Screen':
        return SplashScreen(
          onGetStarted: () => navigateToScreen('Login Screen'),
          onLoginPressed: () => navigateToScreen('Login Screen'),
        );

      case 'Login Screen':
        return LoginScreen(
          onLoginSuccess: (role) {
            if (role == 'Driver') {
              navigateToScreen('Driver Dashboard');
            } else if (role == 'Admin') {
              navigateToScreen('Admin Panel');
            } else {
              navigateToScreen('Home Screen (Student)');
            }
          },
        );

      case 'Home Screen (Student)':
        return StudentHomeScreen(
          onNavigate: navigateToScreen,
        );

      case 'Live Tracking Map':
        return LiveTrackingScreen(
          onBack: () => navigateToScreen('Home Screen (Student)'),
          onBusCardTap: () => navigateToScreen('ETA & Stop Details'),
        );

      case 'Route & Stops Screen':
        return RoutesScreen(
          onRouteSelected: (route) => navigateToScreen('ETA & Stop Details'),
        );

      case 'ETA & Stop Details':
        return EtaDetailsScreen(
          onBack: () => navigateToScreen('Route & Stops Screen'),
          onViewFullRoute: () => navigateToScreen('Bus Occupancy'),
        );

      case 'Bus Occupancy':
        return BusOccupancyScreen(
          onBackToMap: () => navigateToScreen('Live Tracking Map'),
        );

      case 'Notifications':
        return const NotificationsScreen();

      case 'Feedback / Complaint':
        return FeedbackScreen(
          onBack: () => navigateToScreen('Home Screen (Student)'),
        );

      case 'Driver Dashboard':
        return DriverDashboardScreen(
          onLogout: () => navigateToScreen('Login Screen'),
        );

      case 'Admin Panel':
        return AdminDashboardScreen(
          onLogout: () => navigateToScreen('Login Screen'),
        );

      case 'SOS Button':
        return SosScreen(
          onBack: () => navigateToScreen('Home Screen (Student)'),
        );

      case 'Favorite Routes':
        return FavoriteRoutesScreen(
          onBack: () => navigateToScreen('Home Screen (Student)'),
          onRouteSelected: (route) => navigateToScreen('ETA & Stop Details'),
        );

      case 'Settings / Profile':
        return ProfileScreen(
          onLogout: () => navigateToScreen('Login Screen'),
          onNavigate: navigateToScreen,
        );

      default:
        return StudentHomeScreen(onNavigate: navigateToScreen);
    }
  }
}
