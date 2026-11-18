import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../routes/app_routes.dart';

class EnableLocationScreen extends StatefulWidget {
  const EnableLocationScreen({super.key});

  @override
  State<EnableLocationScreen> createState() => _EnableLocationScreenState();
}

class _EnableLocationScreenState extends State<EnableLocationScreen> {
  bool _isLoading = false;

  Future<void> _handleEnableLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please turn on GPS/Location services on your device'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        setState(() {
          _isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Location permissions are required to deliver your food'),
                backgroundColor: Colors.red,
              ),
            );
          }
          setState(() {
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location permission is permanently denied. Please enable it in Settings'),
              backgroundColor: Colors.red,
            ),
          );
        }
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Fetch Live GPS Position
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      String locationName = 'Current Location';
      String cityName = 'Your City';

      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          locationName = place.subLocality?.isNotEmpty == true
              ? place.subLocality!
              : (place.street?.isNotEmpty == true ? place.street! : place.name ?? 'Current Area');
          cityName = place.locality?.isNotEmpty == true
              ? place.locality!
              : (place.subAdministrativeArea ?? 'City');
        }
      } catch (e) {
        // Fallback if geocoding fails
        locationName = 'Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}';
      }

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        Navigator.pushNamed(
          context,
          AppRoutes.confirmLocation,
          arguments: {
            'locationName': locationName,
            'cityName': cityName,
            'latitude': position.latitude,
            'longitude': position.longitude,
          },
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      // Fallback navigation if GPS timeout occurs
      if (mounted) {
        Navigator.pushNamed(
          context,
          AppRoutes.confirmLocation,
          arguments: {
            'locationName': 'Mimec IT Park',
            'cityName': 'Ranchi',
            'latitude': 23.3441,
            'longitude': 85.3096,
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top Food Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.38,
            child: Image.network(
              'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800&auto=format&fit=crop',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.orange.shade100,
                child: const Icon(
                  Icons.restaurant_rounded,
                  size: 80,
                  color: Color(0xFFC82819),
                ),
              ),
            ),
          ),

          // Bottom Sheet Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.68,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10.0),

                    // Map Pin Graphic Illustration
                    SizedBox(
                      height: 140,
                      width: 180,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Folded map representation background
                          Container(
                            width: 140,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.lightGreen.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.lightGreen.shade300,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.green.shade100.withValues(alpha: 0.3),
                                  ),
                                ),
                                Container(width: 1, color: Colors.green.shade200),
                                Expanded(
                                  child: Container(
                                    color: Colors.yellow.shade100.withValues(alpha: 0.3),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Large Red Location Pin
                          const Positioned(
                            top: 10,
                            child: Icon(
                              Icons.location_on_rounded,
                              size: 80,
                              color: Color(0xFFEA4335),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Title & Subtitle
                    const Text(
                      'Enable Location',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Device location not enabled\nEnable for a better delivery experience',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // Enable Current Location Button
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleEnableLocation,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFBAD27),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.my_location_rounded, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'Enable Current location',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // Divider Or
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            'or',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),
                    const SizedBox(height: 20.0),

                    // Select Delivery Location Heading
                    const Text(
                      'Select delivery location',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 12.0),

                    // Search Location Pill Bar
                    InkWell(
                      onTap: _handleEnableLocation,
                      borderRadius: BorderRadius.circular(25.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search_rounded,
                                size: 20, color: Colors.grey.shade600),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Search for area, street name',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios_rounded,
                                size: 16, color: Colors.grey.shade600),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
