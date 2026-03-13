import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 80,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  //
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: Container(
                  //     width: 36,
                  //     height: 36,
                  //     decoration: BoxDecoration(
                  //       color: AppColors.cardBg,
                  //       borderRadius: BorderRadius.circular(12),
                  //       border: Border.all(
                  //         color: Colors.grey.withOpacity(0.15),
                  //         width: 1,
                  //       ),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black.withOpacity(0.05),
                  //           blurRadius: 6,
                  //           offset: const Offset(0, 2),
                  //         ),
                  //       ],
                  //     ),
                  //     child: const Icon(
                  //       Icons.arrow_back_ios_rounded,
                  //       size: 16,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(width: 20),

                  Text(
                    'Payment',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w800),
                  ),


                ],
              ),
            ),

            const SizedBox(height: 10),

            const Divider(
              thickness: 1,
              height: 1,
              color: Color(0xFFE5E5E5),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionLabel('Your Card'),
            const SizedBox(height: 14),
            _PaymentCard(),
            const SizedBox(height: 28),
            _sectionLabel('Payment Summary'),
            const SizedBox(height: 14),
            _SummaryCard(),
            const SizedBox(height: 28),
            _PayButton(),
            const SizedBox(height: 14),
            const Center(
              child: Text(
                'Secured by 256-bit SSL encryption',
                style: TextStyle(fontSize: 11, color: Color(0xFFBBBBBB)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: Color(0xFF999999),
        letterSpacing: 0.8,
      ),
    );
  }
}

// ── Dark premium credit card ──────────────────────────────────────────────────
class _PaymentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xFF1C1C2E), Color(0xFF2D2B55), Color(0xFF1A1A3E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E1C50).withOpacity(0.35),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
          BoxShadow(
            color: const Color(0xFF1E1C50).withOpacity(0.20),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chip + network logo row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // EMV chip
              Container(
                width: 36,
                height: 26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF0C060), Color(0xFFC8902A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              // Mastercard-style circles
              SizedBox(
                width: 50,
                height: 32,
                child: CustomPaint(painter: _NetworkLogoPainter()),
              ),
            ],
          ),
          const SizedBox(height: 28),
          const Text(
            '•••• •••• •••• 4291',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w600,
              letterSpacing: 3,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _CardInfo(label: 'Card Holder', value: 'Rutuja Sharma'),
              _CardInfo(
                label: 'Expires',
                value: '09 / 27',
                align: CrossAxisAlignment.end,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardInfo extends StatelessWidget {
  final String label;
  final String value;
  final CrossAxisAlignment align;

  const _CardInfo({
    required this.label,
    required this.value,
    this.align = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            color: Color(0x80FFFFFF),
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xEEFFFFFF),
          ),
        ),
      ],
    );
  }
}

// Mastercard-style overlapping circles
class _NetworkLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(size.width * 0.36, size.height / 2),
      size.height * 0.44,
      Paint()..color = Colors.red.withOpacity(0.75),
    );
    canvas.drawCircle(
      Offset(size.width * 0.64, size.height / 2),
      size.height * 0.44,
      Paint()..color = Colors.orange.withOpacity(0.65),
    );
  }

  @override
  bool shouldRepaint(_) => false;
}

// ── Payment summary card ──────────────────────────────────────────────────────
class _SummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _SummaryRow(
            icon: Icons.apartment_rounded,
            iconColor: const Color(0xFF5B4FE8),
            iconBg: const Color(0xFFEEF0FF),
            label: 'Maintenance Fee',
            amount: '₹ 2,500',
            showDivider: true,
          ),
          _SummaryRow(
            icon: Icons.layers_rounded,
            iconColor: const Color(0xFFE87B30),
            iconBg: const Color(0xFFFFF0E8),
            label: 'Processing Fee',
            amount: '₹ 50',
            showDivider: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Total Payable',
                  style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
                ),
                Text(
                  '₹ 2,550',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1C1C2E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String amount;
  final bool showDivider;

  const _SummaryRow({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.amount,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111111),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Container(height: 0.5, color: const Color(0xFFF0F0F5)),
      ],
    );
  }
}

class _PayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            AppColors.appPrimaryColor,
            Color(0xFFE07A2A), // lighter shade for gradient
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPrimaryColor.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 17),
            child: Center(
              child: Text(
                'Pay Now  ₹ 2,550',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}