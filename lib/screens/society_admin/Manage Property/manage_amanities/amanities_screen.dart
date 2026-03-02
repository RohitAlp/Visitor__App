import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitorapp/screens/society_admin/Manage%20Property/manage_amanities/edit_aminity/update_aminity.dart';
import '../../../../constants/app_colors.dart';
import 'edit_aminity/amenity_bloc/aminity_bloc.dart';

class Amenity {
  final String name;
  final String category;
  final String location;
  final String timing;
  final String status;

  const Amenity({
    required this.name,
    required this.category,
    required this.location,
    required this.timing,
    required this.status,
  });
}

class ManageAmanitiesScreen extends StatefulWidget {
  const ManageAmanitiesScreen({super.key});

  @override
  State<ManageAmanitiesScreen> createState() => _ManageAmanitiesScreenState();
}

class _ManageAmanitiesScreenState extends State<ManageAmanitiesScreen>
    with TickerProviderStateMixin {

  final List<Amenity> _allAmenities = const [
    Amenity(
      name: 'Swimming Pool',
      category: 'Recreation',
      location: 'Block A - Ground Floor',
      timing: '6 AM - 10 PM',
      status: 'Active',
    ),
    Amenity(
      name: 'Gymnasium',
      category: 'Fitness',
      location: 'Block B - 1st Floor',
      timing: '5 AM - 11 PM',
      status: 'Active',
    ),
    Amenity(
      name: 'Community Hall',
      category: 'Events',
      location: 'Main Building - 2nd Floor',
      timing: '9 AM - 9 PM',
      status: 'Active',
    ),
    Amenity(
      name: 'Children\'s Play Area',
      category: 'Recreation',
      location: 'Garden Area',
      timing: '6 AM - 8 PM',
      status: 'Active',
    ),
  ];

  String _searchQuery = '';
  String _selectedStatus = 'All';
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  List<Amenity> get _filteredAmenities {
    return _allAmenities.where((amenity) {
      final matchesSearch = _searchQuery.isEmpty ||
          amenity.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          amenity.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          amenity.location.toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesStatus = _selectedStatus == 'All' || 
          amenity.status.toLowerCase() == _selectedStatus.toLowerCase();
      
      return matchesSearch && matchesStatus;
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

  void _deleteAmenity(Amenity amenity) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Amenity', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textDark)),
        content: Text('Are you sure you want to remove ${amenity.name}?', style: const TextStyle(color: AppColors.textMid)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textLight)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${amenity.name} removed'),
                  backgroundColor: AppColors.primaryColor,
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

  void _editAmenity(Amenity amenity) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editing ${amenity.name}'),
        backgroundColor: AppColors.primaryLight,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredAmenities;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            pinned: true,
            expandedHeight: 0,
            backgroundColor: AppColors.bgColor,
            elevation: 0,
            leading: null,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  const Text(
                    'Society Admin',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.cardBg,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.15),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.notifications_outlined, color: AppColors.primaryColor, size: 22),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF4444),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.cardBg,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.arrow_back_ios_rounded, size: 16, color: AppColors.textDark),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Manage Amenities',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textDark,
                              letterSpacing: -0.8,
                            ),
                          ),
                          // Text(
                          //   '${_allAmenities.length} amenities',
                          //   style: const TextStyle(
                          //     fontSize: 13,
                          //     color: AppColors.textLight,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                        ],
                      ),
                      const Spacer(),
                      ScaleTransition(
                        scale: _fabAnimation,
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Add new amenity'),
                                backgroundColor: AppColors.primaryColor,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            );
                          },
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.primaryLight, AppColors.primaryColor],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withOpacity(0.45),
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
                      color: AppColors.cardBg,
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
                      style: const TextStyle(fontSize: 14, color: AppColors.textDark, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: 'Search by amenity name/category',
                        hintStyle: const TextStyle(color: AppColors.textLight, fontSize: 14),
                        prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primaryColor, size: 22),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                          child: const Icon(Icons.close_rounded, color: AppColors.textLight, size: 18),
                        )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Status Tabs
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: ['All', 'Active', 'Maintenance', 'Closed'].map((status) {
                          final isSelected = _selectedStatus == status;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedStatus = status),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.primaryColor : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    status,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? Colors.white : AppColors.textMid,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            '${filtered.length} Amenity${filtered.length != 1 ? 'ies' : ''}',
                            style: const TextStyle(fontSize: 13, color: AppColors.textLight, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 4),
                          _buildStatusCounts(filtered),
                        ],
                      ),
                      const Spacer(),
                      if (_searchQuery.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _searchQuery = '';
                              _searchController.clear();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Clear',
                              style: TextStyle(fontSize: 12, color: AppColors.primaryColor, fontWeight: FontWeight.w600),
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

          // Amenity List
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
                      color: AppColors.primaryColor.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.pool_rounded, size: 40, color: AppColors.primaryColor),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No amenities found',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Try adjusting your search',
                    style: TextStyle(fontSize: 13, color: AppColors.textLight),
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
                  final amenity = filtered[index];
                  return _AmenityCard(
                    amenity: amenity,
                    onEdit: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => AminityBloc(),
                            child: const EditAminityForm(),
                          ),
                        ),
                      );
                    },
                    onDelete: () => _deleteAmenity(amenity),
                    index: index,
                  );
                },
                childCount: filtered.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

