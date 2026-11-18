import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    final value = _phoneController.text.trim();
    if (value.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter phone number';
      });
      return;
    }
    if (value.length < 10) {
      setState(() {
        _errorMessage = 'Enter valid 10-digit number';
      });
      return;
    }

    setState(() {
      _errorMessage = null;
    });

    Navigator.pushNamed(context, AppRoutes.otp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Top-right decorative yellow circle curve
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                color: Color(0xFFFBAD27),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20.0),

                          // Top Circular Illustration Container
                          Container(
                            width: 150,
                            height: 150,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 15,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(12),
                                child: Image.asset(
                                  'assets/images/rasora_logo.png',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.smartphone_rounded,
                                    size: 65,
                                    color: Color(0xFFFBAD27),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24.0),

                          // Login Account Heading
                          const Text(
                            'Login Account',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E1E1E),
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            'Please enter your mobile number\nto get an OTP',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey.shade600,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 28.0),

                          // Mobile Number Input Card (Pill Shape)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                    color: _errorMessage != null
                                        ? Colors.red.shade400
                                        : Colors.transparent,
                                    width: 1.2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.04),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    // +91 Circle Badge
                                    Container(
                                      width: 44,
                                      height: 44,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF6C757D),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '+91',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12.0),

                                    // Phone Input Field
                                    Expanded(
                                      child: TextField(
                                        controller: _phoneController,
                                        keyboardType: TextInputType.phone,
                                        maxLength: 10,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF333333),
                                        ),
                                        decoration: const InputDecoration(
                                          hintText: 'e.g. 485 2145 254',
                                          counterText: '',
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.zero,
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        onChanged: (_) {
                                          if (_errorMessage != null) {
                                            setState(() {
                                              _errorMessage = null;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (_errorMessage != null) ...[
                                const SizedBox(height: 6.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    _errorMessage!,
                                    style: TextStyle(
                                      color: Colors.red.shade600,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 24.0),

                          // Other Option to Loging Label
                          Text(
                            'other option to loging',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 14.0),

                          // Social Options (Google & Facebook)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Google Icon
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.otp);
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.g_mobiledata_rounded,
                                    size: 40,
                                    color: Color(0xFFEA4335),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16.0),

                              // Vertical Divider line
                              Container(
                                width: 1,
                                height: 32,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(width: 16.0),

                              // Facebook Icon
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.otp);
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF3B5998),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.facebook,
                                    size: 32,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),
                          const SizedBox(height: 24.0),

                          // Bottom Footer & Next Button
                          // Didn't have an account? signup now
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Didn\'t have an account? ',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.otp);
                                },
                                child: const Text(
                                  'signup now',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFBAD27),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14.0),

                          // Next Button
                          SizedBox(
                            width: double.infinity,
                            height: 52.0,
                            child: ElevatedButton(
                              onPressed: _onNextPressed,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFBAD27),
                                foregroundColor: const Color(0xFF1E1E1E),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
