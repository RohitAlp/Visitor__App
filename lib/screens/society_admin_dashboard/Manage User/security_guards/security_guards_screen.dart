import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitorapp/config/Routes/RouteName.dart';

import '../../../../constants/app_colors.dart';
import '../../../../widgets/owner_card.dart';
import 'edit_guards_details_form/bloc/editguards_bloc.dart';
import 'edit_guards_details_form/edit_security_guards_form.dart';

class SecurityGuardsScreen extends StatefulWidget {
  const SecurityGuardsScreen({super.key});

  @override
  State<SecurityGuardsScreen> createState() => _SecurityGuardsScreenState();
}

class _SecurityGuardsScreenState extends State<SecurityGuardsScreen>
    with TickerProviderStateMixin {
  final List<Owner> _allGuards =  [
    Owner.guard(
      name: 'Rajesh Kumar',
      phone: '+91 98765 43210',
      shift: '06:00 AM - 02:00 PM',
      avatarInitials: 'RK',
    ),
    Owner.guard(
      name: 'Priya Sharma',
      phone: '+91 98765 43211',
      shift: '06:00 AM - 02:00 PM',
      avatarInitials: 'PS',
    ),

    Owner.guard(
      name: 'Amit Patel',
      phone: '+91 98765 43212',
      shift: '02:00 PM - 10:00 PM',
      avatarInitials: 'AP',
    ),
    Owner.guard(
      name: 'Sneha Reddy',
      phone: '+91 98765 43213',
      shift: '02:00 PM - 10:00 PM',
      avatarInitials: 'SR',
    ),

    Owner.guard(
      name: 'Vikram Singh',
      phone: '+91 98765 43214',
      shift: '10:00 PM - 06:00 AM',
      avatarInitials: 'VS',
    ),
    Owner.guard(
      name: 'Meera Joshi',
      phone: '+91 98765 43215',
      shift: '10:00 PM - 06:00 AM',
      avatarInitials: 'MJ',
    ),
  ];


  String _selectedShift = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  final List<String> _shifts = ['All', 'Morning', 'Afternoon', 'Night'];

  List<Owner> get _filteredGuards {
    return _allGuards.where((guard) {
      final matchesShift = _selectedShift == 'All' ||
          (_selectedShift == 'Morning' && guard.shift!.contains('06:00 AM - 02:00 PM')) ||
          (_selectedShift == 'Afternoon' && guard.shift!.contains('02:00 PM - 10:00 PM')) ||
          (_selectedShift == 'Night' && guard.shift!.contains('10:00 PM - 06:00 AM'));
      final matchesSearch =
          _searchQuery.isEmpty ||
              guard.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              guard.shift!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              guard.phone.contains(_searchQuery);
      return matchesShift && matchesSearch;
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

  void _deleteGuard(Owner guard) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Delete Guard',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        content: Text(
          'Are you sure you want to remove ${guard.name}?',
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
                  content: Text('${guard.name} removed'),
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

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredGuards;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Fixed Header
            Padding(
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
                        'Security Guards',
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
                            Navigator.pushNamed(context, RouteName.AddFlatOwnerForm);
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

                  // Search Bar
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
                        hintText: 'Search by guard name...',
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
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _shifts.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, i) {
                        final shift = _shifts[i];
                        final isSelected = _selectedShift == shift;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedShift = shift),
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
                              shift,
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
                        '${filtered.length} Guard${filtered.length != 1 ? 's' : ''}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      if (_selectedShift != 'All' || _searchQuery.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedShift = 'All';
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
                     Text(
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
                  final guard = filtered[index];
                  return OwnerCard(
                    owner: guard,
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => EditguardsBloc(),
                            child: const EditSecurityGuardsForm(),
                          ),
                        ),
                      );
                    },
                    onDelete: () => _deleteGuard(guard),
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
