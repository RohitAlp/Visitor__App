import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavItemData {
  final IconData? icon;
  final IconData? activeIcon;
  final String? assetIcon;
  final String? activeAssetIcon;
  final bool tintAsset;
  final String label;

  const NavItemData({
    this.icon,
    this.activeIcon,
    this.assetIcon,
    this.activeAssetIcon,
    this.tintAsset = false,
    required this.label,
  }) : assert(
          (icon != null && activeIcon != null) ||
              (assetIcon != null && (activeAssetIcon != null || assetIcon != null)),
          'Provide either icon+activeIcon or assetIcon(+activeAssetIcon).',
        );
}

class CustomAnimatedNavBar extends StatefulWidget {
  final List<NavItemData> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final Color barColor;
  final Color bubbleColor;

  const CustomAnimatedNavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
    required this.barColor,
    required this.bubbleColor,
  });

  @override
  State<CustomAnimatedNavBar> createState() => _CustomAnimatedNavBarState();
}

class _CustomAnimatedNavBarState extends State<CustomAnimatedNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  Widget _buildIconWidget(
    NavItemData item, {
    required bool isActive,
    required Color color,
    required double size,
  }) {
    final String? assetPath = isActive
        ? (item.activeAssetIcon ?? item.assetIcon)
        : item.assetIcon;
    final IconData? iconData = isActive ? item.activeIcon : item.icon;

    if (assetPath != null) {
      if (assetPath.toLowerCase().endsWith('.svg')) {
        return SvgPicture.asset(
          assetPath,
          width: size,
          height: size,
          colorFilter: item.tintAsset
              ? ColorFilter.mode(color, BlendMode.srcIn)
              : null,
          placeholderBuilder: (_) => Icon(
            iconData ?? Icons.help_outline,
            color: color,
            size: size,
          ),
        );
      }

      return Image.asset(
        assetPath,
        width: size,
        height: size,
        color: item.tintAsset ? color : null,
        errorBuilder: (_, __, ___) => Icon(
          iconData ?? Icons.help_outline,
          color: color,
          size: size,
        ),
      );
    }

    return Icon(iconData, color: color, size: size);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.6, end: 1.2), weight: 55),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 45),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void didUpdateWidget(CustomAnimatedNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double bubbleRadius = 28.0;
    const double barHeight = 65.0;
    const double overlap = 20.0;

    const double bubbleAboveBar = bubbleRadius * 1.6 - overlap;
    const double totalHeight = bubbleAboveBar + barHeight;

    return SizedBox(
      height: totalHeight,
      child: LayoutBuilder(builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;
        final double itemWidth = totalWidth / widget.items.length;

        const double cornerRadius = 20.0;
        const double notchMargin = 6.0;
        final double notchR = bubbleRadius + 4 + notchMargin;
        final double minCx = cornerRadius + notchR;
        final double maxCx = totalWidth - cornerRadius - notchR;

        final double rawCx = itemWidth * widget.selectedIndex + itemWidth / 2;
        final double clampedCx = rawCx.clamp(minCx, maxCx);

        // Bubble left position derived from clamped center
        final double bubbleLeft = clampedCx - bubbleRadius;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // ── Bar ──
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: barHeight,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, __) => CustomPaint(
                  painter: NavBarPainter(
                    color: widget.barColor,
                    notchCenterX: clampedCx,
                    bubbleRadius: bubbleRadius + 4,
                  ),
                  child: SizedBox(
                    height: barHeight,
                    child: Row(
                      children: List.generate(widget.items.length, (index) {
                        final isSelected = index == widget.selectedIndex;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => widget.onTap(index),
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (!isSelected)
                                  _buildIconWidget(
                                    widget.items[index],
                                    isActive: false,
                                    color: Colors.white70,
                                    size: 22,
                                  ),
                                if (isSelected) const SizedBox(height: 22),
                                const SizedBox(height: 4),
                                Text(
                                  widget.items[index].label,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.white70,
                                    fontSize: 11,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),

            // ── Bubble ──
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              left: bubbleLeft,
              top: 0,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                  width: bubbleRadius * 2,
                  height: bubbleRadius * 2,
                  decoration: BoxDecoration(
                    color: widget.bubbleColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: _buildIconWidget(
                    widget.items[widget.selectedIndex],
                    isActive: true,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

// ── Painter ──
class NavBarPainter extends CustomPainter {
  final Color color;
  final double notchCenterX;
  final double bubbleRadius;

  NavBarPainter({
    required this.color,
    required this.notchCenterX,
    required this.bubbleRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final double cx = notchCenterX;
    const double cornerRadius = 20.0;
    const double notchMargin = 6.0;
    final double r = bubbleRadius + notchMargin;

    final path = Path();

    path.moveTo(cornerRadius, 0);
    path.lineTo(cx - r, 0);
    path.arcToPoint(
      Offset(cx + r, 0),
      radius: Radius.circular(r),
      clockwise: false,
    );
    path.lineTo(size.width - cornerRadius, 0);
    path.arcToPoint(
      Offset(size.width, cornerRadius),
      radius: const Radius.circular(cornerRadius),
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, cornerRadius);
    path.arcToPoint(
      Offset(cornerRadius, 0),
      radius: const Radius.circular(cornerRadius),
    );

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(NavBarPainter oldDelegate) =>
      oldDelegate.notchCenterX != notchCenterX;
}