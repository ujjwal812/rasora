import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({super.key});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int _selectedDayIndex = 0;
  final Set<int> _selectedAddons = {};

  final List<Map<String, String>> _days = [
    {'day': 'MON', 'date': '13 Oct'},
    {'day': 'TUE', 'date': '14 Oct'},
    {'day': 'WED', 'date': '15 Oct'},
    {'day': 'THU', 'date': '16 Oct'},
    {'day': 'FRI', 'date': '17 Oct'},
    {'day': 'SAT', 'date': '18 Oct'},
  ];

  final List<Map<String, String>> _addons = [
    {
      'name': 'Paneer Sabzi',
      'image':
          'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=400&auto=format&fit=crop'
    },
    {
      'name': 'Idli Set',
      'image':
          'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=400&auto=format&fit=crop'
    },
    {
      'name': 'Special Kheer',
      'image':
          'https://images.unsplash.com/photo-1551024709-8f23befc6f87?w=400&auto=format&fit=crop'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Food Details'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF222222),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Large Dish Header Image
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.network(
                'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800&auto=format&fit=crop',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.orange.shade100,
                  child: const Icon(
                    Icons.rice_bowl_rounded,
                    size: 100,
                    color: Color(0xFFC82819),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Expected Delivery Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'VEG THALI',
                            style: TextStyle(
                              fontSize: 24.0,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Expected Delivery :',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          const Text(
                            '01:30 PM to 02:30 PM',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF222222),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),

                  // Description
                  const Text(
                    'DESCRIPTION',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF222222),
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    'A wholesome Veg Thali loaded with homely flavors — fresh chapatis, aromatic rice, seasonal sabzi, rich dal, crunchy salad, tangy pickle, and a comforting sweet touch.',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24.0),

                  // Add More Section
                  const Text(
                    'Add more',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222222),
                    ),
                  ),
                  const SizedBox(height: 12.0),

                  // Horizontal Addons list
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _addons.length,
                      itemBuilder: (context, index) {
                        final isSelected = _selectedAddons.contains(index);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedAddons.remove(index);
                              } else {
                                _selectedAddons.add(index);
                              }
                            });
                          },
                          child: Container(
                            width: 120,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFC82819)
                                    : Colors.grey.shade400,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    _addons[index]['image']!,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      color: Colors.amber.shade50,
                                      child: const Icon(Icons.fastfood,
                                          color: Colors.orange),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: CircleAvatar(
                                    radius: 9,
                                    backgroundColor: isSelected
                                        ? const Color(0xFFC82819)
                                        : Colors.white,
                                    child: Icon(
                                      Icons.check,
                                      size: 12,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    '* Add on Menu will be charges extra',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 24.0),

                  // Choose Your Meals Days
                  const Text(
                    'Choose your meals days',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222222),
                    ),
                  ),
                  const SizedBox(height: 12.0),

                  // Days horizontal selector
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _days.length,
                      itemBuilder: (context, index) {
                        final isSelected = _selectedDayIndex == index;
                        final dayInfo = _days[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDayIndex = index;
                            });
                          },
                          child: Container(
                            width: 60,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFC82819)
                                  : const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFC82819)
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dayInfo['day']!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF333333),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  dayInfo['date']!,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white.withValues(alpha: 0.9)
                                        : Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32.0),

                  // NEXT Button
                  SizedBox(
                    width: double.infinity,
                    height: 52.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.confirmLocation);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC82819),
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        'NEXT',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
