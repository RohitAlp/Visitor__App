import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitorapp/config/Routes/RouteName.dart';
import 'package:visitorapp/screens/society_admin/Manage%20Property/manage_floors/edit_floors_form/bloc/edit_floors_bloc.dart' hide SelectTowerEvent;
import 'package:visitorapp/screens/society_admin/Manage%20Property/manage_floors/edit_floors_form/edit_floor_form.dart';

import '../../../../constants/app_colors.dart';
import '../../../../utils/enum.dart';
import 'bloc/manage_floors_bloc.dart';

class ManageFloorsScreen extends StatelessWidget {
  const ManageFloorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageFloorsBloc()..add(LoadFloorsEvent()),
      child: const _ManageFloorsScreenContent(),
    );
  }
}

class _ManageFloorsScreenContent extends StatefulWidget {
  const _ManageFloorsScreenContent();

  @override
  State<_ManageFloorsScreenContent> createState() => _ManageFloorsScreenContentState();
}

class _ManageFloorsScreenContentState extends State<_ManageFloorsScreenContent>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fabAnimation = CurvedAnimation(
      parent: _fabController,
      curve: Curves.elasticOut,
    );
    _fabController.forward();
  }

  @override
  void dispose() {
    _fabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _deleteFloor(Floor floor, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Delete Floor',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        content: Text(
          'Are you sure you want to remove ${floor.floorNumber}?',
          style: const TextStyle(color: AppColors.textMid),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textLight),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              context.read<ManageFloorsBloc>().add(DeleteFloorEvent(floor.id));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${floor.floorNumber} removed'),
                  backgroundColor: AppColors.primaryColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageFloorsBloc, ManageFloorsState>(
      builder: (context, state) {
        final filtered = state.filteredFloors;

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
                              onTap: () {
                                Navigator.pop(context);
                              },
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
                                child: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 16,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Manage Floors',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textDark,
                                letterSpacing: -0.8,
                              ),
                            ),
                            const Spacer(),
                            ScaleTransition(
                              scale: _fabAnimation,
                              child: GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Add new floor'),
                                      backgroundColor: AppColors.primaryColor,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.primaryLight,
                                        AppColors.primaryColor,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryColor.withOpacity(
                                          0.45,
                                        ),
                                        blurRadius: 16,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.add_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

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
                            onChanged: (val) {
                              context.read<ManageFloorsBloc>().add(UpdateSearchQueryEvent(val));
                            },
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textDark,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search by tower, wing, floor...',
                              hintStyle: const TextStyle(
                                color: AppColors.textLight,
                                fontSize: 14,
                              ),
                              prefixIcon: const Icon(
                                Icons.search_rounded,
                                color: AppColors.primaryColor,
                                size: 22,
                              ),
                              suffixIcon: state.searchQuery.isNotEmpty
                                  ? GestureDetector(
                                onTap: () {
                                  _searchController.clear();
                                  context.read<ManageFloorsBloc>().add(const UpdateSearchQueryEvent(''));
                                },
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: AppColors.textLight,
                                  size: 18,
                                ),
                              )
                                  : null,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.cardBg,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.textLight.withOpacity(0.2)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: state.selectedTower,
                                    isExpanded: true,
                                    icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primaryColor),
                                    style: const TextStyle(
                                      color: AppColors.textDark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    hint: const Text('Select Tower'),
                                    items: state.towers.map((String tower) {
                                      return DropdownMenuItem<String>(
                                        value: tower,
                                        child: Text(tower),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        context.read<ManageFloorsBloc>().add(SelectTowerEvent(newValue));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.cardBg,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.textLight.withOpacity(0.2)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: state.selectedWing,
                                    isExpanded: true,
                                    icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primaryColor),
                                    style: const TextStyle(
                                      color: AppColors.textDark,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    hint: const Text('Select Wing'),
                                    items: state.wings.map((String wing) {
                                      return DropdownMenuItem<String>(
                                        value: wing,
                                        child: Text(wing),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        context.read<ManageFloorsBloc>().add(SelectWingEvent(newValue));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Text(
                              '${filtered.length} Floor${filtered.length != 1 ? 's' : ''}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textLight,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            if (state.selectedTower != 'All' || state.selectedWing != 'All' || state.searchQuery.isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  _searchController.clear();
                                  context.read<ManageFloorsBloc>().add(const ClearFiltersEvent());
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'Clear filters',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),

                // Loading State
                if (state.status == Status.loading)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(50),
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),

                // Floors List
                if (state.status != Status.loading)
                  if (filtered.isEmpty)
                    SliverFillRemaining(
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
                              child: const Icon(
                                Icons.layers_outlined,
                                size: 40,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'No Floors found',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Try adjusting your search or filters',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final floor = filtered[index];
                            return _FloorCard(
                              floor: floor,
                              onEdit: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                      create: (_) => EditFloorsBloc(),
                                      child: const EditFloorForm(),
                                    ),
                                  ),
                                );
                              },
                              onDelete: () => _deleteFloor(floor, context),
                              index: index,
                            );
                          },
                          childCount: filtered.length,
                        ),
                      ),
                    ),

                // Bottom padding
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FloorCard extends StatefulWidget {
  final Floor floor;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final int index;

  const _FloorCard({
    required this.floor,
    required this.onEdit,
    required this.onDelete,
    required this.index,
  });

  @override
  State<_FloorCard> createState() => _FloorCardState();
}

class _FloorCardState extends State<_FloorCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  static const Color primaryColor = Color(0xFFC5610F);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1A1208);
  static const Color textMid = Color(0xFF6B5A47);
  static const Color textLight = Color(0xFF9C8872);

  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slideAnimation = Tween<double>(
      begin: 40,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

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
                  // Floor Icon
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.layers_rounded,
                      color: AppColors.primaryColor,
                      size: 24,
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
                              widget.floor.floorNumber,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: textDark,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              size: 13,
                              color: primaryColor.withOpacity(0.7),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Tower: ${widget.floor.tower}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: textMid,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.apartment_rounded,
                              size: 13,
                              color: primaryColor.withOpacity(0.7),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Wing: ${widget.floor.wing}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: textMid,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(widget.floor.status).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.floor.status,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(widget.floor.status),
                            ),
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
class _ActionButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

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
            ),
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