IconData _getAmenityIcon(String amenityName) {
  switch (amenityName.toLowerCase()) {
    case 'swimming pool':
      return Icons.pool_rounded;
    case 'gymnasium':
    case 'gym':
      return Icons.fitness_center_rounded;
    case 'community hall':
      return Icons.meeting_room_rounded;
    case 'children\'s play area':
    case 'play area':
      return Icons.child_care_rounded;
    case 'garden':
      return Icons.park_rounded;
    case 'parking':
      return Icons.local_parking_rounded;
    case 'clubhouse':
      return Icons.sports_bar_rounded;
    case 'tennis court':
      return Icons.sports_tennis_rounded;
    case 'basketball court':
      return Icons.sports_basketball_rounded;
    case 'jogging track':
      return Icons.directions_run_rounded;
    case 'security':
      return Icons.security_rounded;
    case 'elevator':
      return Icons.elevator_rounded;
    case 'power backup':
      return Icons.power_rounded;
    case 'water supply':
      return Icons.water_drop_rounded;
    default:
      return Icons.apartment_rounded;
  }
}

Color _getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'active':
      return const Color(0xFF10B981); // Emerald green
    case 'inactive':
      return const Color(0xFFF59E0B); // Amber
    case 'maintenance':
      return const Color(0xFF3B82F6); // Blue
    case 'under construction':
      return const Color(0xFF8B5CF6); // Violet
    default:
      return const Color(0xFF6B7280); // Gray
  }
}

Widget _buildStatusCounts(List<Amenity> amenities) {
  final statusCounts = <String, int>{};

  for (final amenity in amenities) {
    final status = amenity.status.toLowerCase();
    statusCounts[status] = (statusCounts[status] ?? 0) + 1;
  }

  final statusEntries = statusCounts.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return Wrap(
    spacing: 8,
    runSpacing: 4,
    children: statusEntries.map((entry) {
      final status = entry.key;
      final count = entry.value;
      final color = _getStatusColor(status);

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '${status[0].toUpperCase()}${status.substring(1)}: $count',
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

class _AmenityCard extends StatefulWidget {
  final Amenity amenity;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final int index;

  const _AmenityCard({
    required this.amenity,
    required this.onEdit,
    required this.onDelete,
    required this.index,
  });

  @override
  State<_AmenityCard> createState() => _AmenityCardState();
}

class _AmenityCardState extends State<_AmenityCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool _pressed = false;

  // Unique accent per amenity based on index
  Color get _accentColor {
    final colors = [
      const Color(0xFF2563EB),
      const Color(0xFF059669),
      const Color(0xFF7C3AED),
      const Color(0xFFDC2626),
      AppColors.primaryColor,
      const Color(0xFF0891B2),
    ];
    return colors[widget.index % colors.length];
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
              color: AppColors.cardBg,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Amenity icon avatar
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _accentColor.withOpacity(0.15),
                          _accentColor.withOpacity(0.06),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _accentColor.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        _getAmenityIcon(widget.amenity.name),
                        color: _accentColor,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.amenity.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(Icons.category_rounded, size: 13, color: AppColors.primaryColor.withOpacity(0.7)),
                            const SizedBox(width: 4),
                            Column(
                              children: [
                                Text(
                                  '${widget.amenity.category}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textMid,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            // Icon(Icons.category_rounded, size: 13, color: AppColors.primaryColor.withOpacity(0.7)),
                            const SizedBox(width: 4),
                            Column(
                              children: [
                                Text(
                                  '• ${widget.amenity.location}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textMid,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(Icons.access_time_rounded, size: 13, color: AppColors.primaryColor.withOpacity(0.7)),
                            const SizedBox(width: 4),
                            Text(
                              widget.amenity.timing,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textLight,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Status badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(widget.amenity.status.toLowerCase()).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _getStatusColor(widget.amenity.status.toLowerCase()).withOpacity(0.25),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: _getStatusColor(widget.amenity.status.toLowerCase()),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.amenity.status,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: _getStatusColor(widget.amenity.status.toLowerCase()),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Action buttons
                  Column(
                    children: [
                      _ActionButton(
                        icon: Icons.edit_rounded,
                        color: AppColors.primaryColor,
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