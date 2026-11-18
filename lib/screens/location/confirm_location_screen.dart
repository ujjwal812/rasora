import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../routes/app_routes.dart';

class ConfirmLocationScreen extends StatefulWidget {
  const ConfirmLocationScreen({super.key});

  @override
  State<ConfirmLocationScreen> createState() => _ConfirmLocationScreenState();
}

class _ConfirmLocationScreenState extends State<ConfirmLocationScreen> {
  String _locationName = 'Mimec IT Park';
  String _cityName = 'Ranchi, Jharkhand';
  double? _latitude = 23.3441;
  double? _longitude = 85.3096;
  bool _isRefreshing = false;
  bool _initializedFromArgs = false;

  final TextEditingController _houseNoController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String _selectedTag = 'Home';
  double _zoomScale = 1.0;

  final List<Map<String, String>> _popularLocations = [
    {'name': 'Mimec IT Park', 'city': 'Ranchi, Jharkhand'},
    {'name': 'Kanke Road', 'city': 'Ranchi, Jharkhand'},
    {'name': 'Lalpur Chowk', 'city': 'Ranchi, Jharkhand'},
    {'name': 'Doranda Main Market', 'city': 'Ranchi, Jharkhand'},
    {'name': 'Hinoo Aerodrome', 'city': 'Ranchi, Jharkhand'},
    {'name': 'Bariatu Housing Colony', 'city': 'Ranchi, Jharkhand'},
  ];

