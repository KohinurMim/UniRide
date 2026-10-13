import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class MapPlaceholder extends StatelessWidget {
  final String busEta;
  final String busOccupancy;
  final bool showBusBadge;
  final double height;

  const MapPlaceholder({
    super.key,
    this.busEta = '7 min',
    this.busOccupancy = 'Almost Full',
    this.showBusBadge = true,
    this.height = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: const Color(0xFFE5ECE2),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: MapPainter(),
            ),
          ),
          Positioned(
            top: 100,
            right: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.location_on, color: Color(0xFF94A3B8), size: 24),
                Text(
                  'Central Library',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475569),
                    backgroundColor: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 220,
            left: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.school, color: AppColors.primary, size: 28),
                Text(
                  'University',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    backgroundColor: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 140,
            left: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (showBusBadge)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bus 03',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'ETA: $busEta',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.occupancyAlmostFull,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              busOccupancy,
                              style: const TextStyle(
                                fontSize: 9,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.directions_bus,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    final innerRoadPaint = Paint()
      ..color = const Color(0xFFF8FAFC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    final routePolylinePaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final Path mainRoad = Path();
    mainRoad.moveTo(30, 40);
    mainRoad.quadraticBezierTo(size.width * 0.4, 80, size.width * 0.5, 180);
    mainRoad.quadraticBezierTo(size.width * 0.6, 280, size.width - 40, 350);

    final Path secondaryRoad = Path();
    secondaryRoad.moveTo(size.width - 20, 100);
    secondaryRoad.lineTo(80, 250);
    secondaryRoad.lineTo(40, size.height - 50);

    canvas.drawPath(mainRoad, roadPaint);
    canvas.drawPath(mainRoad, innerRoadPaint);

    canvas.drawPath(secondaryRoad, roadPaint);
    canvas.drawPath(secondaryRoad, innerRoadPaint);

    final Path busRoute = Path();
    busRoute.moveTo(80, 250);
    busRoute.lineTo(180, 170);
    busRoute.lineTo(135, 230);

    canvas.drawPath(busRoute, routePolylinePaint);

    final stopDotPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    canvas.drawCircle(const Offset(80, 250), 6, stopDotPaint);
    canvas.drawCircle(const Offset(135, 230), 8, stopDotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
