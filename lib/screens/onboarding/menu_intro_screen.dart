import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class MenuIntroScreen extends StatelessWidget {
  const MenuIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Top Gradient Orange Card Container
                  Positioned.fill(
                    bottom: 30,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFD84A1D),
                            Color(0xFFC82819),
                            Color(0xFFB71C1C),
                          ],
                        ),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(36.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 30.0),

                            // Top Circular Food Image with Yellow Accent Background
                            SizedBox(
                              width: 250,
                              height: 250,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Yellow Accent Blob
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFBB03B),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),

                                  // White Circle Frame with Thali Image
                                  Container(
                                    width: 220,
                                    height: 220,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 4.0,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.15),
                                          blurRadius: 15,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=600&auto=format&fit=crop',
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                          'assets/images/rasora_logo.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 28.0),

                            // Heading Text
                            const Text(
                              'CHOOSE FROM\nOUR BEST MENU',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.2,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: 12.0),

                            // Yellow Accent Underline Line
                            Container(
                              width: 50,
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFBB03B),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                            const SizedBox(height: 16.0),

                            // Subtitle Text
                            Text(
                              'Pick Your desired food from the\nmenu there are more than 200 items\nfor Trial only',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.white.withValues(alpha: 0.9),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 50.0),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Overlapping Next Arrow Button
                  Positioned(
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.subscriptionIntro);
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
                  ),
                ],
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
                  Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400,
                    ),
                  ),

                  // Page Indicator Dots
                  Row(
                    children: [
                      Container(
                        width: 22,
                        height: 6,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBB03B),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFBB03B),
                          shape: BoxShape.circle,
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
