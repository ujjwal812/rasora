import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        title: const Text(
          'Track Order Status',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Header
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF27AE60), width: 2.5),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.person, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pankaj Kumar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFC82819),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Active User',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, color: Color(0xFFE2E8F0)),
              const SizedBox(height: 16),

              // Check your order Status Section Title
              const Text(
                'Check your order Status',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 20),

              // Order Status Timeline
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  children: [
                    // Step 1: Order Placed
                    _buildTimelineStep(
                      icon: Icons.shopping_cart_outlined,
                      showCheckOnIcon: true,
                      title: 'Order placed',
                      timestamp: 'on 12 Oct, 2025, at 07.30pm',
                      byWho: 'BY YOU',
                      isCompleted: true,
                      lineColor: Colors.grey.shade300,
                    ),

                    // Step 2: Order Accepted
                    _buildTimelineStep(
                      icon: Icons.restaurant_outlined,
                      title: 'Order accepted',
                      timestamp: 'on 12 Oct, 2025, at 07.40pm',
                      byWho: 'BY KITCHEN',
                      isCompleted: true,
                      lineColor: Colors.grey.shade300,
                    ),

                    // Step 3: Food Accepted
                    _buildTimelineStep(
                      icon: Icons.two_wheeler_outlined,
                      title: 'Food Accepted',
                      timestamp: 'on 12 Oct, 2025, at 08.40pm',
                      byWho: 'BY DELIVERY BOY',
                      isCompleted: true,
                      lineColor: const Color(0xFF27AE60),
                    ),

                    // Step 4: Delivery Near You
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 14),
                        const Icon(
                          Icons.two_wheeler_rounded,
                          color: Color(0xFFEA580C),
                          size: 26,
                        ),
                        const SizedBox(width: 24),
                        const Text(
                          'Delivery near you',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // your lunch time soon. pick now Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFFFEDD5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'your lunch time soon. pick now',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              children: [
                                _buildFoodPickerItem(
                                  title: 'Fish - Rice',
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=300',
                                ),
                                const SizedBox(width: 12),
                                _buildFoodPickerItem(
                                  title: 'Veg Thali',
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1610192244261-3f33de3f55e4?w=300',
                                ),
                                const SizedBox(width: 12),
                                _buildFoodPickerItem(
                                  title: 'Mutton Thali',
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=300',
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFEA580C)),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: Color(0xFFEA580C),
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Your Plan has been activated Button/Badge
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Your Plan has been activated',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineStep({
    required IconData icon,
    bool showCheckOnIcon = false,
    required String title,
    required String timestamp,
    required String byWho,
    required bool isCompleted,
    required Color lineColor,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circle Icon
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(icon, size: 26, color: const Color(0xFF333333)),
                if (showCheckOnIcon)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Color(0xFF27AE60),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, size: 10, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Vertical Line with Bullet Dot
          Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: isCompleted ? const Color(0xFF27AE60) : Colors.grey.shade400,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: lineColor,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  timestamp,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E1E1E),
                  ),
                ),
                const Divider(height: 12),
                Text(
                  byWho,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey.shade700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodPickerItem({
    required String title,
    required String imageUrl,
  }) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E1E1E),
          ),
        ),
      ],
    );
  }
}
