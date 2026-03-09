import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../controller/society_controller.dart';
import '../../../model/getSocietyResponse.dart';
import '../../../utils/enum.dart';
import '../../society_admin_dashboard/manage_users_property_screen.dart';

class Society {
  final String societyName;
  final String registrationNo;
  final String address;
  final String state;
  final String city;
  final String pinCode;
  final String contact;
  final String email;
  final String taxNumber;
  final num? societyId;

  const Society({
    required this.societyName,
    required this.registrationNo,
    required this.address,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.contact,
    required this.email,
    required this.taxNumber,
    this.societyId,
  });

  factory Society.fromApiModel(SocietyList apiModel) {
    return Society(
      societyName: apiModel.societyName ?? '',
      registrationNo: apiModel.registrationNo ?? '',
      address: apiModel.address ?? '',
      state: apiModel.state ?? '',
      city: apiModel.city ?? '',
      pinCode: apiModel.pinCode ?? '',
      contact: apiModel.contact ?? '',
      email: apiModel.email ?? '',
      taxNumber: apiModel.taxNumber ?? '',
      societyId: apiModel.societyId,
    );
  }
}

class SocietyCard extends StatefulWidget {
  final Society society;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final int index;

  const SocietyCard({
    super.key,
    required this.society,
    required this.onEdit,
    required this.onDelete,
    required this.index,
  });

  @override
  State<SocietyCard> createState() => _SocietyCardState();
}

class _SocietyCardState extends State<SocietyCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool _pressed = false;
  bool _isRevealed = false;

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
        padding: const EdgeInsets.only(bottom: 8, top: 2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _isRevealed ? Colors.white : Colors.transparent,
          ),
          child: Stack(
            children: [
              if (_isRevealed)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [AppColors.primaryLight, AppColors.primaryColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isRevealed = false;
                            });
                            widget.onDelete();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Image.asset(
                              'assets/image/delete_3405244.png',
                              width: 20,
                              height: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isRevealed = false;
                            });
                            widget.onEdit();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Image.asset(
                              'assets/image/edit_5973027.png',
                              width: 18,
                              height: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dx < 0) {
                    setState(() {
                      _isRevealed = true;
                    });
                  } else if (details.delta.dx > 10) {
                    setState(() {
                      _isRevealed = false;
                    });
                  }
                },
                onTap: () {
                  widget.onEdit();
                },
                onTapDown: (_) => setState(() => _pressed = true),
                onTapUp: (_) => setState(() => _pressed = false),
                onTapCancel: () => setState(() => _pressed = false),
                child: AnimatedScale(
                  scale: _pressed ? 0.97 : 1.0,
                  duration: const Duration(milliseconds: 120),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    transform: Matrix4.translationValues(
                      _isRevealed ? -140 : 0,
                      0,
                      0,
                    ),
                    child: Container(

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 0.6,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE4F0FF),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(
                                Icons.apartment_rounded,
                                color: AppColors.primaryColor,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.society.societyName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textDark,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Reg: ${widget.society.registrationNo}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textDark,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${widget.society.city}, ${widget.society.state}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textMid,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Active',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.textLight,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textMid,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class SocietyListScreen extends StatefulWidget {
  const SocietyListScreen({super.key});

  @override
  State<SocietyListScreen> createState() => _SocietyListScreenState();
}

class _SocietyListScreenState extends State<SocietyListScreen> with TickerProviderStateMixin {
  final SocietyController _societyController = SocietyController();
  List<Society> _allSocieties = [];
  Status _fetchStatus = Status.initial;
  String? _errorMessage;

  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  List<Society> get _filteredSocieties {
    return _allSocieties.where((society) {
      final matchesSearch =
          _searchQuery.isEmpty ||
              society.societyName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              society.address.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              society.city.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              society.registrationNo.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesSearch;
    }).toList();
  }

  Future<void> _fetchSocieties() async {
    setState(() {
      _fetchStatus = Status.loading;
      _errorMessage = null;
    });

    try {
      final response = await _societyController.getSociety({});
      
      if (response?.statusCode == 200 && response?.data != null) {
        final societyResponse = GetSocietyResponse.fromJson(response!.data);
        
        if (societyResponse.status == true) {
          final societies = societyResponse.societyList?.map((apiModel) => Society.fromApiModel(apiModel)).toList() ?? [];
          setState(() {
            _allSocieties = societies;
            _fetchStatus = Status.success;
          });
        } else {
          setState(() {
            _fetchStatus = Status.error;
            _errorMessage = societyResponse.message ?? 'Failed to fetch societies';
          });
        }
      } else {
        setState(() {
          _fetchStatus = Status.error;
          _errorMessage = 'Failed to fetch societies';
        });
      }
    } catch (e) {
      setState(() {
        _fetchStatus = Status.error;
        _errorMessage = 'An error occurred while fetching societies';
      });
    }
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
    _fetchSocieties();
  }

  @override
  void dispose() {
    _fabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _deleteSociety(Society society) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Delete Society',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        content: Text(
          'Are you sure you want to remove ${society.societyName}?',
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
                  content: Text('${society.societyName} removed'),
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
    final filtered = _filteredSocieties;

    return SafeArea(
      child: Scaffold(
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
                      'Societies',
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
                          // Add new society functionality
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
                    hintText: 'Search by society name...',
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
              Row(
                children: [
                  Text(
                    '${filtered.length} Societ${filtered.length != 1 ? 'ies' : 'y'}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textLight,
                      fontWeight: FontWeight.w600,
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
              // Scrollable List
              Expanded(
                child: _buildContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    final filtered = _filteredSocieties;

    switch (_fetchStatus) {
      case Status.loading:
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        );
      
      case Status.error:
        return Center(
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
                'Error Loading Societies',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _errorMessage ?? 'An unknown error occurred',
                style: const TextStyle(fontSize: 13, color: AppColors.textLight),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _fetchSocieties,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Retry',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ],
          ),
        );
      
      case Status.success:
        if (filtered.isEmpty) {
          return Center(
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
                    Icons.apartment_rounded,
                    size: 40,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'No Societies found',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Try adjusting your search',
                  style: TextStyle(fontSize: 13, color: AppColors.textLight),
                ),
              ],
            ),
          );
        }
        
        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final society = filtered[index];
            return SocietyCard(
              society: society,
              onEdit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManageUsersScreen(type: 2),
                  ),
                );
              },
              onDelete: () => _deleteSociety(society),
              index: index,
            );
          },
        );
      
      default:
        return const SizedBox.shrink();
    }
  }
}
