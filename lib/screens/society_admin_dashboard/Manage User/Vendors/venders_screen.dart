import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitorapp/config/Routes/RouteName.dart';
import '../../../../constants/app_colors.dart';
import '../../../../widgets/owner_card.dart';
import 'edit_vendor/bloc/edit_vendor_bloc.dart' show EditVendorBloc;
import 'edit_vendor/edit_vendor_form.dart';


class VendorsScreens extends StatefulWidget {
  const VendorsScreens({super.key});

  @override
  State<VendorsScreens> createState() => _VendorsScreensState();
}

class _VendorsScreensState extends State<VendorsScreens>
    with TickerProviderStateMixin {
  final List<Owner> _allGuards = [
    Owner.vendor(
      name: 'ShreeRam Plumbing Services',
      phone: '+91 98765 43210',
      services: 'Plumbing Services',
      avatarInitials: 'SP',
    ),
    Owner.vendor(
      name: 'Powerfix Electricals',
      phone: '+91 98765 43211',
      services: 'Electrical Services',
      avatarInitials: 'PE',
    ),

    Owner.vendor(
      name: 'Greenleaf Cleaning Co.',
      phone: '+91 98765 43212',
      services: 'Housekeeping Services',
      avatarInitials: 'GC',
    ),
    Owner.vendor(
      name: 'BuildRight Carpentry',
      phone: '+91 98765 43213',
      services: 'Carpentry Services',
      avatarInitials: 'BC',
    ),

    Owner.vendor(
      name: 'Cool Air AC Services',
      phone: '+91 98765 43214',
      services: 'Appliance Repair Services',
      avatarInitials: 'CA',
    ),

  ];
  String _selectedWing = 'All';
  String _searchQuery = '';
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  List<Owner> get _filteredVenders {
    return _allGuards.where((owner) {
      final matchesWing = _selectedWing == 'All';
      final matchesCategory = _selectedCategory == 'All' || owner.services == _selectedCategory;
      final matchesSearch =
          _searchQuery.isEmpty ||
              owner.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              owner.services!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              owner.phone.contains(_searchQuery);
      return matchesWing && matchesCategory && matchesSearch;
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

  void _deleteOwner(Owner owner) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Delete Vendor',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        content: Text(
          'Are you sure you want to remove ${owner.name}?',
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
                  content: Text('${owner.name} removed'),
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

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AnimatedFilterSheet(
        onCategorySelected: (category) {
          setState(() => _selectedCategory = category);
          Navigator.pop(context);
        },
        selectedCategory: _selectedCategory,
        allGuards: _allGuards,
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    final filtered = _filteredVenders;

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
                        'Vendors',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "${_filteredVenders.length} Vendors",
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
                            create: (_) => EditVendorBloc(),
                            child: const EditVendorsForm(isAddingVendor: true),
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
                  Row(
                    children: [
                      /// 🔍 Search Field
                      Expanded(
                        child: Container(
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
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textDark,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search by guard name...',
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
                      ),
        
                      const SizedBox(width: 12),
        
                      GestureDetector(
                        onTap: () {
                          _showFilterBottomSheet();
                        },
                        child: Container(
                          height: 54,
                          width: 54,
                          decoration: BoxDecoration(
                            color: AppColors.white,
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
                          child: const Icon(
                            Icons.filter_alt,
                            color: AppColors.primaryColor,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
        
                  const SizedBox(height: 16),
        
                  const SizedBox(height: 16),
        
                  Row(
                    children: [
                      Text(
                        '${filtered.length} Vendor${filtered.length != 1 ? 's' : ''}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      if (_selectedWing != 'All' || _searchQuery.isNotEmpty || _selectedCategory != 'All')
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedWing = 'All';
                              _selectedCategory = 'All';
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
                      child: const Icon(
                        Icons.person_search_rounded,
                        size: 40,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No Guards found',
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
                  final owner = filtered[index];
                  return OwnerCard(
                    owner: owner,
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => EditVendorBloc(),
                            child: const EditVendorsForm(),
                          ),
                        ),
                      );
                    },
                    onDelete: () => _deleteOwner(owner),
                    index: index,
                    showStatus: false,
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

class _AnimatedFilterSheet extends StatefulWidget {
  final Function(String) onCategorySelected;
  final String selectedCategory;
  final List<Owner> allGuards;

  const _AnimatedFilterSheet({
    required this.onCategorySelected,
    required this.selectedCategory,
    required this.allGuards,
  });

  @override
  State<_AnimatedFilterSheet> createState() => _AnimatedFilterSheetState();
}

class _AnimatedFilterSheetState extends State<_AnimatedFilterSheet>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  List<Widget> _buildDynamicFilterOptions() {
    final uniqueServices = widget.allGuards.map((v) => v.services!).toSet().toList();
    
    final List<Widget> options = [
      _AnimatedFilterOption(
        title: 'All',
        icon: Icons.filter_list,
        count: widget.allGuards.length,
        isSelected: widget.selectedCategory == 'All',
        onTap: () => widget.onCategorySelected('All'),
        index: 0,
      ),
    ];
    
    for (int i = 0; i < uniqueServices.length; i++) {
      final service = uniqueServices[i];
      options.add(_AnimatedFilterOption(
        title: service,
        icon: _getIconForService(service),
        count: widget.allGuards.where((v) => v.services == service).length,
        isSelected: widget.selectedCategory == service,
        onTap: () => widget.onCategorySelected(service),
        index: i + 1,
      ));
    }
    
    return options;
  }

  IconData _getIconForService(String service) {
    switch (service.toLowerCase()) {
      case 'plumbing services':
        return Icons.plumbing;
      case 'electrical services':
        return Icons.electrical_services;
      case 'housekeeping services':
        return Icons.cleaning_services;
      case 'carpentry services':
        return Icons.carpenter;
      case 'appliance repair services':
        return Icons.home_repair_service;
      default:
        return Icons.room_service;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textLight.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Header with close button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Filter by Category',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Choose a service category',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _AnimatedCloseButton(
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              
              // Filter options
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: _buildDynamicFilterOptions(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedFilterOption extends StatefulWidget {
  final String title;
  final IconData icon;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;
  final int index;

  const _AnimatedFilterOption({
    required this.title,
    required this.icon,
    required this.count,
    required this.isSelected,
    required this.onTap,
    required this.index,
  });

  @override
  State<_AnimatedFilterOption> createState() => _AnimatedFilterOptionState();
}

class _AnimatedFilterOptionState extends State<_AnimatedFilterOption>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    // Stagger the animations
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _controller.reverse().then((_) {
                    widget.onTap();
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: widget.isSelected 
                        ? Colors.white
                        : AppColors.cardBg,
                    borderRadius: BorderRadius.circular(12),
                    border: widget.isSelected 
                        ? Border.all(color: AppColors.primaryColor, width: 1)
                        : Border.all(color: Colors.transparent),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: widget.isSelected
                    //         ? AppColors.primaryColor.withOpacity(0.2)
                    //         : Colors.black.withOpacity(0.05),
                    //     blurRadius: widget.isSelected ? 12 : 8,
                    //     offset: widget.isSelected
                    //         ? const Offset(0, 4)
                    //         : const Offset(0, 2),
                    //   ),
                    // ],
                  ),
                  child: Row(
                    children: [
                      // Animated Icon Container
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: widget.isSelected 
                              ? AppColors.primaryColor 
                              : AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: widget.isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primaryColor.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Icon(
                            widget.icon,
                            key: ValueKey(widget.isSelected),
                            size: 20,
                            color: widget.isSelected ? Colors.white : AppColors.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Title
                      Expanded(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: widget.isSelected 
                                ? AppColors.primaryColor 
                                : AppColors.textDark,
                          ),
                          child: Text(widget.title),
                        ),
                      ),
                      
                      // Count Badge
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: widget.isSelected 
                              ? AppColors.primaryColor 
                              : AppColors.bgColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: widget.isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primaryColor.withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          widget.count.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: widget.isSelected ? Colors.white : AppColors.textMid,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Divider(
                height: 1,
                thickness: 0.5,
                color: AppColors.textLight.withOpacity(0.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedCloseButton extends StatefulWidget {
  final VoidCallback onTap;

  const _AnimatedCloseButton({required this.onTap});

  @override
  State<_AnimatedCloseButton> createState() => _AnimatedCloseButtonState();
}

class _AnimatedCloseButtonState extends State<_AnimatedCloseButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.reverse().then((_) {
          widget.onTap();
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationAnimation.value * 0.1,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.close,
                  size: 18,
                  color: AppColors.textMid,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
