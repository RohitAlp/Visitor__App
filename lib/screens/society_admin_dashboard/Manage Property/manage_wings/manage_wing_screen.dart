import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitorapp/config/Routes/RouteName.dart';

import '../../../../constants/app_colors.dart';
import 'edit_wing_form/bloc/editwing_bloc.dart';
import 'edit_wing_form/edit_wing_form.dart';
import '../../../../widgets/owner_card.dart';


class Wing {
  final String tower;
  final String status;

  const Wing({
    required this.tower,
    required this.status,
  });
}

class ManageWingScreen extends StatefulWidget {
  const ManageWingScreen({super.key});

  @override
  State<ManageWingScreen> createState() => _ManageWingScreenState();
}

class _ManageWingScreenState extends State<ManageWingScreen>
    with TickerProviderStateMixin {
  final List<Owner> _allWings = [
    Owner.tower(
      name: 'Wing A-1',
      towerCode: 'Tower A',
      wings: 4,
      isActive: true,
    ),
    Owner.tower(
      name: 'Wing A-2',
      towerCode: 'Tower A',
      wings: 4,
      isActive: true,
    ),
    Owner.tower(
      name: 'Wing B-1',
      towerCode: 'Tower B',
      wings: 3,
      isActive: false,
    ),
    Owner.tower(
      name: 'Wing B-2',
      towerCode: 'Tower B',
      wings: 3,
      isActive: true,
    ),
    Owner.tower(
      name: 'Wing C-1',
      towerCode: 'Tower C',
      wings: 5,
      isActive: true,
    ),
    Owner.tower(
      name: 'Wing C-2',
      towerCode: 'Tower C',
      wings: 5,
      isActive: false,
    ),
  ];


  String _selectedWing = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  List<Owner> get _filteredGuards {
    return _allWings.where((wing) {
      final matchesWing = _selectedWing == 'All';
      final matchesSearch =
          _searchQuery.isEmpty ||
              wing.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              wing.towerCode!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              wing.status.toLowerCase().contains(_searchQuery.toLowerCase());
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

  void _deleteOwner(Owner wing) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Delete Wing',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        content: Text(
          'Are you sure you want to remove ${wing.name}?',
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${wing.name} removed'),
                  backgroundColor: AppColors.primaryColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppColors.statusGreen; // Emerald green
      case 'inactive':
        return AppColors.statusOrange; // Amber
      case 'maintenance':
        return AppColors.maintenanceBlue; // Blue
      case 'under construction':
        return AppColors.purple700; // Violet
      default:
        return AppColors.grayDefault; // Gray
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredGuards;

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
    
                  /// TITLE + COUNT
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Manage wings',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "${_filteredGuards.length} Notices",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
    
                  const Spacer(),
    
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => EditwingBloc(),
                            child: const EditWingForm(isAddingWing: true),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryLight,
                            AppColors.primaryColor
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
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
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadowColor,
                          blurRadius: 2,
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) => setState(() => _searchQuery = val),
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search by wing ot tower name...',
                        hintStyle: const TextStyle(
                          color: AppColors.textLight,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppColors.primaryColor,
                          size: 22,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
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
            
                  const SizedBox(height: 16),
            
                  Row(
                    children: [
                      Text(
                        '${filtered.length} Wing${filtered.length != 1 ? 's' : ''}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.statusGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${filtered.where((wing) => wing.isActive).length} Active',
                        style: const TextStyle(fontSize: 11, color: AppColors.textLight, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.statusOrange,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${filtered.where((wing) => !wing.isActive).length} Inactive',
                        style: const TextStyle(fontSize: 11, color: AppColors.textLight, fontWeight: FontWeight.w500),
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
            
            // Scrollable List
            Expanded(
              child: filtered.isEmpty
                  ? Center(
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
                        Icons.person_search_rounded,
                        size: 40,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No Wings found',
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
              )
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final wing = filtered[index];
                  return OwnerCard(
                    owner: wing,
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => EditwingBloc(),
                            child: const EditWingForm(),
                          ),
                        ),
                      );
                    },
                    onDelete: () => _deleteOwner(wing),
                    index: index,
                    showStatus: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget _buildStatusCounts(List<Owner> floors) {
  final statusCounts = <String, int>{};

  for (final floor in floors) {
    final status = floor.status.toLowerCase();
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