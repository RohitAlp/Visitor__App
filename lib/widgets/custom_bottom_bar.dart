import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visitorapp/constants/app_colors.dart';

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
  final Color barColor;
  final Color pillColor;
  final Color activeContentColor;
  final Color inactiveColor;

  const CustomAnimatedNavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
    this.barColor = Colors.white,
    this.pillColor = AppColors.appPrimaryColor,
    this.activeContentColor = Colors.white,
    this.inactiveColor = const Color(0xFFBBBBBB),
  });

  @override
  State<CustomAnimatedNavBar> createState() => _CustomAnimatedNavBarState();
}

class _CustomAnimatedNavBarState extends State<CustomAnimatedNavBar>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _riseAnim;
  Animation<double>? _scaleAnim;
  Animation<double>? _shimmerAnim;
  Animation<double>? _labelFadeAnim;

  @override
  void initState() {
    super.initState();
    _buildAnimations();
  }

  void _buildAnimations() {
    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 460),
    );

    final rise = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 14.0, end: -5.0), weight: 60),
      TweenSequenceItem(tween: Tween(begin: -5.0, end: 0.0), weight: 40),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    final scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.82, end: 1.06), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 1.06, end: 1.0), weight: 40),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    final shimmer = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    final labelFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller = controller;
    _riseAnim = rise;
    _scaleAnim = scale;
    _shimmerAnim = shimmer;
    _labelFadeAnim = labelFade;

    controller.forward();
  }

  @override
  void didUpdateWidget(CustomAnimatedNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _controller?.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
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
    final riseAnim = _riseAnim;
    final scaleAnim = _scaleAnim;
    final shimmerAnim = _shimmerAnim;
    final labelFadeAnim = _labelFadeAnim;

    if (riseAnim == null ||
        scaleAnim == null ||
        shimmerAnim == null ||
        labelFadeAnim == null) {
      return const SizedBox(height: 68);
    }

    // ── Layout: 68px bar + 20px label zone above = 88px total ──
    // Stack lets the island float upward (clip: none) while label
    // sits inside the bar's bottom half — no overflow possible.
    return SizedBox(
      height: 68,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── Bar surface ──────────────────────────────────────────────
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: widget.barColor,
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(22)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 28,
                    offset: const Offset(0, -6),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 5,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
            ),
          ),

          // ── Tab slots ────────────────────────────────────────────────
          Positioned.fill(
            child: Row(
              children: List.generate(widget.items.length, (index) {
                final bool isActive = index == widget.selectedIndex;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => widget.onTap(index),
                    behavior: HitTestBehavior.opaque,
                    child: isActive
                        ? _FloatingIsland(
                      item: widget.items[index],
                      pillColor: widget.pillColor,
                      activeContentColor: widget.activeContentColor,
                      riseAnim: riseAnim,
                      scaleAnim: scaleAnim,
                      shimmerAnim: shimmerAnim,
                      labelFadeAnim: labelFadeAnim,
                      iconBuilder: (item, color, size) =>
                          _buildIconWidget(
                            item,
                            isActive: true,
                            color: color,
                            size: size,
                          ),
                    )
                        : _InactiveItem(
                      item: widget.items[index],
                      color: widget.inactiveColor,
                      iconBuilder: (item, color, size) =>
                          _buildIconWidget(
                            item,
                            isActive: false,
                            color: color,
                            size: size,
                          ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Inactive: small icon + label, fits entirely within 68px bar ──────────────
class _InactiveItem extends StatelessWidget {
  final NavItemData item;
  final Color color;
  final Widget Function(NavItemData, Color, double) iconBuilder;

  const _InactiveItem({
    required this.item,
    required this.color,
    required this.iconBuilder,
  });

  @override
  Widget build(BuildContext context) {
    // 68px bar: icon(20) + gap(3) + label(11) + vertical margins = fits fine
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        iconBuilder(item, color, 20),
        const SizedBox(height: 3),
        Text(
          item.label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: color,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}

// ── Active: island floats UP out of bar, label sits just below island ─────────
class _FloatingIsland extends StatelessWidget {
  final NavItemData item;
  final Color pillColor;
  final Color activeContentColor;
  final Animation<double> riseAnim;
  final Animation<double> scaleAnim;
  final Animation<double> shimmerAnim;
  final Animation<double> labelFadeAnim;
  final Widget Function(NavItemData, Color, double) iconBuilder;

  const _FloatingIsland({
    required this.item,
    required this.pillColor,
    required this.activeContentColor,
    required this.riseAnim,
    required this.scaleAnim,
    required this.shimmerAnim,
    required this.labelFadeAnim,
    required this.iconBuilder,
  });

  @override
  Widget build(BuildContext context){
    // Use a Stack so the island can float above bar bounds (Clip.none on parent)
    // and the label is Positioned at the bottom of the 68px slot — no overflow.
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // ── Label pinned to bottom of the bar slot ───────────────────
        Positioned(
          bottom: 15,
          left: 0,
          right: 0,
          child: FadeTransition(
            opacity: labelFadeAnim,
            child: Text(
              item.label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: pillColor,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),

        // ── Floating tile rises above the bar ────────────────────────
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AnimatedBuilder(
            animation: riseAnim,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, riseAnim.value - 16),
                child: Transform.scale(
                  scale: scaleAnim.value,
                  child: child,
                ),
              );
            },
            child: Center(
              child: Container(
                width: 52,
                height: 52,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: pillColor,
                  boxShadow: [
                    BoxShadow(
                      color: pillColor.withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                    BoxShadow(
                      color: pillColor.withOpacity(0.12),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Center(
                      child: iconBuilder(item, activeContentColor, 22),
                    ),
                    // Shimmer sweep
                    AnimatedBuilder(
                      animation: shimmerAnim,
                      builder: (context, _) {
                        return Positioned(
                          top: -10,
                          bottom: -10,
                          left: shimmerAnim.value * 80 - 30,
                          width: 28,
                          child: Transform.rotate(
                            angle: -0.32,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.30),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}