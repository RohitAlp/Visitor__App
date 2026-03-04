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
      (assetIcon != null &&
          (activeAssetIcon != null || assetIcon != null)),
  'Provide either icon+activeIcon or assetIcon(+activeAssetIcon).',
  );
}

class CustomAnimatedNavBar extends StatefulWidget {
  final List<NavItemData> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  /// Background color of the entire nav bar (white)
  final Color barColor;

  /// Color of the active sliding pill
  final Color pillColor;

  /// Icon + label color inside the active pill
  final Color activeContentColor;

  /// Icon color for unselected items
  final Color inactiveColor;

  const CustomAnimatedNavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
    this.barColor = Colors.white,
    this.pillColor = const Color(0xFFB85C00),
    this.activeContentColor = Colors.white,
    this.inactiveColor = const Color(0xFF9E9E9E),
  });

  @override
  State<CustomAnimatedNavBar> createState() => _CustomAnimatedNavBarState();
}

class _CustomAnimatedNavBarState extends State<CustomAnimatedNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _scaleAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.88, end: 1.05), weight: 55),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 45),
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

  Widget _buildIconWidget(
      NavItemData item, {
        required bool isActive,
        required Color color,
        required double size,
      }) {
    final String? assetPath =
    isActive ? (item.activeAssetIcon ?? item.assetIcon) : item.assetIcon;
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
          placeholderBuilder: (_) =>
              Icon(iconData ?? Icons.help_outline, color: color, size: size),
        );
      }
      return Image.asset(
        assetPath,
        width: size,
        height: size,
        color: item.tintAsset ? color : null,
        errorBuilder: (_, __, ___) =>
            Icon(iconData ?? Icons.help_outline, color: color, size: size),
      );
    }

    return Icon(iconData, color: color, size: size);
  }

  @override
  Widget build(BuildContext context) {
    const double barHeight = 64.0;
    const double pillHeight = 40.0;
    const double pillVerticalPadding = (barHeight - pillHeight) / 2;
     const double pillHorizontalInset = 5.0;

    return Container(
      height: barHeight,
      decoration: BoxDecoration(
        color: widget.barColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;
        final int count = widget.items.length;
        final double itemWidth = totalWidth / count;
         final double pillWidth = itemWidth - pillHorizontalInset * 2;
        final double pillLeft =
            widget.selectedIndex * itemWidth + pillHorizontalInset;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // ── Inactive tap targets ──
            Row(
              children: List.generate(count, (index) {
                final bool isActive = index == widget.selectedIndex;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => widget.onTap(index),
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      height: barHeight,
                      child: Center(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 180),
                          // Fade out the bare icon when this slot is active
                          opacity: isActive ? 0.0 : 1.0,
                          child: _buildIconWidget(
                            widget.items[index],
                            isActive: false,
                            color: widget.inactiveColor,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

            // ── Sliding oval pill ──
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              left: pillLeft,
              top: pillVerticalPadding,
              // Clamp width explicitly so it never exceeds its slot
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                  // ClipRect prevents any child overflow bleeding outside
                  clipBehavior: Clip.hardEdge,
                  width: pillWidth,
                  height: pillHeight,
                  decoration: BoxDecoration(
                    color: widget.pillColor,
                    // Perfect oval/stadium shape
                    borderRadius: BorderRadius.circular(pillHeight / 2),
                    boxShadow: [
                      BoxShadow(
                        color: widget.pillColor.withOpacity(0.28),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIconWidget(
                        widget.items[widget.selectedIndex],
                        isActive: true,
                        color: widget.activeContentColor,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      // Flexible + ellipsis = no overflow ever
                      Flexible(
                        child: Text(
                          widget.items[widget.selectedIndex].label,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: widget.activeContentColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                    ],
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
