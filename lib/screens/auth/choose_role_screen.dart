import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  String _selectedRole = 'Customer';

  Widget _buildRoleCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final cardBgColor = isSelected ? const Color(0xFFFED89B) : Colors.white;
    const iconCircleBg = Color(0xFFD84315);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Material(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(40.0),
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.15),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(40.0),
          child: Container(
            height: 68.0,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: [
                // Circular icon badge
                Container(
                  width: 52.0,
                  height: 52.0,
                  decoration: const BoxDecoration(
                    color: iconCircleBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 28.0,
                  ),
                ),
                const SizedBox(width: 16.0),
                // Role Title
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? const Color(0xFF4E2606)
                          : const Color(0xFF333333),
                    ),
                  ),
                ),
                // Arrow
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: Color(0xFF333333),
                  size: 24.0,
                ),
                const SizedBox(width: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD84A1D), // Dark warm orange top
              Color(0xFFEA7A42), // Orange gradient transition
              Color(0xFFF3D2B8), // Soft warm peach middle
              Color(0xFFC8ECE3), // Light mint cyan bottom
            ],
            stops: [0.0, 0.35, 0.65, 1.0],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const SizedBox(height: 36.0),
                        // Header Title
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            'Choose your category\nto login account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.3,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32.0),

                        // Customer Role
                        _buildRoleCard(
                          title: 'Customer',
                          icon: Icons.person,
                          isSelected: _selectedRole == 'Customer',
                          onTap: () {
                            setState(() {
                              _selectedRole = 'Customer';
                            });
                            Navigator.pushNamed(context, AppRoutes.login);
                          },
                        ),

                        // Deliver Partner Role
                        _buildRoleCard(
                          title: 'Deliver Partner',
                          icon: Icons.delivery_dining,
                          isSelected: _selectedRole == 'Deliver Partner',
                          onTap: () {
                            setState(() {
                              _selectedRole = 'Deliver Partner';
                            });
                            Navigator.pushNamed(context, AppRoutes.login);
                          },
                        ),

                        // Kitchen Partner Role
                        _buildRoleCard(
                          title: 'Kitchen Partner',
                          icon: Icons.soup_kitchen,
                          isSelected: _selectedRole == 'Kitchen Partner',
                          onTap: () {
                            setState(() {
                              _selectedRole = 'Kitchen Partner';
                            });
                            Navigator.pushNamed(context, AppRoutes.login);
                          },
                        ),

                        const Spacer(),

                        // Bottom Delivery Scooter Illustration Graphic
                        SizedBox(
                          height: 220,
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              // City background skyline opacity
                              Positioned(
                                bottom: 30,
                                child: Icon(
                                  Icons.location_city_rounded,
                                  size: 150,
                                  color: Colors.teal.shade100.withValues(alpha: 0.4),
                                ),
                              ),
                              // Scooter delivery rider illustration representation
                              Positioned(
                                bottom: 10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.two_wheeler_rounded,
                                      size: 130,
                                      color: Colors.lightGreen.shade700,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
