import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:visitorapp/constants/constant.dart';
import 'package:visitorapp/controller/tower_controller.dart';
import 'package:visitorapp/model/GetTowerListResponse.dart';
import 'package:visitorapp/model/gettower_Response.dart';
import 'package:visitorapp/model/VerifyOtpResponse.dart';
import '../../../../config/Routes/RouteName.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/utils.dart';
import '../../../../widgets/owner_card.dart';

class ManageTowersScreen extends StatefulWidget {
  final int? societyId;
  const ManageTowersScreen({super.key, this.societyId});

  @override
  State<ManageTowersScreen> createState() => _ManageTowersScreenState();
}

class _ManageTowersScreenState extends State<ManageTowersScreen>
    with TickerProviderStateMixin {
  List<Owner> _allTowers = [];
  bool _isLoading = false;
  String? _errorMessage;

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
    _getTowers();
  }

  Future<void> _getTowers() async {
    if (await Utils.isConnected()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      TowerController towerController = TowerController();
      try {
        final societyId =
            widget.societyId?.toString() ??
            Constant.verifyOtpResponse.societyId?.toString() ??
            "0";

        final response = await towerController.getTowers(societyId);
        if (response != null && response.statusCode == 200) {
          GettowerController towerResponse = GettowerController.fromJson(
            response.data,
          );

          if (towerResponse.status == true && towerResponse.data != null && towerResponse.data!.isNotEmpty) {
            List<Owner> towers = towerResponse.data!.map((buildingData) {
              return Owner.tower(
                name: buildingData.buildingName ?? 'Unknown Tower',
                towerCode: 'TWR-${buildingData.buildingId ?? '000'}',
                wings: buildingData.numberOfFloors?.toInt() ?? 0,
                isActive: true,
              );
            }).toList();

            setState(() {
              _allTowers = towers;
              _isLoading = false;
            });
          } else {
            // Show static data when API returns no data
            List<Owner> staticTowers = _getStaticTowers();
            setState(() {
              _allTowers = staticTowers;
              _isLoading = false;
            });
          }
        } else {
          // Show static data when API fails
          List<Owner> staticTowers = _getStaticTowers();
          setState(() {
            _allTowers = staticTowers;
            _isLoading = false;
          });
        }
      } catch (e) {
        // Show static data when exception occurs
        List<Owner> staticTowers = _getStaticTowers();
        setState(() {
          _allTowers = staticTowers;
          _isLoading = false;
        });
        print(e);
      }
    } else {
      setState(() {
        _errorMessage = Constant.internetConMsg;
      });
      Utils.showToast(context, message: Constant.internetConMsg);
    }
  }

  // Method to provide static tower data when API fails or returns no data
  List<Owner> _getStaticTowers() {
    return [
      Owner.tower(
        name: 'Tower A',
        towerCode: 'TWR-001',
        wings: 10,
        isActive: true,
      ),
      Owner.tower(
        name: 'Tower B',
        towerCode: 'TWR-002',
        wings: 8,
        isActive: true,
      ),
      Owner.tower(
        name: 'Tower C',
        towerCode: 'TWR-003',
        wings: 12,
        isActive: false,
      ),
      Owner.tower(
        name: 'Tower D',
        towerCode: 'TWR-004',
        wings: 6,
        isActive: true,
      ),
      Owner.tower(
        name: 'Tower E',
        towerCode: 'TWR-005',
        wings: 15,
        isActive: true,
      ),
    ];
  }

  @override
  void dispose() {
    _fabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> deleteTower(BuildContext context, Owner society) async {
    if (await Utils.isConnected()) {
      bool _isLoading = true;
      Utils.onLoading(context);

      Map<String, dynamic> data = {"societyId": society ?? 0};

      TowerController controller = TowerController();
      try {
        final response = await controller.deleteTower(data);

        /*if (response != null) {
          DeleteSocietyResponse res = DeleteSocietyResponse.fromJson(
            response.data,
          );

          if (res.status == true && res.statusCode == 200) {
            Utils.showToast(context, message: '${res.message}');

            Navigator.pop(context);
            _isLoading = false;

            Navigator.pushReplacementNamed(context, RouteName.ManageTowersScreen);

          } else {
            Utils.showToast(context, message: '${res.message}');
          }
        } else {
          Utils.showToast(context, message: 'Something went wrong!');
          print(response);
        }*/
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
            onPressed: () async{
              Navigator.pop(ctx);
              await deleteTower(ctx,tower);
              /*ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${tower.name} removed'),
                  backgroundColor: AppColors.primaryColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );*/
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
                        'Manage Towers',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "${_filteredTowers.length} Towers",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
    
                  const Spacer(),
    
                  /// ADD BUTTON
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(
                        context,
                        RouteName.AddTowerForm,
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
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : _errorMessage != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.error_outline_rounded,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Error Loading Towers',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _errorMessage!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textLight,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _getTowers,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Retry',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  : filtered.isEmpty
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
