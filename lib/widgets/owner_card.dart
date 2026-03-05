import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class Owner {
  final String name;
  final String flat;
  final String phone;
  final String wing;
  final String avatarInitials;
  final bool isActive;
  final String? shift;
  final bool isGuard;
  final String? services;
  final bool isVendor;
  final String? tower;
  final String? floor;
  final bool isFlat;
  final String? ownerName;
  final String? towerCode;
  final int? wings;
  final bool isTower;
  final String? category;
  final String? location;
  final String? timing;
  final bool isAmenity;
  final String status;
  final String? occupancyInfo;
  final bool isOccupied;
  final bool isVacant;

  const Owner({
    required this.name,
    required this.flat,
    required this.phone,
    required this.wing,
    required this.avatarInitials,
    required this.isActive,
    this.shift,
    this.isGuard = false,
    this.services,
    this.isVendor = false,
    this.tower,
    this.floor,
    this.isFlat = false,
    this.ownerName,
    this.towerCode,
    this.wings,
    this.isTower = false,
    this.category,
    this.location,
    this.timing,
    this.isAmenity = false,
    this.status = 'active',
    this.occupancyInfo,
    this.isOccupied = false,
    this.isVacant = false,
  });

  Owner.guard({
    required this.name,
    required this.shift,
    required this.phone,
    required this.avatarInitials,
  }) : flat = '',
       wing = '',
       isActive = true,
       isGuard = true,
       services = null,
       isVendor = false,
       tower = null,
       floor = null,
       isFlat = false,
       ownerName = null,
       towerCode = null,
       wings = null,
       isTower = false,
       category = null,
       location = null,
       timing = null,
       isAmenity = false,
       status = 'active',
       occupancyInfo = null,
       isOccupied = false,
       isVacant = false;

  Owner.vendor({
    required this.name,
    required this.services,
    required this.phone,
    required this.avatarInitials,
  }) : flat = '',
       wing = '',
       isActive = true,
       isGuard = false,
       shift = null,
       isVendor = true,
       tower = null,
       floor = null,
       isFlat = false,
       ownerName = null,
       towerCode = null,
       wings = null,
       isTower = false,
       category = null,
       location = null,
       timing = null,
       isAmenity = false,
       status = 'active',
       occupancyInfo = null,
       isOccupied = false,
       isVacant = false;

  Owner.flat({
    required this.name,
    required this.flat,
    required this.wing,
    this.tower,
    this.floor,
    this.phone = '',
    this.avatarInitials = 'F',
    this.isActive = true,
    this.ownerName,
    this.occupancyInfo,
    this.isOccupied = false,
    this.isVacant = false,
  }) : isGuard = false,
       isVendor = false,
       isFlat = true,
       shift = null,
       services = null,
       towerCode = null,
       wings = null,
       isTower = false,
       category = null,
       location = null,
       timing = null,
       isAmenity = false,
       status = 'active';

  Owner.tower({
    required this.name,
    required this.towerCode,
    required this.wings,
    this.phone = '',
    this.avatarInitials = 'T',
    this.isActive = true,
  }) : flat = '',
       wing = '',
       isGuard = false,
       isVendor = false,
       isFlat = false,
       shift = null,
       services = null,
       tower = null,
       floor = null,
       ownerName = null,
       isTower = true,
       category = null,
       location = null,
       timing = null,
       isAmenity = false,
       status = 'active',
       occupancyInfo = null,
       isOccupied = false,
       isVacant = false;

  Owner.amenity({
    required this.name,
    required this.category,
    required this.location,
    required this.timing,
    this.phone = '',
    this.avatarInitials = 'A',
    this.isActive = true,
    this.status = 'active',
  }) : flat = '',
       wing = '',
       isGuard = false,
       isVendor = false,
       isFlat = false,
       isTower = false,
       shift = null,
       services = null,
       tower = null,
       floor = null,
       ownerName = null,
       towerCode = null,
       wings = null,
       isAmenity = true,
       occupancyInfo = null,
       isOccupied = false,
       isVacant = false;
}

