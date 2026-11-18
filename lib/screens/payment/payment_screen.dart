import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = 'UPI Payment';
  double _baseAmount = 7500.0;
  String _planName = 'Premium Plan';
  String _deliveryAddress = 'Mimec IT Park, Ranchi, Jharkhand';
  bool _initializedFromArgs = false;
  bool _isProcessing = false;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _upiIdController = TextEditingController(text: 'user@upi');
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardExpiryController = TextEditingController();
  final TextEditingController _cardCvvController = TextEditingController();

  String _selectedBank = 'State Bank of India';
  final List<String> _banks = [
    'State Bank of India',
    'HDFC Bank',
    'ICICI Bank',
    'Axis Bank',
    'Punjab National Bank',
  ];

  @override
  void initState() {
    super.initState();
    _amountController.text = _baseAmount.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _upiIdController.dispose();
    _cardNumberController.dispose();
    _cardExpiryController.dispose();
    _cardCvvController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initializedFromArgs) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map<String, dynamic>) {
        if (args['fullAddress'] != null) {
          _deliveryAddress = args['fullAddress'];
        } else if (args['locationName'] != null) {
          _deliveryAddress = '${args['locationName']}, ${args['cityName'] ?? ''}';
        }
        if (args['planName'] != null) {
          _planName = args['planName'];
        }
        if (args['price'] != null) {
          final p = args['price'];
          if (p is num) {
            _baseAmount = p.toDouble();
            _amountController.text = _baseAmount.toStringAsFixed(0);
          }
        }
      }
      _initializedFromArgs = true;
    }
  }

  double get _enteredAmount {
    return double.tryParse(_amountController.text.trim()) ?? _baseAmount;
  }

  double get _gstAmount => _enteredAmount * 0.05;

  double get _totalPayable => _enteredAmount + _gstAmount;

  void _handlePayment() async {
    final amount = _enteredAmount;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid payment amount'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedMethod == 'UPI Payment' && _upiIdController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your UPI ID'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_selectedMethod == 'Credit/Debit Card' &&
        (_cardNumberController.text.trim().isEmpty || _cardCvvController.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter card number and CVV'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    // Simulate secure network transaction processing
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isProcessing = false;
    });

    // Navigate to Payment Success Screen with complete transaction payload
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.paymentSuccess,
      arguments: {
        'amount': _totalPayable,
        'baseAmount': _enteredAmount,
        'gstAmount': _gstAmount,
        'paymentMethod': _selectedMethod,
        'planName': _planName,
        'deliveryAddress': _deliveryAddress,
        'transactionId': 'TXN${DateTime.now().millisecondsSinceEpoch.toString().substring(3)}',
        'packageNo': 'EATO/001/2025',
        'upiId': _selectedMethod == 'UPI Payment' ? _upiIdController.text.trim() : null,
        'bankName': _selectedMethod == 'Net Banking' ? _selectedBank : null,
      },
    );
  }

  Widget _buildPaymentMethodTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconBgColor,
  }) {
    final isSelected = _selectedMethod == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = title;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: isSelected ? const Color(0xFFEA580C) : Colors.grey.shade200,
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? const Color(0xFFEA580C).withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFFEA580C) : Colors.grey.shade400,
                  width: isSelected ? 6.0 : 2.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentFormDetails() {
    if (_selectedMethod == 'UPI Payment') {
      return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select UPI App or Enter VPA ID',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildUpiAppChip('Google Pay', Icons.account_balance_wallet_rounded, const Color(0xFF4285F4)),
                _buildUpiAppChip('PhonePe', Icons.mobile_friendly_rounded, const Color(0xFF5F259F)),
                _buildUpiAppChip('Paytm', Icons.payment_rounded, const Color(0xFF00BAF2)),
              ],
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _upiIdController,
              decoration: InputDecoration(
                labelText: 'UPI ID / VPA',
                hintText: 'e.g. mobileNumber@upi',
                prefixIcon: const Icon(Icons.alternate_email_rounded, color: Color(0xFFEA580C), size: 18),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    } else if (_selectedMethod == 'Credit/Debit Card') {
      return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Card Details',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Card Number',
                hintText: '4532 •••• •••• 8921',
                prefixIcon: const Icon(Icons.credit_card_rounded, color: Color(0xFF635BFF), size: 20),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cardExpiryController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      labelText: 'Expiry (MM/YY)',
                      hintText: '08/28',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _cardCvvController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      hintText: '•••',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (_selectedMethod == 'Net Banking') {
      return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Your Bank',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _selectedBank,
              isExpanded: true,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
              items: _banks.map((bank) {
                return DropdownMenuItem(value: bank, child: Text(bank, style: const TextStyle(fontSize: 13)));
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedBank = val;
                  });
                }
              },
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildUpiAppChip(String label, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _upiIdController.text = '${label.toLowerCase().replaceAll(' ', '')}@upi';
        });
      },
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7),
      appBar: AppBar(
        title: const Text(
          'Payment Details',
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Select Payment Method Header
            const Text(
              'Select A Payment Method',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'Choose your preferred payment method to proceed',
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16.0),

            // UPI Payment
            _buildPaymentMethodTile(
              title: 'UPI Payment',
              subtitle: 'Google Pay, PhonePe, Paytm, BHIM',
              icon: Icons.account_balance_wallet_rounded,
              iconBgColor: const Color(0xFF27AE60),
            ),

            // Credit/Debit Card
            _buildPaymentMethodTile(
              title: 'Credit/Debit Card',
              subtitle: 'Visa, MasterCard, RuPay, Maestro',
              icon: Icons.credit_card_rounded,
              iconBgColor: const Color(0xFF635BFF),
            ),

            // Net Banking
            _buildPaymentMethodTile(
              title: 'Net Banking',
              subtitle: 'SBI, HDFC, ICICI, Axis & All major banks',
              icon: Icons.account_balance_rounded,
              iconBgColor: const Color(0xFF5B67CA),
            ),

            // Dynamic Form input based on selected method
            _buildPaymentFormDetails(),

            // Amount Input & Editable Section
            const Text(
              'Payment Amount & Order Summary',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
            const SizedBox(height: 10.0),

            // Amount Field Card
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _planName,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E1E1E),
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            'Breakfast  |  Lunch  |  Dinner',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7ED),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          '30 Days Plan',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFEA580C)),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    children: [
                      const Text(
                        'Amount (₹):',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            setState(() {});
                          },
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFEA580C)),
                          decoration: InputDecoration(
                            prefixText: '₹ ',
                            prefixStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFEA580C)),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFEA580C)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0xFFEA580C), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Quick add chips
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildQuickAddChip('+ ₹100', 100),
                      const SizedBox(width: 6),
                      _buildQuickAddChip('+ ₹500', 500),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _amountController.text = _baseAmount.toStringAsFixed(0);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('Reset', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  // Bill breakdown lines
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Plan Price', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                      Text('₹${_enteredAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Taxes & GST (5%)', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                      Text('₹${_gstAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Charges', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                      const Text('FREE', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF27AE60))),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Amount Payable', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E))),
                      Text(
                        '₹${_totalPayable.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF27AE60)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28.0),

            // Pay Now Primary Action Button
            SizedBox(
              width: double.infinity,
              height: 54.0,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _handlePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEA580C),
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: _isProcessing
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Processing Payment...',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.lock_rounded, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Pay ₹${_totalPayable.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAddChip(String label, double addValue) {
    return GestureDetector(
      onTap: () {
        final current = _enteredAmount;
        setState(() {
          _amountController.text = (current + addValue).toStringAsFixed(0);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF7ED),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFEA580C).withValues(alpha: 0.3)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFFEA580C)),
        ),
      ),
    );
  }
}
