import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../widgets/subscription_card.dart';

class ChoosePackageScreen extends StatelessWidget {
  const ChoosePackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7),
      appBar: AppBar(
        title: const Text(
          'Choose Package',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF222222),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF222222),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 4.0, bottom: 16.0),
              child: Text(
                'Choose one from 3 offering packages',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF666666),
                ),
              ),
            ),

            // Premium Plan
            SubscriptionCard(
              title: 'PREMIUM PLAN',
              subtitle: '30 DAYS  |  27 TIFFINS',
              startDate: '12 October',
              endDate: '12 November',
              subscriptionNo: 'EATO/001/2025',
              price: '₹7500.00 only',
              bottomBannerColor: const Color(0xFFC82819),
              isPrimaryActive: true,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.payment);
              },
            ),

            // Mixed Plan
            SubscriptionCard(
              title: 'MIXED PLAN',
              subtitle: '30 DAYS  |  27 TIFFINS',
              startDate: '12 October',
              endDate: '12 November',
              subscriptionNo: 'EATO/001/2025',
              price: '₹6500.00 only',
              bottomBannerColor: const Color(0xFF3B6F9A),
              isPrimaryActive: false,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.payment);
              },
            ),

            // Silver Plan
            SubscriptionCard(
              title: 'SILVER PLAN',
              subtitle: '30 DAYS  |  27 TIFFINS',
              startDate: '12 October',
              endDate: '12 November',
              subscriptionNo: 'EATO/001/2025',
              price: '₹4500.00 only',
              bottomBannerColor: const Color(0xFF27AE60),
              isPrimaryActive: false,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.payment);
              },
            ),

            const SizedBox(height: 8.0),
            Center(
              child: Text(
                'Note : Add on Menu will be charges extra pay',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
