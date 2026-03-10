import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants/app_colors.dart';
import 'edit_aminity/amenity_bloc/aminity_bloc.dart';
import '../../../../widgets/owner_card.dart';
import 'edit_aminity/update_aminity.dart';

class ManageAmanitiesScreen extends StatefulWidget {
  const ManageAmanitiesScreen({super.key});

  @override
  State<ManageAmanitiesScreen> createState() => _ManageAmanitiesScreenState();
}

class _ManageAmanitiesScreenState extends State<ManageAmanitiesScreen>
    with TickerProviderStateMixin {


  final List<Owner> _allAmenities = [
    Owner.amenity(
      name: 'Swimming Pool',
      category: 'Recreation',
      location: 'Block A - Ground Floor',
      timing: '6 AM - 10 PM',
      isActive: true,
      status: 'active',
    ),

    Owner.amenity(
      name: 'Garden',
      category: 'Walking',
      location: 'Block A - Ground Floor',
      timing: '6 AM - 10 PM',
      isActive: true,
      status: 'active',
    ),
    Owner.amenity(
      name: 'Gymnasium',
      category: 'Fitness',
      location: 'Block B - 1st Floor',
      timing: '5 AM - 11 PM',
      isActive: true,
      status: 'active',
    ),
    Owner.amenity(
      name: 'Community Hall',
      category: 'Events',
      location: 'Main Building - 2nd Floor',
      timing: '9 AM - 9 PM',
      isActive: false,
      status: 'maintenance',
    ),
    Owner.amenity(
      name: 'Children\'s Play Area',
      category: 'Recreation',
      location: 'Garden Area',
      timing: '6 AM - 8 PM',
      isActive: false,
      status: 'closed',
    ),
  ];

  String _searchQuery = '';
  String _selectedStatus = 'All';
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  List<Owner> get _filteredAmenities {
    return _allAmenities.where((amenity) {
      final matchesSearch = _searchQuery.isEmpty ||
          amenity.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (amenity.category?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
          (amenity.location?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      
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

  void _deleteAmenity(Owner amenity) {
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
              backgroundColor: AppColors.deleteRed,
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
            child: const Text('Delete', style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    );
  }

  void _editAmenity(Owner amenity) {
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
                        'Manage Amenities',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "${_filteredAmenities.length} Amenities",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),

                  const Spacer(),

                  /// ADD BUTTON
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => AminityBloc(),
                            child: const EditAminityForm(isAddingAmenity: true),
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
            Column(
              children: [


                // Header Section
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // const SizedBox(height: 20),


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
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.shadowColor,
                              blurRadius: 1,
                              spreadRadius: 0,
                              offset: Offset(0, 0),
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
                          Text(
                            '${filtered.length} Amenity${filtered.length != 1 ? 'ies' : ''}',
                            style: const TextStyle(fontSize: 13, color: AppColors.textLight, fontWeight: FontWeight.w600),
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
                            '${filtered.where((amenity) => amenity.status.toLowerCase() == 'active').length} Active',
                            style: const TextStyle(fontSize: 11, color: AppColors.textLight, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.maintenanceBlue,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${filtered.where((amenity) => amenity.status.toLowerCase() == 'maintenance').length} Maintenance',
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
                            '${filtered.where((amenity) => amenity.status.toLowerCase() == 'closed').length} Closed',
                            style: const TextStyle(fontSize: 11, color: AppColors.textLight, fontWeight: FontWeight.w500),
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

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
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
              )
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final amenity = filtered[index];
                  return OwnerCard(
                    owner: amenity,
                    onEdit: () {
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

