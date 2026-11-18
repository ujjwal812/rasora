import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class FoodMenuScreen extends StatefulWidget {
  const FoodMenuScreen({super.key});

  @override
  State<FoodMenuScreen> createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  final List<Map<String, String>> _menuItems = [
    {
      'title': 'North Indian Special Thali',
      'subtitle': '4 Roti, Paneer Sabzi, Dal Tadka, Rice, Sweet',
      'price': '₹180',
      'image':
          'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=500&auto=format&fit=crop',
    },
    {
      'title': 'South Indian Meal Combo',
      'subtitle': '3 Dosa, Sambar, Coconut Chutney, Potato Masala',
      'price': '₹150',
      'image':
          'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=500&auto=format&fit=crop',
    },
    {
      'title': 'Special Hyderabadi Biryani',
      'subtitle': 'Aromatic Basmati Rice with Spices & Raita',
      'price': '₹220',
      'image':
          'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=500&auto=format&fit=crop',
    },
    {
      'title': 'Homely Deluxe Veg Thali',
      'subtitle': 'Jeera Rice, Chole, Chapati, Salad, Curd',
      'price': '₹160',
      'image':
          'https://images.unsplash.com/photo-1610057099443-f63a11880797?w=500&auto=format&fit=crop',
    },
    {
      'title': 'Egg Curry Rice Bowl',
      'subtitle': '2 Egg Curry + Steamed Basmati Rice',
      'price': '₹140',
      'image':
          'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=500&auto=format&fit=crop',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Quick Order Menu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF222222),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _menuItems.length,
        itemBuilder: (context, index) {
          final item = _menuItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.foodDetails);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Food Image
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(16.0)),
                    child: Image.network(
                      item['image']!,
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 110,
                        height: 110,
                        color: Colors.orange.shade100,
                        child: const Icon(Icons.fastfood,
                            color: Color(0xFFC82819), size: 40),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),

                  // Details
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF222222),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            item['subtitle']!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item['price']!,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFC82819),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFBB03B),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'Order Now',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