  @override
  void dispose() {
    _houseNoController.dispose();
    _landmarkController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initializedFromArgs) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map<String, dynamic>) {
        setState(() {
          _locationName = args['locationName'] ?? _locationName;
          _cityName = args['cityName'] ?? _cityName;
          _latitude = args['latitude'] ?? _latitude;
          _longitude = args['longitude'] ?? _longitude;
        });
      }
      _initializedFromArgs = true;
    }
  }

  Future<void> _fetchLiveLocation() async {
    setState(() {
      _isRefreshing = true;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please enable GPS/Location on your device'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        setState(() {
          _isRefreshing = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 8),
        ),
      );

      String locName = 'Current Area';
      String cName = 'Current City';

      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          locName = place.subLocality?.isNotEmpty == true
              ? place.subLocality!
              : (place.street?.isNotEmpty == true ? place.street! : 'Current Area');
          cName = place.locality?.isNotEmpty == true
              ? place.locality!
              : (place.subAdministrativeArea ?? 'City');
        }
      } catch (_) {
        locName = 'Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}';
      }

      setState(() {
        _locationName = locName;
        _cityName = cName;
        _latitude = position.latitude;
        _longitude = position.longitude;
        _isRefreshing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Updated Location: $_locationName, $_cityName'),
            backgroundColor: const Color(0xFF27AE60),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isRefreshing = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location updated successfully'),
            backgroundColor: Color(0xFFEA580C),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _showSearchSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final query = _searchController.text.toLowerCase();
            final filtered = _popularLocations.where((loc) {
              return loc['name']!.toLowerCase().contains(query) ||
                  loc['city']!.toLowerCase().contains(query);
            }).toList();

            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Search Location',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchController,
                    autofocus: true,
                    onChanged: (val) {
                      setSheetState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for area, street, landmark...',
                      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                      prefixIcon: const Icon(Icons.search, color: Color(0xFFEA580C)),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 20),
                              onPressed: () {
                                _searchController.clear();
                                setSheetState(() {});
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF7ED),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.my_location, color: Color(0xFFEA580C), size: 20),
                    ),
                    title: const Text(
                      'Use Current Location',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: const Text(
                      'Using GPS for high accuracy',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _fetchLiveLocation();
                    },
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'POPULAR PLACES',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: filtered.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final item = filtered[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.location_on_outlined, color: Colors.grey),
                          title: Text(
                            item['name']!,
                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          subtitle: Text(
                            item['city']!,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          onTap: () {
                            setState(() {
                              _locationName = item['name']!;
                              _cityName = item['city']!;
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirm location',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
            Text(
              '⚡ Delivery in 25-30 mins',
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xFF27AE60),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Realistic Map View Section
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Full-bleed Dynamic Map Canvas Background
                Positioned.fill(
                  child: AnimatedScale(
                    scale: _zoomScale,
                    duration: const Duration(milliseconds: 300),
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: MapBackgroundPainter(),
                    ),
                  ),
                ),

                // Top Search Bar & Preset Chips Overlay
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _showSearchSheet,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search, size: 20, color: Color(0xFFEA580C)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Search for a new area, locality...',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF7ED),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.tune_rounded,
                                  size: 16,
                                  color: Color(0xFFEA580C),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Quick tag filter chips floating under search bar
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            _buildQuickChip('📍 Live GPS', () => _fetchLiveLocation()),
                            const SizedBox(width: 6),
                            _buildQuickChip('🏠 Home', () {
                              setState(() {
                                _locationName = 'Mimec IT Park';
                                _cityName = 'Ranchi, Jharkhand';
                              });
                            }),
                            const SizedBox(width: 6),
                            _buildQuickChip('🏢 Work', () {
                              setState(() {
                                _locationName = 'Lalpur Main Market';
                                _cityName = 'Ranchi, Jharkhand';
                              });
                            }),
                            const SizedBox(width: 6),
                            _buildQuickChip('🌳 Park View', () {
                              setState(() {
                                _locationName = 'Kanke Road';
                                _cityName = 'Ranchi, Jharkhand';
                              });
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Map North Direction / Compass Indicator Badge (Top Right Overlay)
                Positioned(
                  top: 100,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.rotate(
                          angle: -0.2,
                          child: const Icon(
                            Icons.navigation_rounded,
                            size: 16,
                            color: Color(0xFFEA4335),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'N',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E1E1E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Map Pin with Dynamic Tooltip Badge & Target Radar Base
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Floating Location Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.near_me_rounded,
                              size: 14,
                              color: Color(0xFFEA580C),
                            ),
                            const SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _locationName,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E1E1E),
                                  ),
                                ),
                                Text(
                                  _cityName,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Animated Red Location Pin Marker
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 52,
                            color: Color(0xFFEA4335),
                          ),
                          Positioned(
                            top: 12,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Radar / Accuracy base pulse circle
                      Container(
                        width: 32,
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.elliptical(16, 6)),
                          color: Colors.black.withValues(alpha: 0.2),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFEA580C).withValues(alpha: 0.3),
                              blurRadius: 8,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Floating Action Controls (Zoom & Current Location Buttons)
                Positioned(
                  right: 16,
                  bottom: 24,
                  child: Column(
                    children: [
                      // Zoom In Button
                      FloatingActionButton.small(
                        heroTag: 'zoom_in',
                        onPressed: () {
                          setState(() {
                            if (_zoomScale < 1.4) _zoomScale += 0.15;
                          });
                        },
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1E1E1E),
                        elevation: 4,
                        child: const Icon(Icons.add, size: 20),
                      ),
                      const SizedBox(height: 8),
                      // Zoom Out Button
                      FloatingActionButton.small(
                        heroTag: 'zoom_out',
                        onPressed: () {
                          setState(() {
                            if (_zoomScale > 0.85) _zoomScale -= 0.15;
                          });
                        },
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1E1E1E),
                        elevation: 4,
                        child: const Icon(Icons.remove, size: 20),
                      ),
                      const SizedBox(height: 12),
                      // Live Location GPS Button
                      FloatingActionButton(
                        heroTag: 'live_loc',
                        onPressed: _isRefreshing ? null : _fetchLiveLocation,
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFFEA580C),
                        elevation: 6,
                        child: _isRefreshing
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Color(0xFFEA580C),
                                ),
                              )
                            : const Icon(Icons.my_location_rounded, size: 22),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Address & Confirmation Sheet
          Container(
            padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 24.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 16,
                  offset: Offset(0, -6),
                ),
              ],
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle Bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14.0),

                  // Header title
                  const Text(
                    'Delivering your order to',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  // Location Address Card
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF7ED),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.location_on_rounded,
                            color: Color(0xFFEA580C),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12.0),

                        // Location Title & Subtitle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _locationName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E1E1E),
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                _cityName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Change Button
                        SizedBox(
                          height: 34,
                          child: OutlinedButton(
                            onPressed: _showSearchSheet,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFEA580C),
                              side: const BorderSide(color: Color(0xFFEA580C)),
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'Change',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14.0),

                  // House / Flat / Landmark Inputs
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _houseNoController,
                          style: const TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            labelText: 'House / Flat / Block',
                            hintText: 'e.g. Flat 402',
                            hintStyle: TextStyle(fontSize: 11, color: Colors.grey.shade400),
                            labelStyle: const TextStyle(fontSize: 11),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _landmarkController,
                          style: const TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            labelText: 'Landmark (Optional)',
                            hintText: 'e.g. Near Park',
                            hintStyle: TextStyle(fontSize: 11, color: Colors.grey.shade400),
                            labelStyle: const TextStyle(fontSize: 11),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14.0),

                  // Tag selection pills (Home / Work / Other) - FIXED HORIZONTAL OVERFLOW
                  Row(
                    children: [
                      Text(
                        'Save address as:',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              _buildTagChip('Home', Icons.home_rounded),
                              const SizedBox(width: 6),
                              _buildTagChip('Work', Icons.work_rounded),
                              const SizedBox(width: 6),
                              _buildTagChip('Other', Icons.location_on_rounded),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),

                  // Confirm Location Primary Button
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        final fullAddress = '${_houseNoController.text.isNotEmpty ? '${_houseNoController.text}, ' : ''}$_locationName, $_cityName';
                        Navigator.pushNamed(
                          context,
                          AppRoutes.payment,
                          arguments: {
                            'locationName': _locationName,
                            'cityName': _cityName,
                            'fullAddress': fullAddress,
                            'latitude': _latitude,
                            'longitude': _longitude,
                            'tag': _selectedTag,
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFBAD27),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Confirm Location',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  // Request address from someone else Button
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Shareable address link copied to clipboard!'),
                          backgroundColor: Color(0xFF27AE60),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(14.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person_add_alt_1_rounded,
                                  size: 18,
                                  color: Colors.grey.shade700,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Request address from someone else',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: Colors.grey.shade700,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickChip(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E1E1E),
          ),
        ),
      ),
    );
  }

  Widget _buildTagChip(String label, IconData icon) {
    final isSelected = _selectedTag == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTag = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF7ED) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFEA580C) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: isSelected ? const Color(0xFFEA580C) : Colors.grey.shade600,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? const Color(0xFFEA580C) : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for Realistic Map Vector Design (Roads, Greenery, Water, Buildings, Route & Directions)
class MapBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    // 1. Base Map Ground Color
    final bgPaint = Paint()..color = const Color(0xFFE8ECEF);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // 2. Green Nature / Park Zones
    final parkPaint = Paint()
      ..color = const Color(0xFFD0E7D2)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.05, size.height * 0.06, size.width * 0.38, size.height * 0.22),
        const Radius.circular(16),
      ),
      parkPaint,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.55, size.height * 0.55, size.width * 0.38, size.height * 0.28),
        const Radius.circular(20),
      ),
      parkPaint,
    );

    // 3. Water Body / River Feature
    final waterPaint = Paint()
      ..color = const Color(0xFFBBE3F7)
      ..style = PaintingStyle.fill;

    final riverPath = Path()
      ..moveTo(0, size.height * 0.32)
      ..cubicTo(
        size.width * 0.3, size.height * 0.28,
        size.width * 0.4, size.height * 0.44,
        size.width * 0.7, size.height * 0.38,
      )
      ..cubicTo(
        size.width * 0.85, size.height * 0.35,
        size.width * 0.9, size.height * 0.18,
        size.width, size.height * 0.14,
      )
      ..lineTo(size.width, size.height * 0.22)
      ..cubicTo(
        size.width * 0.9, size.height * 0.42,
        size.width * 0.8, size.height * 0.45,
        size.width * 0.7, size.height * 0.46,
      )
      ..cubicTo(
        size.width * 0.4, size.height * 0.50,
        size.width * 0.3, size.height * 0.36,
        0, size.height * 0.40,
      )
      ..close();
    canvas.drawPath(riverPath, waterPaint);

    // 4. Urban Land Blocks / Residential Parcels
    final blockPaint = Paint()..color = const Color(0xFFDCDEE4);
    final blocks = [
      Rect.fromLTWH(size.width * 0.45, size.height * 0.1, size.width * 0.24, size.height * 0.14),
      Rect.fromLTWH(size.width * 0.08, size.height * 0.46, size.width * 0.18, size.height * 0.16),
      Rect.fromLTWH(size.width * 0.32, size.height * 0.52, size.width * 0.18, size.height * 0.14),
      Rect.fromLTWH(size.width * 0.68, size.height * 0.12, size.width * 0.25, size.height * 0.18),
      Rect.fromLTWH(size.width * 0.12, size.height * 0.7, size.width * 0.35, size.height * 0.18),
    ];
    for (var b in blocks) {
      canvas.drawRRect(RRect.fromRectAndRadius(b, const Radius.circular(8)), blockPaint);
    }

    // 5. Road Networks (Highways, Arterial, Secondary)
    final mainRoadBorderPaint = Paint()
      ..color = const Color(0xFFB0BEC5)
      ..strokeWidth = 18
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final mainRoadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final highwayBorderPaint = Paint()
      ..color = const Color(0xFFF57F17)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke;

    final highwayPaint = Paint()
      ..color = const Color(0xFFFFD54F)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    final secondaryRoadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke;

    // Main Diagonal Arterial Road (Kanke Road)
    final roadPath1 = Path()
      ..moveTo(0, size.height * 0.22)
      ..lineTo(size.width * 0.45, size.height * 0.30)
      ..lineTo(size.width, size.height * 0.68);

    canvas.drawPath(roadPath1, mainRoadBorderPaint);
    canvas.drawPath(roadPath1, mainRoadPaint);

    // Highway Road (Ranchi Highway)
    final roadPath2 = Path()
      ..moveTo(size.width * 0.52, 0)
      ..lineTo(size.width * 0.48, size.height);

    canvas.drawPath(roadPath2, highwayBorderPaint);
    canvas.drawPath(roadPath2, highwayPaint);

    // Grid / Secondary streets
    canvas.drawLine(
        Offset(0, size.height * 0.62), Offset(size.width, size.height * 0.62), secondaryRoadPaint);
    canvas.drawLine(
        Offset(size.width * 0.24, 0), Offset(size.width * 0.24, size.height * 0.5), secondaryRoadPaint);
    canvas.drawLine(
        Offset(size.width * 0.76, size.height * 0.28), Offset(size.width * 0.76, size.height), secondaryRoadPaint);
    canvas.drawLine(
        Offset(0, size.height * 0.82), Offset(size.width * 0.8, size.height * 0.82), secondaryRoadPaint);

    // 6. Map Direction Navigation Route Line (Vibrant Blue Path with Direction Arrows)
    final routeBorderPaint = Paint()
      ..color = const Color(0xFF1E40AF)
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final routePaint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final directionPath = Path()
      ..moveTo(size.width * 0.15, size.height * 0.82)
      ..lineTo(size.width * 0.24, size.height * 0.62)
      ..lineTo(size.width * 0.45, size.height * 0.62)
      ..lineTo(size.width * 0.50, size.height * 0.50);

    canvas.drawPath(directionPath, routeBorderPaint);
    canvas.drawPath(directionPath, routePaint);

    // Directional Arrow Head pointing towards target pin
    final arrowPaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..style = PaintingStyle.fill;

    final arrowPath = Path()
      ..moveTo(size.width * 0.50, size.height * 0.48)
      ..lineTo(size.width * 0.48, size.height * 0.52)
      ..lineTo(size.width * 0.52, size.height * 0.52)
      ..close();
    canvas.drawPath(arrowPath, arrowPaint);

    // 7. Street Name Text Labels on Map
    _drawStreetLabel(canvas, 'Kanke Road', Offset(size.width * 0.12, size.height * 0.24), 0.18);
    _drawStreetLabel(canvas, 'Ranchi Hwy', Offset(size.width * 0.54, size.height * 0.15), 1.57);
    _drawStreetLabel(canvas, 'IT Park Ave', Offset(size.width * 0.28, size.height * 0.60), 0);
  }

  void _drawStreetLabel(Canvas canvas, String text, Offset position, double rotation) {
    canvas.save();
    canvas.translate(position.dx, position.dy);
    canvas.rotate(rotation);

    final textSpan = TextSpan(
      text: text,
      style: const TextStyle(
        color: Color(0xFF475569),
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.8,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final bgRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(-4, -2, textPainter.width + 8, textPainter.height + 4),
      const Radius.circular(4),
    );
    canvas.drawRRect(
      bgRect,
      Paint()..color = Colors.white.withValues(alpha: 0.85),
    );

    textPainter.paint(canvas, Offset.zero);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
