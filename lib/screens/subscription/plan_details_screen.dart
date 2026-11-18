import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class PlanDetailsScreen extends StatefulWidget {
  const PlanDetailsScreen({super.key});

  @override
  State<PlanDetailsScreen> createState() => _PlanDetailsScreenState();
}

class _PlanDetailsScreenState extends State<PlanDetailsScreen> {
  String _selectedTime = 'Lunch';

  final List<Map<String, String>> _lunchItems = [
    {
      'name': 'Fish Rice',
      'image':
          'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=400&auto=format&fit=crop'
    },
    {
      'name': 'Veg Thali',
      'image':
          'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=400&auto=format&fit=crop'
    },
    {
      'name': 'Egg rice',
      'image':
          'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=400&auto=format&fit=crop'
    },
    {
      'name': 'Rice Mutton',
      'image':
          'https://images.unsplash.com/photo-1545247181-516773cae754?w=400&auto=format&fit=crop'
    },
    {
      'name': 'Polao Tarka',
      'image':
          'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=400&auto=format&fit=crop'
    },
    {
      'name': 'Idli Set',
      'image':
          'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=400&auto=format&fit=crop'
    },
  ];

  final List<Map<String, String>> _breakfastItems = [
    {
      'name': 'Dosa Set',
      'image':
          'https://images.unsplash.com/photo-1610057099443-f63a11880797?w=400&auto=format&fit=crop'
    },
    {
      'name': 'Poori Set',
      'image':
          'https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?w=400&auto=format&fit=crop'
    },
    {
      'name': 'Idli Set',
      'image':
          'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=400&auto=format&fit=crop'
    },
    {
      'name': 'Paneer Wrap',
      'image':
          'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=400&auto=format&fit=crop'
    },
    {
      'name': 'Veg Uttapam',
      'image':
          'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=400&auto=format&fit=crop'
    },
    {
      'name': 'Sambar Vada',
      'image':
          'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=400&auto=format&fit=crop'
    },
  ];

  Widget _buildTimePill(String title) {
    final isSelected = _selectedTime == title;
    final bgColor =
        isSelected ? const Color(0xFFC82819) : const Color(0xFFEFEFEF);
    final textColor = isSelected ? Colors.white : const Color(0xFF555555);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTime = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 15,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealCard(Map<String, String> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16.0)),
              child: Image.network(
                item['image']!,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.orange.shade50,
                  child: const Icon(Icons.fastfood,
                      color: Color(0xFFC82819), size: 36),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
            child: Column(
              children: [
                Text(
                  item['name']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 4.0),
                SizedBox(
                  height: 26,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.foodDetails);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFBB03B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items =
        _selectedTime == 'Breakfast' ? _breakfastItems : _lunchItems;

    final expectedTime = _selectedTime == 'Breakfast'
        ? '09:00 AM to 10:00 AM'
        : '01:30 PM to 02:30 PM';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Plan Details'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF222222),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Large Header Banner Image
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.amber.shade50,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800&auto=format&fit=crop',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.orange.shade100,
                        child: const Icon(Icons.restaurant,
                            size: 80, color: Color(0xFFC82819)),
                      ),
                    ),
                  ),

                  // Bottom 4 thumbnails overlay inside top header image
                  Positioned(
                    bottom: 12,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=200',
                        'https://images.unsplash.com/photo-1610057099443-f63a11880797?w=200',
                        'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=200',
                        'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=200',
                      ].map((url) {
                        return Container(
                          width: 55,
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              url,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.fastfood,
                                      size: 20, color: Colors.orange),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Price Tag Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PREMIUM PLAN',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF222222),
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            '30 DAYS  |  27 TIFFINS',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      // Red Price Tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC82819),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              '₹7500',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
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
                    ],
                  ),
                  const SizedBox(height: 20.0),

                  // Time Selection Section
                  const Text(
                    'Time :',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222222),
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        _buildTimePill('Breakfast'),
                        const SizedBox(width: 8),
                        _buildTimePill('Lunch'),
                        const SizedBox(width: 8),
                        _buildTimePill('Dinner'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Yellow Container with Items Grid
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1D6),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Items on $_selectedTime',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF222222),
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          'Expected Delivery On $expectedTime',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 16.0),

                        // Grid of 6 Items
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            return _buildMealCard(items[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
