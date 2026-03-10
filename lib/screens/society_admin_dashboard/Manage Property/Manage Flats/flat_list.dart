import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants/app_colors.dart';
import '../../../../widgets/owner_card.dart';
import 'edit_flatts_form/edit_flatts_form.dart';
import 'edit_flatts_form/flat_bloc/flat_bloc.dart';

class ManageFlatsScreen extends StatefulWidget {
  const ManageFlatsScreen({super.key});

  @override
  State<ManageFlatsScreen> createState() => _ManageFlatsScreenState();
}

class _ManageFlatsScreenState extends State<ManageFlatsScreen>
    with TickerProviderStateMixin {

  final List<Owner> _allFlats = [
    Owner.flat(name: 'Flat 101', flat: 'Flat 101', wing: 'A Wing', tower: 'Tower A', floor: 'Floor 1', ownerName: 'Rajesh Kumar', isOccupied: true, isVacant: false),
    Owner.flat(name: 'Flat 102', flat: 'Flat 102', wing: 'A Wing', tower: 'Tower A', floor: 'Floor 1', ownerName: 'Priya Sharma', isOccupied: true, isVacant: false),
    Owner.flat(name: 'Flat 201', flat: 'Flat 201', wing: 'A Wing', tower: 'Tower A', floor: 'Floor 2', ownerName: 'Amit Patel', isOccupied: true, isVacant: false),
    Owner.flat(name: 'Flat 202', flat: 'Flat 202', wing: 'A Wing', tower: 'Tower A', floor: 'Floor 2', ownerName: null, isOccupied: false, isVacant: true),
    Owner.flat(name: 'Flat 301', flat: 'Flat 301', wing: 'C Wing', tower: 'Tower B', floor: 'Floor 3', ownerName: 'Sunita Verma', isOccupied: true, isVacant: false),
    Owner.flat(name: 'Flat 302', flat: 'Flat 302', wing: 'B Wing', tower: 'Tower B', floor: 'Floor 3', ownerName: 'Karan Mehta', isOccupied: true, isVacant: false),
    Owner.flat(name: 'Flat 401', flat: 'Flat 401', wing: 'D Wing', tower: 'Tower C', floor: 'Floor 4', ownerName: null, isOccupied: false, isVacant: true),
    Owner.flat(name: 'Flat 501', flat: 'Flat 501', wing: 'C Wing', tower: 'Tower C', floor: 'Floor 5', ownerName: 'Meera Joshi', isOccupied: true, isVacant: false),
  ];

  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  List<Owner> get _filteredFlats {
    return _allFlats.where((flat) {
      return _searchQuery.isEmpty ||
          flat.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          flat.flat.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (flat.tower?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
          flat.wing.toLowerCase().contains(_searchQuery.toLowerCase());
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

  void _deleteFlat(Owner flat) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Flat', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textDark)),
        content: Text('Are you sure you want to remove ${flat.flat}?', style: const TextStyle(color: AppColors.textMid)),
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
                  content: Text('${flat.flat} removed'),
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

  void _editFlat(Owner flat) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editing ${flat.flat}'),
        backgroundColor: AppColors.primaryLight,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredFlats;

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
                        'Manage Flats',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "${_filteredFlats.length} Flats",
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
                            create: (_) => FlatBloc(),
                            child: const EditFlatForm(isAddingFlat: true),
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
                          style: const TextStyle(fontSize: 14, color: AppColors.textDark, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            hintText: 'Search by owner name/flat number',
                            hintStyle: const TextStyle(color: AppColors.textLight, fontSize: 14),
                            prefixIcon: Image.asset(
                              'assets/image/complaints.svg',
                              width: 22,
                              height: 22,
                              color: AppColors.primaryColor,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.search_rounded, color: AppColors.primaryColor, size: 22);
                              },
                            ),
                            suffixIcon: _searchQuery.isNotEmpty
                                ? GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                              child: Image.asset(
                                'assets/image/delete_5577690.png',
                                width: 18,
                                height: 18,
                                color: AppColors.textLight,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.close_rounded, color: AppColors.textLight, size: 18);
                                },
                              ),
                            )
                                : null,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Text(
                            '${filtered.length} Flat${filtered.length != 1 ? 's' : ''}',
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
                            '${filtered.where((flat) => flat.isOccupied).length} Occupied',
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
                            '${filtered.where((flat) => flat.isVacant).length} Vacant',
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
                      child: Image.asset(
                        'assets/image/home-01.svg',
                        width: 40,
                        height: 40,
                        color: AppColors.primaryColor,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.meeting_room_rounded, size: 40, color: AppColors.primaryColor);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No flats found',
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
                  final flat = filtered[index];
                  return OwnerCard(
                    owner: flat,
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => FlatBloc(),
                            child: const EditFlatForm(),
                          ),
                        ),
                      );
                    },
                    onDelete: () => _deleteFlat(flat),
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