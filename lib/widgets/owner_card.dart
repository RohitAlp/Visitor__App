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

  // Constructor for vendors
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

  // Constructor for flats
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

  // Constructor for amenities
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

  static const Color primaryColor = Color(0xFFC5610F);
  static const Color primaryLight = Color(0xFFE8832A);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1A1208);
  static const Color textMid = Color(0xFF6B5A47);
  static const Color textLight = Color(0xFF9C8872);

  bool _pressed = false;
  bool _isRevealed = false;

  Color get _wingColor {
    return primaryColor;
  }

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
        return const Color(0xFF10B981); // Emerald green
      case 'maintenance':
        return const Color(0xFF3B82F6); // Blue
      case 'closed':
        return const Color(0xFFEF4444); // Red
      default:
        return const Color(0xFF6B7280); // Gray
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
    // Extract numbers from format like "0/4 Occupied"
    final match = RegExp(r'(\d+)/(\d+)').firstMatch(occupancyInfo);
    if (match != null) {
      final occupied = int.tryParse(match.group(1) ?? '0') ?? 0;
      final total = int.tryParse(match.group(2) ?? '0') ?? 1;
      
      final percentage = ((occupied / total) * 100).round();
      return percentage == 0 ? const Color(0xFFEF4444) : const Color(0xFF10B981); // Red for vacant (0%), Green for occupied
    }
    return const Color(0xFF6B7280); // Gray default
  }

  String _getOccupancyText(String occupancyInfo) {
    // Extract numbers from format like "0/4 Occupied"
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

  Color _getOccupancyStatusColor(String occupancyInfo) {
    // Extract numbers from format like "0/4 Occupied"
    final match = RegExp(r'(\d+)/(\d+)').firstMatch(occupancyInfo);
    if (match != null) {
      final occupied = int.tryParse(match.group(1) ?? '0') ?? 0;
      final total = int.tryParse(match.group(2) ?? '0') ?? 1;
      
      final percentage = ((occupied / total) * 100).round();
      return percentage == 0 ? const Color(0xFFEF4444) : const Color(0xFF10B981); // Red for vacant (0%), Green for occupied
    }
    return const Color(0xFF6B7280); // Gray default
  }

  String _getOccupancyStatusText(String occupancyInfo) {
    // Extract numbers from format like "0/4 Occupied"
    final match = RegExp(r'(\d+)/(\d+)').firstMatch(occupancyInfo);
    if (match != null) {
      final occupied = int.tryParse(match.group(1) ?? '0') ?? 0;
      final total = int.tryParse(match.group(2) ?? '0') ?? 1;
      
      final percentage = ((occupied / total) * 100).round();
      
      if (percentage == 0) {
        return 'Vacant';
      } else {
        return 'Occupied';
      }
    }
    return 'Unknown'; // Fallback text
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
                        colors: [primaryLight, primaryColor],
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
                          vertical: 8,
                          horizontal: 8,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEDE7F6),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: const Color(0xFFD1C4E9),
                                  width: 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.asset(
                                  'assets/image/profile.png',
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.person_rounded,
                                      color: Color(0xFF512DA8),
                                      size: 24,
                                    );
                                  },
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
                                            color: textDark,
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
                                                ? const Color(0xFF4CAF50).withOpacity(0.08)   // softer green bg
                                                : const Color(0xFFFF9800).withOpacity(0.08),  // softer orange bg
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                              color: widget.owner.isActive
                                                  ? const Color(0xFF4CAF50).withOpacity(0.35)
                                                  : const Color(0xFFFF9800).withOpacity(0.35),
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
                                                      ? const Color(0xFF43A047)   // medium green
                                                      : const Color(0xFFFB8C00),  // medium orange
                                                ),
                                              ),

                                              const SizedBox(width: 6),

                                              /// Text
                                              Text(
                                                widget.owner.isActive ? 'Active' : 'Inactive',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  color: widget.owner.isActive
                                                      ? const Color(0xFF388E3C)   // balanced green
                                                      : const Color(0xFFF57C00),  // balanced orange
                                                  letterSpacing: 0.3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      else if (widget.owner.isGuard)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: primaryColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            _getShiftType(widget.owner.shift ?? ''),
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w800,
                                              color: primaryColor,
                                            ),
                                          ),
                                        )
                                      else if (widget.owner.isVendor)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            'Vendor',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.green,
                                            ),
                                          ),
                                        )
                                      else if (widget.owner.isFlat && widget.owner.occupancyInfo != null && widget.owner.occupancyInfo!.isNotEmpty)
                                        // Don't show status badge for flats when occupancy info is present
                                        Container()
                                      else if (widget.owner.isFlat)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: widget.owner.isVacant ? const Color(0xFFEF4444).withOpacity(0.1) : const Color(0xFF10B981).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            widget.owner.isVacant ? 'Vacant' : 'Occupied',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w800,
                                              color: widget.owner.isVacant ? const Color(0xFFEF4444) : const Color(0xFF10B981),
                                            ),
                                          ),
                                        )
                                      else if (widget.owner.isTower)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: widget.owner.isActive ? const Color(0xFF10B981).withOpacity(0.1) : const Color(0xFFF59E0B).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            widget.owner.isActive ? 'Active' : 'Inactive',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w800,
                                              color: widget.owner.isActive ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                                            ),
                                          ),
                                        )
                                      else if (widget.owner.isAmenity)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: _getAmenityStatusColor(widget.owner.status).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            _getAmenityStatusText(widget.owner.status),
                                            style: TextStyle(
                                              fontSize: 10,
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
                                      Icon(
                                        widget.owner.isGuard 
                                            ? Icons.schedule_rounded 
                                            : widget.owner.isVendor
                                                ? Icons.room_service_sharp
                                                : widget.owner.isFlat
                                                    ? Icons.meeting_room_rounded
                                                    : widget.owner.isTower
                                                        ? Icons.domain_rounded
                                                        : widget.owner.isAmenity
                                                            ? Icons.pool_rounded
                                                            : Icons.apartment_rounded,
                                        size: 14,
                                        color: textMid,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        widget.owner.isGuard 
                                            ? (widget.owner.shift ?? '')
                                            : widget.owner.isVendor
                                                ? (widget.owner.services ?? '')
                                                : widget.owner.isFlat
                                                    ? '${widget.owner.tower ?? ''} • ${widget.owner.wing} • ${widget.owner.floor ?? ''}'
                                                    : widget.owner.isTower
                                                        ? '${widget.owner.towerCode ?? ''} • ${widget.owner.wings ?? 0} Wings'
                                                        : widget.owner.isAmenity
                                                            ? (widget.owner.category ?? '')
                                                            : widget.owner.flat,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),

                                  // Show owner name for occupied flats
                                  if (widget.owner.isFlat && widget.owner.isOccupied && widget.owner.ownerName != null && widget.owner.ownerName!.isNotEmpty)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.person_rounded,
                                          size: 14,
                                          color: textMid,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          widget.owner.ownerName!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                      ],
                                    ),

                                  // Show "No owner assigned" for vacant flats
                                  if (widget.owner.isFlat && widget.owner.isVacant)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.person_off_rounded,
                                          size: 14,
                                          color: textMid,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'No owner assigned',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.italic,
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                      ],
                                    ),

                                  if (widget.owner.isFlat && (widget.owner.isOccupied && widget.owner.ownerName != null && widget.owner.ownerName!.isNotEmpty) || widget.owner.isVacant)
                                    const SizedBox(height: 5),

                                  if (widget.owner.isAmenity && widget.owner.location != null && widget.owner.location!.isNotEmpty)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.location_on_rounded,
                                          size: 14,
                                          color: textMid,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          widget.owner.location!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade800,
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
                                        Icon(
                                          Icons.access_time_rounded,
                                          size: 14,
                                          color: textMid,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          widget.owner.timing!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade800,
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
                                        Icon(
                                          Icons.phone_rounded,
                                          size: 14,
                                          color: textMid,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          widget.owner.phone,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade800,
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
                                        Icon(
                                          Icons.home_work_rounded,
                                          size: 14,
                                          color: textMid,
                                        ),
                                        const SizedBox(width: 6),
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

