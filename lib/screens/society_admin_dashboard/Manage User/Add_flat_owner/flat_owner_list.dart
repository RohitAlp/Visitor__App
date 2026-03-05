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
  static const Color primaryColor = Color(0xFFC5610F);
  static const Color primaryLight = Color(0xFFE8832A);
  static const Color bgColor = Color(0xFFF5F0EB);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1A1208);
  static const Color textMid = Color(0xFF6B5A47);
  static const Color textLight = Color(0xFF9C8872);

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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          fontSize: 20,
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
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [primaryLight, primaryColor],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.45),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.add_rounded, color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Container(
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x66000000),
                          blurRadius: 3,
                          spreadRadius: 0,
                          offset: Offset(0, 0),
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
                                  color: primaryColor.withOpacity(0.3),
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

