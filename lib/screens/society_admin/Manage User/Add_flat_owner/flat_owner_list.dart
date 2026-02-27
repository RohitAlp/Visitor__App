import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../config/Routes/RouteName.dart';

class FlatOwner {
  final String name;
  final String flat;
  final String phone;
  final String wing;
  final String avatarInitials;

  const FlatOwner({
    required this.name,
    required this.flat,
    required this.phone,
    required this.wing,
    required this.avatarInitials,
  });
}

class FlatOwnersScreen extends StatefulWidget {
  const FlatOwnersScreen({super.key});

  @override
  State<FlatOwnersScreen> createState() => _FlatOwnersScreenState();
}

class _FlatOwnersScreenState extends State<FlatOwnersScreen>
    with TickerProviderStateMixin {
  static const Color primaryColor = Color(0xFFC5610F);
  static const Color primaryLight = Color(0xFFE8832A);
  static const Color bgColor = Color(0xFFF5F0EB);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1A1208);
  static const Color textMid = Color(0xFF6B5A47);
  static const Color textLight = Color(0xFF9C8872);

  final List<FlatOwner> _allOwners = const [
    FlatOwner(name: 'Rajesh Kumar', flat: 'Flat A-302', phone: '+91 98765 43210', wing: 'A', avatarInitials: 'RK'),
    FlatOwner(name: 'Priya Sharma', flat: 'Flat B-501', phone: '+91 98765 43211', wing: 'B', avatarInitials: 'PS'),
    FlatOwner(name: 'Amit Patel', flat: 'Flat C-204', phone: '+91 98765 43212', wing: 'C', avatarInitials: 'AP'),
    FlatOwner(name: 'Sneha Reddy', flat: 'Flat A-101', phone: '+91 98765 43213', wing: 'A', avatarInitials: 'SR'),
    FlatOwner(name: 'Vikram Singh', flat: 'Flat D-403', phone: '+91 98765 43214', wing: 'D', avatarInitials: 'VS'),
    FlatOwner(name: 'Meera Joshi', flat: 'Flat B-201', phone: '+91 98765 43215', wing: 'B', avatarInitials: 'MJ'),
    FlatOwner(name: 'Karan Mehta', flat: 'Flat C-305', phone: '+91 98765 43216', wing: 'C', avatarInitials: 'KM'),
    FlatOwner(name: 'Anita Gupta', flat: 'Flat A-404', phone: '+91 98765 43217', wing: 'A', avatarInitials: 'AG'),
  ];

  String _selectedWing = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  final List<String> _wings = ['All', 'A Wing', 'B Wing', 'C Wing', 'D Wing'];

  List<FlatOwner> get _filteredOwners {
    return _allOwners.where((owner) {
      final matchesWing = _selectedWing == 'All' ||
          owner.wing == _selectedWing.replaceAll(' Wing', '');
      final matchesSearch = _searchQuery.isEmpty ||
          owner.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          owner.flat.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          owner.phone.contains(_searchQuery);
      return matchesWing && matchesSearch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fabAnimation = CurvedAnimation(parent: _fabController, curve: Curves.elasticOut);
    _fabController.forward();
  }

  @override
  void dispose() {
    _fabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _deleteOwner(FlatOwner owner) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Owner', style: TextStyle(fontWeight: FontWeight.w700, color: textDark)),
        content: Text('Are you sure you want to remove ${owner.name}?', style: const TextStyle(color: textMid)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: textLight)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${owner.name} removed'),
                  backgroundColor: primaryColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _editOwner(FlatOwner owner) {
    final parts = owner.flat.split('-');
    String flatNumber = parts.isNotEmpty ? parts.last.replaceAll(RegExp(r'\\D'), '') : '';
    final digits = owner.phone.replaceAll(RegExp(r'\\D'), '');
    final mobile = digits.length > 10 ? digits.substring(digits.length - 10) : digits;
    Navigator.pushNamed(
      context,
      RouteName.AddFlatOwnerForm,
      arguments: {
        'name': owner.name,
        'flatNumber': flatNumber.isNotEmpty ? flatNumber : owner.flat,
        'mobile': mobile,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredOwners;

    return SafeArea(

      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: CustomScrollView(
          slivers: [
            // App Bar


            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: cardBg,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.arrow_back_ios_rounded, size: 16, color: textDark),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Flat Owners',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: textDark,
                            letterSpacing: -0.8,
                          ),
                        ),
                        const Spacer(),
                        ScaleTransition(
                          scale: _fabAnimation,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RouteName.AddFlatOwnerForm);
                            },
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [primaryLight, primaryColor],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withOpacity(0.45),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) => setState(() => _searchQuery = val),
                        style: const TextStyle(fontSize: 14, color: textDark, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          hintText: 'Search by owner name...',
                          hintStyle: const TextStyle(color: textLight, fontSize: 14),
                          prefixIcon: const Icon(Icons.search_rounded, color: primaryColor, size: 22),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                            child: const Icon(Icons.close_rounded, color: textLight, size: 18),
                          )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Wing Filter
                    SizedBox(
                      height: 42,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _wings.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, i) {
                          final wing = _wings[i];
                          final isSelected = _selectedWing == wing;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedWing = wing),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: isSelected
                                    ? const LinearGradient(
                                  colors: [primaryLight, primaryColor],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                                    : null,
                                color: isSelected ? null : cardBg,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: isSelected
                                    ? [
                                  BoxShadow(
                                    color: primaryColor.withOpacity(0.4),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  )
                                ]
                                    : [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Text(
                                wing,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected ? Colors.white : textMid,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Count badge
                    Row(
                      children: [
                        Text(
                          '${filtered.length} Owner${filtered.length != 1 ? 's' : ''}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: textLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        if (_selectedWing != 'All' || _searchQuery.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedWing = 'All';
                                _searchQuery = '';
                                _searchController.clear();
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Clear filters',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),

            // Owner List
            filtered.isEmpty
                ? SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person_search_rounded, size: 40, color: primaryColor),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No owners found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Try adjusting your search or filters',
                      style: TextStyle(fontSize: 13, color: textLight),
                    ),
                  ],
                ),
              ),
            )
                : SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final owner = filtered[index];
                    return _OwnerCard(
                      owner: owner,
                      onEdit: () => _editOwner(owner),
                      onDelete: () => _deleteOwner(owner),
                      index: index,
                    );
                  },
                  childCount: filtered.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OwnerCard extends StatefulWidget {
  final FlatOwner owner;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final int index;

  const _OwnerCard({
    required this.owner,
    required this.onEdit,
    required this.onDelete,
    required this.index,
  });

  @override
  State<_OwnerCard> createState() => _OwnerCardState();
}

class _OwnerCardState extends State<_OwnerCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  static const Color primaryColor = Color(0xFFC5610F);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1A1208);
  static const Color textMid = Color(0xFF6B5A47);
  static const Color textLight = Color(0xFF9C8872);

  bool _pressed = false;

  // Wing colors
  Color get _wingColor {
    switch (widget.owner.wing) {
      case 'A': return const Color(0xFF2563EB);
      case 'B': return const Color(0xFF059669);
      case 'C': return const Color(0xFF7C3AED);
      case 'D': return const Color(0xFFDC2626);
      default: return primaryColor;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slideAnimation = Tween<double>(begin: 40, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    Future.delayed(Duration(milliseconds: 60 * widget.index), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, _slideAnimation.value),
        child: Opacity(opacity: _fadeAnimation.value, child: child),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            transform: Matrix4.identity()..scale(_pressed ? 0.97 : 1.0),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(_pressed ? 0.03 : 0.07),
                  blurRadius: _pressed ? 8 : 20,
                  offset: Offset(0, _pressed ? 2 : 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _wingColor.withOpacity(0.15),
                          _wingColor.withOpacity(0.08),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _wingColor.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.owner.avatarInitials,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: _wingColor,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.owner.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: textDark,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: _wingColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                widget.owner.wing,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: _wingColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.apartment_rounded, size: 13, color: primaryColor.withOpacity(0.7)),
                            const SizedBox(width: 4),
                            Text(
                              widget.owner.flat,
                              style: const TextStyle(
                                fontSize: 12,
                                color: textMid,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(Icons.phone_rounded, size: 13, color: primaryColor.withOpacity(0.7)),
                            const SizedBox(width: 4),
                            Text(
                              widget.owner.phone,
                              style: const TextStyle(
                                fontSize: 12,
                                color: textLight,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Action buttons
                  Column(
                    children: [
                      _ActionButton(
                        icon: Icons.edit_rounded,
                        color: primaryColor,
                        onTap: widget.onEdit,
                      ),
                      const SizedBox(height: 8),
                      _ActionButton(
                        icon: Icons.delete_outline_rounded,
                        color: const Color(0xFFDC2626),
                        onTap: widget.onDelete,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.color, required this.onTap});

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _hovered = true),
      onTapUp: (_) {
        setState(() => _hovered = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: _hovered ? widget.color : widget.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: _hovered
              ? [
            BoxShadow(
              color: widget.color.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ]
              : null,
        ),
        child: Icon(
          widget.icon,
          size: 17,
          color: _hovered ? Colors.white : widget.color,
        ),
      ),
    );
  }
}
