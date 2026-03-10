import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../config/Routes/RouteName.dart';
import '../../../../widgets/owner_card.dart';

class FlatOwner {
  final String name;
  final String flat;
  final String phone;
  final String wing;
  final String avatarInitials;
  final bool isActive;

  const FlatOwner({
    required this.name,
    required this.flat,
    required this.phone,
    required this.wing,
    required this.avatarInitials,
    required this.isActive,
  });
}

class FlatOwnersScreen extends StatefulWidget {
  const FlatOwnersScreen({super.key});

  @override
  State<FlatOwnersScreen> createState() => _FlatOwnersScreenState();
}

class _FlatOwnersScreenState extends State<FlatOwnersScreen>
    with TickerProviderStateMixin {

  final List<FlatOwner> _allOwners = const [
    FlatOwner(name: 'Nikhil Dattatray Bhandigare', flat: 'Flat A-302', phone: '+91 98765 43210', wing: 'A', avatarInitials: 'RK', isActive: true),
    FlatOwner(name: 'Priya Sharma', flat: 'Flat B-501', phone: '+91 98765 43211', wing: 'B', avatarInitials: 'PS', isActive: true),
    FlatOwner(name: 'Amit Patel', flat: 'Flat C-204', phone: '+91 98765 43212', wing: 'C', avatarInitials: 'AP', isActive: false),
    FlatOwner(name: 'Sneha Reddy', flat: 'Flat A-101', phone: '+91 98765 43213', wing: 'A', avatarInitials: 'SR', isActive: true),
    FlatOwner(name: 'Vikram Singh', flat: 'Flat D-403', phone: '+91 98765 43214', wing: 'D', avatarInitials: 'VS', isActive: false),
    FlatOwner(name: 'Meera Joshi', flat: 'Flat B-201', phone: '+91 98765 43215', wing: 'B', avatarInitials: 'MJ', isActive: true),
    FlatOwner(name: 'Karan Mehta', flat: 'Flat C-305', phone: '+91 98765 43216', wing: 'C', avatarInitials: 'KM', isActive: true),
    FlatOwner(name: 'Anita Gupta', flat: 'Flat A-404', phone: '+91 98765 43217', wing: 'A', avatarInitials: 'AG', isActive: false),
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
        title: const Text('Delete Owner', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textDark)),
        content: Text('Are you sure you want to remove ${owner.name}?', style: const TextStyle(color: AppColors.textMid)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textLight)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${owner.name} removed'),
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
                        'Flat Owners',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "${_filteredOwners.length} Owners",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
    
                  const Spacer(),
    
                  /// ADD BUTTON
                  GestureDetector(
                    onTap: (){
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => AddNoticeScreen(),
                      //   ),
                      // );
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            
            
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadowColor,
                          blurRadius: 3,
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
                        hintText: 'Search by owner name...',
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
            
                  SizedBox(
                    height: 40,
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
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? const LinearGradient(
                                colors: [AppColors.primaryLight, AppColors.primaryColor],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                                  : null,
                              color: isSelected ? null : AppColors.cardBg,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: isSelected
                                  ? [
                                BoxShadow(
                                  color: AppColors.primaryColor.withOpacity(0.3),
                                  blurRadius: 12,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 0),
                                )
                              ]
                                  : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 2,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Text(
                              wing,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isSelected ? AppColors.white : AppColors.textMid,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            
                  const SizedBox(height: 16),
            
                  Row(
                    children: [
                      Text(
                        '${filtered.length} Owner${filtered.length != 1 ? 's' : ''}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textLight,
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
            
                  const SizedBox(height: 8),
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
                      child: const Icon(Icons.person_search_rounded, size: 40, color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No owners found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Try adjusting your search or filters',
                      style: TextStyle(fontSize: 13, color: AppColors.textLight),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final owner = filtered[index];
                  return OwnerCard(
                    owner: Owner(
                      name: owner.name,
                      flat: owner.flat,
                      phone: owner.phone,
                      wing: owner.wing,
                      avatarInitials: owner.avatarInitials,
                      isActive: owner.isActive,
                    ),
                    onEdit: () => _editOwner(owner),
                    onDelete: () => _deleteOwner(owner),
                    index: index,
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

