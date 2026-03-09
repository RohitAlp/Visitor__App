import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:visitorapp/constants/constant.dart';
import 'package:visitorapp/controller/tower_controller.dart';
import 'package:visitorapp/model/GetTowerListResponse.dart';
import 'package:visitorapp/model/VerifyOtpResponse.dart';
import '../../../../config/Routes/RouteName.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/utils.dart';
import '../../../../widgets/owner_card.dart';

class ManageTowersScreen extends StatefulWidget {
  const ManageTowersScreen({super.key});

  @override
  State<ManageTowersScreen> createState() => _ManageTowersScreenState();
}

class _ManageTowersScreenState extends State<ManageTowersScreen>
    with TickerProviderStateMixin {
  final List<Owner> _allTowers = [
    Owner.tower(
      name: 'Tower A',
      towerCode: 'TWR-A-001',
      wings: 4,
      isActive: true,
    ),
    Owner.tower(
      name: 'Tower B',
      towerCode: 'TWR-B-002',
      wings: 3,
      isActive: true,
    ),
    Owner.tower(
      name: 'Tower C',
      towerCode: 'TWR-C-003',
      wings: 2,
      isActive: false,
    ),
    Owner.tower(
      name: 'Tower D',
      towerCode: 'TWR-D-004',
      wings: 3,
      isActive: true,
    ),
    Owner.tower(
      name: 'Tower E',
      towerCode: 'TWR-E-005',
      wings: 5,
      isActive: true,
    ),
  ];

  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;
  List<Owner> get _filteredTowers {
    return _allTowers.where((tower) {
      return _searchQuery.isEmpty ||
          tower.name!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (tower.towerCode?.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ??
              false);
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

  Future<void> _getTowers() async {
    if (await Utils.isConnected()) {
      final box = GetStorage();

      bool _isLoading = true;
      Utils.onLoading(context);

      TowerController towerController = TowerController();
      try {
        final societyId =
            Constant.verifyOtpResponse.societyId.toString() ?? "0";

        final response = await towerController.getTowers(societyId);
        if (response != null) {
          GetTowerListResponse res =
              GetTowerListResponse.fromJson(response.data);

          setState(() {
           // _allTowers =res.data ?? [];

          });

          print(response);
        } else {
          //  Utils.showToast(context, message: 'Something went wrong!');
          print(response);
        }
      } catch (e) {
        Utils.showToast(context, message: 'Something went wrong!');
        print(e);
      } finally {
        if (_isLoading) {
          Navigator.pop(context);
        }
      }
    } else {
      Utils.showToast(context, message: Constant.internetConMsg);
    }
  }

  @override
  void dispose() {
    _fabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _deleteTower(Owner tower) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Delete Tower',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        content: Text(
          'Are you sure you want to remove ${tower.name}?',
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
              backgroundColor: AppColors.deleteRed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${tower.name} removed'),
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

  void _editTower(Owner tower) {
    Navigator.pushNamed(
      context,
      RouteName.AddTowerForm,
      arguments: {'isEdit': true, 'tower': tower},
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredTowers;

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
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 16,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Manage Towers',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textDark,
                              letterSpacing: -0.8,
                            ),
                          ),
                          // Text(
                          //   '${_allTowers.length} towers',
                          //   style: const TextStyle(
                          //     fontSize: 13,
                          //     color: textLight,
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
                            Navigator.pushNamed(
                              context,
                              RouteName.AddTowerForm,
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
                            child: Icon(
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
                        hintText: 'Search by tower name or code...',
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

                  // Count
                  Row(
                    children: [
                      Text(
                        '${filtered.length} Tower${filtered.length != 1 ? 's' : ''}',
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
                        '${filtered.where((tower) => tower.isActive).length} Active',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textLight,
                          fontWeight: FontWeight.w500,
                        ),
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
                        '${filtered.where((tower) => !tower.isActive).length} Inactive',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textLight,
                          fontWeight: FontWeight.w500,
                        ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Clear',
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
                              Icons.domain_rounded,
                              size: 40,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No towers found',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Try adjusting your search',
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
                        final tower = filtered[index];
                        return OwnerCard(
                          owner: tower,
                          onEdit: () => _editTower(tower),
                          onDelete: () => _deleteTower(tower),
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
