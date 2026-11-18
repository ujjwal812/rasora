import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  final List<Map<String, String>> _categories = [
    {
      'title': 'All',
      'image':
          'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=300&auto=format&fit=crop'
    },
    {
      'title': 'Veg',
      'image':
          'https://images.unsplash.com/photo-1610057099443-f63a11880797?w=300&auto=format&fit=crop'
    },
    {
      'title': 'Mixed',
      'image':
          'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=300&auto=format&fit=crop'
    },
    {
      'title': 'Premium',
      'image':
          'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=300&auto=format&fit=crop'
    },
  ];

  Widget _buildCategoryItem(String title, String imageUrl, bool isSelected) {
    final bgColor =
        isSelected ? const Color(0xFFFBB03B) : const Color(0xFFF0F0F0);
    final textColor = isSelected ? Colors.white : const Color(0xFF666666);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = title;
        });
      },
      child: Container(
        width: 82,
        margin: const EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 6.0),
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: ClipOval(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    'assets/images/rasora_logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.rice_bowl_rounded,
                      color: Color(0xFFD84A1D),
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6.0),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String subtitle,
    required String price,
    required List<String> dishImages,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF6E5),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Subtitle
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF222222),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // 3 Dish Thumbnails Row
                  Row(
                    children: dishImages.map((url) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: SizedBox(
                              height: 75,
                              child: Image.network(
                                url,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/images/rasora_logo.png',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.fastfood,
                                          color: Colors.orange),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16.0),

                  // Meal Types & Availability Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left: Breakfast, Lunch, Dinner
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.free_breakfast_outlined,
                                    size: 18, color: Colors.red.shade700),
                                const SizedBox(width: 6),
                                const Expanded(
                                  child: Text(
                                    'Breakfast',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF222222),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.rice_bowl_outlined,
                                    size: 18, color: Colors.amber.shade800),
                                const SizedBox(width: 6),
                                const Expanded(
                                  child: Text(
                                    'Lunch',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF222222),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.dinner_dining_outlined,
                                    size: 18, color: Colors.deepOrange),
                                const SizedBox(width: 6),
                                const Expanded(
                                  child: Text(
                                    'Dinner',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF222222),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Vertical Divider
                      Container(
                        width: 1,
                        height: 70,
                        color: Colors.orange.shade200,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                      ),

                      // Right: Availability & Day Badges
                      Expanded(
                        flex: 6,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Availability',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF666666),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Day Badges (S M T W T F S)
                            Wrap(
                              spacing: 3,
                              runSpacing: 3,
                              children: [
                                _buildDayChip('S', isSelected: true),
                                _buildDayChip('M'),
                                _buildDayChip('T'),
                                _buildDayChip('W'),
                                _buildDayChip('T'),
                                _buildDayChip('F'),
                                _buildDayChip('S'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Top Right Price Badge
            Positioned(
              top: 0,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 8.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFC82819),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const Text(
                      'Only',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayChip(String day, {bool isSelected = false}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFBB03B) : const Color(0xFFFEE8C8),
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(
        day,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : const Color(0xFF444444),
          decoration: isSelected ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8.0),

              // BOOK A ORDER FOR TRIAL FOR FREE Header
              const Text(
                'BOOK A ORDER FOR TRIAL FOR FREE',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFC82819),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16.0),

              // Category horizontal list (All, Veg, Mixed, Premium)
              SizedBox(
                height: 95,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    return _buildCategoryItem(
                      cat['title']!,
                      cat['image']!,
                      _selectedCategory == cat['title'],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),

              // Choose Subscription Plan Banner
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.planDetails);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 14.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC82819),
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFC82819).withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Choose Subscription Plan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Color(0xFFC82819),
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // Subscription Plan Cards
              _buildPlanCard(
                title: 'PREMIUM PLAN',
                subtitle: '30 DAYS  |  27 TIFFINS',
                price: '₹7500',
                dishImages: const [
                  'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=300&auto=format&fit=crop',
                  'https://images.unsplash.com/photo-1610057099443-f63a11880797?w=300&auto=format&fit=crop',
                  'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=300&auto=format&fit=crop',
                ],
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.planDetails);
                },
              ),

              _buildPlanCard(
                title: 'MIXED PLAN',
                subtitle: '30 DAYS  |  27 TIFFINS',
                price: '₹6500',
                dishImages: const [
                  'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=300&auto=format&fit=crop',
                  'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=300&auto=format&fit=crop',
                  'https://images.unsplash.com/photo-1545247181-516773cae754?w=300&auto=format&fit=crop',
                ],
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.planDetails);
                },
              ),

              _buildPlanCard(
                title: 'VEG PLAN',
                subtitle: '30 DAYS  |  27 TIFFINS',
                price: '₹5500',
                dishImages: const [
                  'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=300&auto=format&fit=crop',
                  'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=300&auto=format&fit=crop',
                  'https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?w=300&auto=format&fit=crop',
                ],
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.planDetails);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
