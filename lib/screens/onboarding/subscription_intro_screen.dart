import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class SubscriptionIntroScreen extends StatelessWidget {
  const SubscriptionIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Top Orange Header with Chef Image and Curved Bottom
                    SizedBox(
                      height: 320,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          // Background Orange Container
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFFD84A1D),
                                    Color(0xFFC82819),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Chef Image
                          Positioned.fill(
                            child: Image.network(
                              'https://images.unsplash.com/photo-1577219491135-ce391730fb2c?w=600&auto=format&fit=crop',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                'assets/images/rasora_logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          // Bottom White Arc Curve Overlay
                          Positioned(
                            bottom: -1,
                            left: 0,
                            right: 0,
                            child: CustomPaint(
                              size: const Size(double.infinity, 50),
                              painter: ArcPainter(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // Heading Text
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        'Choose our subscription\nand get benefits more',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC82819),
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),

                    // Dark Horizontal Divider Line
                    Container(
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF222222),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Subtitle Text
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        'Order a healthy and well balanced\nmeals with our various packages!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Color(0xFF555555),
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28.0),

                    // Next Action Button
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.mainNavigation);
                      },
                      child: Container(
                        width: 62,
                        height: 62,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFC82819),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFBB03B),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: Color(0xFFC82819),
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Footer Row (Back, Dots, Skip)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),

                  // Page Indicator Dots
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFBB03B),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 22,
                        height: 6,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBB03B),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),

                  // Skip
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.mainNavigation);
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for Smooth Upward Arc
class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      0,
      size.width,
      size.height,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