class OwnerCard extends StatefulWidget {
  final Owner owner;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final int index;
  final bool showStatus;
  final String? locationLabel;

  const OwnerCard({
    super.key,
    required this.owner,
    required this.onEdit,
    required this.onDelete,
    required this.index,
    this.showStatus = true,
    this.locationLabel,
  });

  @override
  State<OwnerCard> createState() => _OwnerCardState();
}

class _OwnerCardState extends State<OwnerCard>
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

  String _getShiftType(String shift) {
    if (shift.contains('06:00 AM - 02:00 PM')) return 'Morning';
    if (shift.contains('02:00 PM - 10:00 PM')) return 'Afternoon';
    if (shift.contains('10:00 PM - 06:00 AM')) return 'Night';
    return 'Unknown';
  }

  Color _getAmenityStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppColors.successGreen;
      case 'maintenance':
        return AppColors.infoBlue;
      case 'closed':
        return AppColors.errorRed;
      default:
        return AppColors.grayDefault;
    }
  }

  String _getAmenityStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return 'Active';
      case 'maintenance':
        return 'Maintenance';
      case 'closed':
        return 'Closed';
      default:
        return 'Unknown';
    }
  }

  Color _getOccupancyColor(String occupancyInfo) {
    final match = RegExp(r'(\d+)/(\d+)').firstMatch(occupancyInfo);
    if (match != null) {
      final occupied = int.tryParse(match.group(1) ?? '0') ?? 0;
      final total = int.tryParse(match.group(2) ?? '0') ?? 1;
      
      final percentage = ((occupied / total) * 100).round();
      return percentage == 0 ? AppColors.errorRed : AppColors.successGreen;
    }
    return AppColors.grayDefault;
  }

  String _getOccupancyText(String occupancyInfo) {
    final match = RegExp(r'(\d+)/(\d+)').firstMatch(occupancyInfo);
    if (match != null) {
      final occupied = int.tryParse(match.group(1) ?? '0') ?? 0;
      final total = int.tryParse(match.group(2) ?? '0') ?? 1;
      
      final percentage = ((occupied / total) * 100).round();
      
      if (percentage == 0) {
        return 'Vacant';
      } else {
        return 'Occupied $percentage%';
      }
    }
    return occupancyInfo; // Fallback to original text
  }

  String _getServiceImage(String service) {
    return '';
  }

  String _getServiceEmoji(String service) {
    switch (service.toLowerCase()) {
      case 'plumbing services':
        return '🔧';
      case 'electrical services':
        return '⚡';
      case 'housekeeping services':
        return '✨';
      case 'carpentry services':
        return '🔨';
      case 'appliance repair services':
        return '⚙️';
      case 'pest control':
        return '🐛';
      case 'civil services':
        return '🏗️';
      default:
        return '🔧';
    }
  }

  IconData _getServiceIcon(String service) {
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
        return Icons.ac_unit_outlined;
      default:
        return Icons.room_service;
    }
  }

  String _getFlatEmoji() {
    return '🏠'; // For actual flats (apartments/houses)
  }

  String _getFloorEmoji() {
    return '🏗️'; // For floors (building levels)
  }

  String _getWingTowerEmoji() {
    if (widget.owner.name.contains('Wing')) {
      return '🏛️';
    } else if (widget.owner.isTower || widget.owner.name.toLowerCase().contains('tower')) {
      return '🏢';
    }
    return '';
  }

  Color _getSpecificAmenityColor() {
    final name = widget.owner.name.toLowerCase();
    
    if (name.contains('swimming') || name.contains('pool') ||
        name.contains('community') || name.contains('hall') ||
        name.contains('children') || name.contains('play')) {
      return Color(0xFFE4F0FF);
    }
    
    return Color(0xFFE7FCEE);
  }

  String _getAmenityEmoji() {
    switch (widget.owner.category?.toLowerCase()) {
      case 'recreation':
        return '🏊';
      case 'fitness':
        return '💪';
      case 'events':
        return '🎉';
      case 'sports':
        return '🏸';
      case 'children':
        return '🛝';
      default:
        return '🌴';
    }
  }

  String _getProfileImage() {
    if (widget.owner.isGuard) {
      return 'assets/image/profile.png';
    } else if (widget.owner.isVendor) {
      return ''; // Vendors use emoji now
    } else if (widget.owner.isFlat) {
      if (widget.owner.name.contains('Wing')) {
        return '';
      }
      return '';
    } else if (widget.owner.isTower) {
      if (widget.owner.name.contains('Wing')) {
        return '';
      }
      return '';
    } else if (widget.owner.isAmenity) {
      if (widget.owner.name.toLowerCase().contains('swimming') || widget.owner.name.toLowerCase().contains('pool')) {
        return 'assets/image/swimming_pool.png';
      } else if (widget.owner.name.toLowerCase().contains('gym') || widget.owner.name.toLowerCase().contains('fitness')) {
        return 'assets/image/gym.png';
      } else if (widget.owner.name.toLowerCase().contains('community') || widget.owner.name.toLowerCase().contains('hall')) {
        return 'assets/image/community_hall.png';
      } else if (widget.owner.name.toLowerCase().contains('play') || widget.owner.name.toLowerCase().contains('children')) {
        return 'assets/image/play_area.png';
      } else if (widget.owner.name.toLowerCase().contains('garden') || widget.owner.name.toLowerCase().contains('park')) {
        return 'assets/image/garden.png';
      } else if (widget.owner.name.toLowerCase().contains('parking')) {
        return 'assets/image/parking.png';
      } else if (widget.owner.name.toLowerCase().contains('security') || widget.owner.name.toLowerCase().contains('guard')) {
        return 'assets/image/security.png';
      } else if (widget.owner.name.toLowerCase().contains('elevator') || widget.owner.name.toLowerCase().contains('lift')) {
        return 'assets/image/elevator.png';
      } else if (widget.owner.name.toLowerCase().contains('water') || widget.owner.name.toLowerCase().contains('tank')) {
        return 'assets/image/water_tank.png';
      } else {
        return 'assets/image/wifi.png';
      } 
    } else {
      return 'assets/image/profile.png'; 
    }
  }

  IconData _getProfileIcon() {
    if (widget.owner.isGuard) {
      return Icons.person_rounded; 
    } else if (widget.owner.isVendor) {
      return Icons.home_repair_service_sharp;
    } else if (widget.owner.isFlat) {
      return Icons.home_rounded; // Fallback icon for flats
    } else if (widget.owner.isTower) {
      if (widget.owner.name.contains('Wing')) {
        return Icons.meeting_room_rounded;
      }
      return Icons.domain_rounded;
    } else if (widget.owner.isAmenity) {
      if (widget.owner.name.toLowerCase().contains('swimming') || widget.owner.name.toLowerCase().contains('pool')) {
        return Icons.pool_rounded;
      } else if (widget.owner.name.toLowerCase().contains('gym') || widget.owner.name.toLowerCase().contains('fitness')) {
        return Icons.fitness_center_rounded;
      } else if (widget.owner.name.toLowerCase().contains('community') || widget.owner.name.toLowerCase().contains('hall')) {
        return Icons.meeting_room_rounded;
      } else if (widget.owner.name.toLowerCase().contains('play') || widget.owner.name.toLowerCase().contains('children')) {
        return Icons.toys_rounded;
      } else if (widget.owner.name.toLowerCase().contains('garden') || widget.owner.name.toLowerCase().contains('park')) {
        return Icons.park_rounded;
      } else if (widget.owner.name.toLowerCase().contains('parking')) {
        return Icons.local_parking_rounded;
      } else if (widget.owner.name.toLowerCase().contains('security') || widget.owner.name.toLowerCase().contains('guard')) {
        return Icons.security_rounded;
      } else if (widget.owner.name.toLowerCase().contains('elevator') || widget.owner.name.toLowerCase().contains('lift')) {
        return Icons.elevator_rounded;
      } else if (widget.owner.name.toLowerCase().contains('water') || widget.owner.name.toLowerCase().contains('tank')) {
        return Icons.water_drop_rounded;
      } else {
        return Icons.wifi_rounded;
      }
    } else {
      return Icons.person_rounded;
    }
  }

  IconData _getAmenityCategoryIcon(String? category) {
    if (category == null) return Icons.category_rounded;
    
    switch (category.toLowerCase()) {
      case 'fitness':
        return Icons.fitness_center_rounded;
      case 'recreation':
        return Icons.home_repair_service;
      case 'swimming':
        return Icons.pool_rounded;
      case 'events':
        return Icons.event_rounded;
      case 'playing':
        return Icons.sports_soccer_rounded;
      case 'sports':
        return Icons.sports_basketball_rounded;
      case 'security':
        return Icons.security_rounded;
      case 'parking':
        return Icons.local_parking_rounded;
      case 'garden':
        return Icons.nature_rounded;
      case 'community':
        return Icons.groups_rounded;
      case 'maintenance':
        return Icons.build_rounded;
      case 'wellness':
        return Icons.spa_rounded;
      case 'entertainment':
        return Icons.movie_rounded;
      case 'education':
        return Icons.school_rounded;
      default:
        return Icons.category_rounded;
    }
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                            ),
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
                    child: Card(
                      elevation: 2,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 0.6,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: widget.owner.isAmenity 
                                    ? _getSpecificAmenityColor()
                                    : (widget.owner.name.contains('Wing') || widget.owner.isTower || widget.owner.isFlat)
                                        ? Color(0xFFE4F0FF)
                                        : AppColors.purple100,
                                borderRadius: BorderRadius.circular(15),
                                // border: Border.all(
                                //   color: AppColors.purple200,
                                //   width: 1,
                                // ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: widget.owner.isAmenity
                                ? Center(
                                    child: Text(
                                      _getAmenityEmoji(),
                                      style: const TextStyle(
                                        fontSize: 28,
                                      ),
                                    ),
                                  )
                                : (widget.owner.name.contains('Wing') || widget.owner.isTower)
                                ? Center(
                                    child: Text(
                                      _getWingTowerEmoji(),
                                      style: const TextStyle(
                                        fontSize: 28,
                                      ),
                                    ),
                                  )
                                : widget.owner.isFlat
                                ? Center(
                                    child: Text(
                                      (widget.owner.floor != null && widget.owner.name.toLowerCase().contains('floor')) 
                                          ? _getFloorEmoji() 
                                          : _getFlatEmoji(),
                                      style: const TextStyle(
                                        fontSize: 28,
                                      ),
                                    ),
                                  )
                                : widget.owner.isVendor
                                ? Center(
                                    child: Text(
                                      '🔧',
                                      style: const TextStyle(
                                        fontSize: 28,
                                      ),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.asset(
                                      _getProfileImage(),
                                      width: 24,
                                      height: 24,
                                      fit: BoxFit.cover,
                                      color: AppColors.blue700,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(
                                          _getProfileIcon(),
                                          color: AppColors.purple700,
                                          size: 24,
                                        );
                                      },
                                    ),
                                  ),
                              ),
                            ),
                            const SizedBox(width: 14),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.owner.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.textDark,
                                            letterSpacing: -0.3,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      if (widget.showStatus && !widget.owner.isGuard && !widget.owner.isVendor && !widget.owner.isFlat && !widget.owner.isTower && !widget.owner.isAmenity)
                                        Container(
                                          width: 65,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: widget.owner.isActive
                                                ? AppColors.green400.withOpacity(0.08)
                                                : AppColors.orange600.withOpacity(0.08),
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              color: widget.owner.isActive
                                                  ? AppColors.green400.withOpacity(0.35)
                                                  : AppColors.orange600.withOpacity(0.35),
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [

                                              Container(
                                                width: 6,
                                                height: 6,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: widget.owner.isActive
                                                      ? AppColors.green600
                                                      : AppColors.orange800,
                                                ),
                                              ),

                                              const SizedBox(width: 6),

                                              Text(
                                                widget.owner.isActive ? 'Active' : 'Inactive',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  color: widget.owner.isActive
                                                      ? AppColors.green700
                                                      : AppColors.orange700,
                                                  letterSpacing: 0.3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      else if (widget.owner.isGuard)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            _getShiftType(widget.owner.shift ?? ''),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        )
                                      else if (widget.owner.isVendor)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            'Vendor',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.green,
                                            ),
                                          ),
                                        )
                                      else if (widget.owner.isFlat && widget.owner.occupancyInfo != null && widget.owner.occupancyInfo!.isNotEmpty)
                                        Container()
                                      else if (widget.owner.isFlat)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: widget.owner.isVacant ? AppColors.errorRed.withOpacity(0.1) : AppColors.successGreen.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            widget.owner.isVacant ? 'Vacant' : 'Occupied',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              color: widget.owner.isVacant ? AppColors.errorRed : AppColors.successGreen,
                                            ),
                                          ),
                                        )
                                      else if (widget.owner.isTower)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: widget.owner.isActive ? AppColors.successGreen.withOpacity(0.1) : AppColors.warningOrange.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            widget.owner.isActive ? 'Active' : 'Inactive',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              color: widget.owner.isActive ? AppColors.successGreen : AppColors.warningOrange,
                                            ),
                                          ),
                                        )
                                      else if (widget.owner.isAmenity)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: _getAmenityStatusColor(widget.owner.status).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            _getAmenityStatusText(widget.owner.status),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              color: _getAmenityStatusColor(widget.owner.status),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                  const SizedBox(height: 5),

                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (!widget.owner.isFlat && !widget.owner.isAmenity)
                                      widget.owner.isGuard 
                                          ? Text(
                                              '☀️',
                                              style: TextStyle(fontSize: 14),
                                            )
                                          : widget.owner.isVendor
                                              ? Text(
                                                  _getServiceEmoji(widget.owner.services ?? ''),
                                                  style: TextStyle(fontSize: 14),
                                                )
                                              : widget.owner.isTower
                                                  ? Text(
                                                      '🏢',
                                                      style: TextStyle(fontSize: 14),
                                                    )
                                                  : widget.owner.isFlat
                                                      ? Text(
                                                          (widget.owner.floor != null && widget.owner.name.toLowerCase().contains('floor')) 
                                                              ? '🏗️'
                                                              : '🏠',

                                                          style: TextStyle(fontSize: 14),
                                                        )
                                                      :
                                                        Text("🏠"),
                                      // const SizedBox(width: 4),
                                      if (widget.owner.isFlat)
                                        Row(
                                          children: [
                                            if (widget.owner.tower != null && widget.owner.tower!.isNotEmpty)
                                            Row(
                                              children: [
                                                Text(
                                                  '🏢',
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  '${widget.owner.tower} • ',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors.grey800,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 0.2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '🏛️',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              ' ${widget.owner.wing}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.grey800,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.2,
                                              ),
                                            ),
                                            if (widget.owner.floor != null && widget.owner.floor!.isNotEmpty)
                                            Row(
                                              children: [
                                                const Text(' • '),
                                                Text(
                                                  '🏗️',
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  widget.owner.floor!,

                                                  style: TextStyle(

                                                    fontSize: 12,
                                                    color: AppColors.grey800,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 0.2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      else
                                        if (widget.owner.isTower)
                                          Row(
                                            children: [
                                              SizedBox(width: 6,),
                                              Text(
                                                '${widget.owner.towerCode ?? ''} • ',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.grey800,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.2,
                                                ),
                                              ),
                                              Text(
                                                  '🏛️',
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              const SizedBox(width: 4),
                                              Text(
                                                ' ${widget.owner.wings ?? 0} Wings',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.grey800,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.2,
                                                ),
                                              ),
                                            ],
                                          )
                                        else
                                          if (widget.owner.isAmenity && widget.owner.category != null && widget.owner.category!.isNotEmpty)
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // Icon(
                                                //   _getAmenityCategoryIcon(widget.owner.category),
                                                //   size: 14,
                                                //   color: AppColors.primaryColor,
                                                // ),
                                                // const SizedBox(width: 6),
                                                Text(
                                                  widget.owner.category!,
                                                  style: TextStyle(
                                                    fontSize: 12.5,
                                                    color: AppColors.grey800,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 0.2,
                                                  ),
                                                ),
                                              ],
                                            )
                                          else
                                            Text(
                                              widget.owner.isGuard 
                                                  ? (widget.owner.shift ?? '')
                                                  : widget.owner.isVendor
                                                      ? (widget.owner.services ?? '')
                                                      : widget.owner.isAmenity
                                                          ? (widget.owner.category ?? '')
                                                          : widget.owner.flat,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.grey800,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.2,
                                              ),
                                            ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),

                                  if (widget.owner.isFlat)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (!widget.owner.flat.contains('🏠') && !widget.owner.flat.contains('🏗️'))
                                          Text(
                                            '🏠',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        if (!widget.owner.flat.contains('🏠') && !widget.owner.flat.contains('🏗️'))
                                          const SizedBox(width: 6),
                                        Text(
                                          widget.owner.flat,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.grey800,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                      ],
                                    ),

                                  if (widget.owner.isFlat && widget.owner.isOccupied && widget.owner.ownerName != null && widget.owner.ownerName!.isNotEmpty)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("👤"),
                                        const SizedBox(width: 6),
                                        Text(
                                          widget.owner.ownerName!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.grey800,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                      ],
                                    ),

                                  if (widget.owner.isFlat && widget.owner.isVacant)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            'assets/image/Group.svg',
                                            width: 14,
                                            height: 14,
                                            color: AppColors.textMid,
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.person_off_rounded,
                                                size: 14,
                                                color: AppColors.textMid,
                                              );
                                            },
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'No owner assigned',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.grey600,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.italic,
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  if (widget.owner.isFlat && (widget.owner.isOccupied && widget.owner.ownerName != null && widget.owner.ownerName!.isNotEmpty) || widget.owner.isVacant)
                                    const SizedBox(height: 5),

                                  if (widget.owner.isAmenity && widget.owner.location != null && widget.owner.location!.isNotEmpty)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("📍"),
                                        const SizedBox(width: 6),
                                        Text(
                                          widget.owner.location!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.grey800,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                      ],
                                    ),

                                  if (widget.owner.isAmenity && widget.owner.location != null && widget.owner.location!.isNotEmpty)
                                    const SizedBox(height: 5),

                                  if (widget.owner.isAmenity && widget.owner.timing != null && widget.owner.timing!.isNotEmpty)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("🕐"),
                                        const SizedBox(width: 6),
                                        Text(
                                          widget.owner.timing!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.grey800,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                      ],
                                    ),

                                  if (widget.owner.isAmenity && widget.owner.timing != null && widget.owner.timing!.isNotEmpty)
                                    const SizedBox(height: 5),

                                  if (widget.owner.phone.isNotEmpty)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          'assets/image/complaints.svg',
                                          width: 14,
                                          height: 14,
                                          color: AppColors.textMid,
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.phone_rounded,
                                              size: 14,
                                              color: AppColors.textMid,
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          widget.owner.phone,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.grey800,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                      ],
                                    ),

                                  if (widget.owner.isFlat && widget.owner.occupancyInfo != null && widget.owner.occupancyInfo!.isNotEmpty)
                                    const SizedBox(height: 5),

                                  if (widget.owner.isFlat && widget.owner.occupancyInfo != null && widget.owner.occupancyInfo!.isNotEmpty)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: _getOccupancyColor(widget.owner.occupancyInfo!).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(
                                              color: _getOccupancyColor(widget.owner.occupancyInfo!).withOpacity(0.3),
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            _getOccupancyText(widget.owner.occupancyInfo!),
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              color: _getOccupancyColor(widget.owner.occupancyInfo!),
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
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
}

