import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SwipeNoticeCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onDelete;
  final VoidCallback? onEdit; // ✅ optional

  const SwipeNoticeCard({
    super.key,
    required this.child,
    required this.onDelete,
    this.onEdit,
  });

  @override
  State<SwipeNoticeCard> createState() => _SwipeNoticeCardState();
}

class _SwipeNoticeCardState extends State<SwipeNoticeCard> {
  bool _isRevealed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx < -6) {
          setState(() => _isRevealed = true);
        } else if (details.delta.dx > 6) {
          setState(() => _isRevealed = false);
        }
      },
      child: Stack(
        children: [

          /// BACKGROUND ACTIONS
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.primaryLight,
                    AppColors.primaryColor
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  /// DELETE
                  GestureDetector(
                    onTap: () {
                      setState(() => _isRevealed = false);
                      widget.onDelete();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(
                        'assets/image/delete_3405244.png',
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  /// EDIT (only if provided)
                  if (widget.onEdit != null)
                    GestureDetector(
                      onTap: () {
                        setState(() => _isRevealed = false);
                        widget.onEdit!();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Image.asset(
                          'assets/image/edit_5973027.png',
                          width: 18,
                          height: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          /// FRONT CARD
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(
              _isRevealed
                  ? (widget.onEdit != null ? -120 : -70) // adjust width
                  : 0,
              0,
              0,
            ),
            child: widget.child,
          ),
        ],
      ),
    );
  }
}