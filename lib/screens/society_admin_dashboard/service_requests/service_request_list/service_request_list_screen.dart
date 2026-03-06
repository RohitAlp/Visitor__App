import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/utils.dart';
import '../add_service_request/add_service_request_screen.dart';
import '../request_details/request_details_screen.dart';

class ServiceRequestListScreen extends StatefulWidget {
  const ServiceRequestListScreen({super.key});

  @override
  State<ServiceRequestListScreen> createState() =>
      _ServiceRequestListScreenState();
}

class _ServiceRequestListScreenState extends State<ServiceRequestListScreen>
    with TickerProviderStateMixin {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _services = ['All', 'Pending', 'Assigned', 'Completed'];

  String _selectedService = 'All';
  bool _showFilters = false;

  /// Status Color
  Color getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.red;
      case "Assigned":
        return AppColors.appPrimaryColor;
      case "Completed":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  /// Requests List
  final List<ServiceRequest> requests = [
    ServiceRequest(
      id: "1",
      name: "Rajesh Kumar",
      issue: "Water Leakage",
      wing: "A",
      floor: "4",
      flat: "103",
      status: "Pending",
      date: DateTime(2026, 2, 3),
    ),
    ServiceRequest(
      id: "2",
      name: "Amit Sharma",
      issue: "Electrical Issue",
      wing: "B",
      floor: "2",
      flat: "204",
      status: "Assigned",
      date: DateTime(2026, 2, 5),
    ),
    ServiceRequest(
      id: "3",
      name: "Neha Singh",
      issue: "Paint Work Required",
      wing: "C",
      floor: "6",
      flat: "601",
      status: "Completed",
      date: DateTime(2026, 2, 1),
    ),
    ServiceRequest(
      id: "4",
      name: "Rohit Mehta",
      issue: "Door Lock Required",
      wing: "A",
      floor: "1",
      flat: "101",
      status: "Pending",
      date: DateTime(2026, 2, 6),
    ),
    ServiceRequest(
      id: "5",
      name: "Priya Verma",
      issue: "AC Not Working",
      wing: "D",
      floor: "5",
      flat: "504",
      status: "Assigned",
      date: DateTime(2026, 2, 7),
    ),
    ServiceRequest(
      id: "6",
      name: "Karan Patel",
      issue: "Bathroom Tap Issue",
      wing: "B",
      floor: "3",
      flat: "303",
      status: "Completed",
      date: DateTime(2026, 2, 2),
    ),
    ServiceRequest(
      id: "8",
      name: "Sneha Gupta",
      issue: "Light Switch Broken",
      wing: "C",
      floor: "7",
      flat: "702",
      status: "Pending",
      date: DateTime(2026, 2, 8),
    ),
  ];

  /// Dynamic Count
  Map<String, int> get _serviceCounts {
    Map<String, int> counts = {
      'All': requests.length,
      'Pending': 0,
      'Assigned': 0,
      'Completed': 0,
    };

    for (var req in requests) {
      if (counts.containsKey(req.status)) {
        counts[req.status] = counts[req.status]! + 1;
      }
    }

    return counts;
  }

  @override
  Widget build(BuildContext context) {
    /// Filtered List
    final filteredRequests = requests.where((req) {
      final matchesSearch =
          req.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          req.issue.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesStatus =
          _selectedService == 'All' || req.status == _selectedService;

      return matchesSearch && matchesStatus;
    }).toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          titleSpacing: 0,
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(12),

                        // Soft Grey Border
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.15),
                          width: 1,
                        ),

                        // Light Shadow
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back_ios_rounded, size: 16),
                    ),

                    const SizedBox(width: 12),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Service Request',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "${requests.length} Requests",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddServiceRequestScreen(),
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
                              AppColors.primaryColor,
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

              const Divider(thickness: 1, height: 1, color: Color(0xFFE5E5E5)),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      /// SEARCH BAR
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: (val) {
                              setState(() => _searchQuery = val);
                            },
                            decoration: InputDecoration(
                              hintText: "Search request...",
                              hintStyle: TextStyle(fontSize: 14),
                              prefixIcon: const Icon(
                                Icons.search_rounded,
                                color: AppColors.primaryColor,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(12),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      /// FILTER BUTTON
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showFilters = !_showFilters;
                          });
                        },
                        child: Container(
                          width: 45,
                          height: 45,
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
                          child: const Icon(Icons.filter_alt),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// FILTER CHIPS
                  if (_showFilters)
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _services.length,
                        itemBuilder: (context, index) {
                          final service = _services[index];
                          final isSelected = _selectedService == service;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedService = service;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : Colors.grey.shade300,
                                ),
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    service,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  /// COUNT
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.white.withOpacity(.3)
                                          : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      (_serviceCounts[service] ?? 0).toString(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),

            /// LIST
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredRequests.length,
                itemBuilder: (context, index) {
                  final request = filteredRequests[index];

                  return ServiceRequestCard(
                    request: request,
                    index: index,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequestDetailsScreen(
                            request: request,
                          ),
                        ),
                      );
                    },
                    onDelete: () {
                      _showDeleteDialog(request, filteredRequests);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show Delete Dialog
  void _showDeleteDialog(ServiceRequest request, List<ServiceRequest> filteredRequests) async {
    final bool? confirmed = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Delete Service Request',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        content: Text(
          'Are you sure you want to delete request "${request.issue}"?',
          style: const TextStyle(color: AppColors.textMid),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textLight)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        requests.removeWhere((r) => r.id == request.id);
      });
      Utils.showToast(context, message: 'Request deleted');
    }
  }
}

/// SERVICE REQUEST CARD WIDGET
class ServiceRequestCard extends StatefulWidget {
  final ServiceRequest request;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final int index;

  const ServiceRequestCard({
    super.key,
    required this.request,
    required this.onTap,
    required this.onDelete,
    required this.index,
  });

  @override
  State<ServiceRequestCard> createState() => _ServiceRequestCardState();
}

class _ServiceRequestCardState extends State<ServiceRequestCard>
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

  Color getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.red;
      case "Assigned":
        return AppColors.appPrimaryColor;
      case "Completed":
        return Colors.green;
      default:
        return Colors.grey;
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
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 20,
                                );
                              },
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isRevealed = false;
                            });
                            widget.onTap();
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
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 18,
                                );
                              },
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
                  widget.onTap();
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
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(
                                Icons.build_outlined,
                                size: 24,
                                color: Colors.grey,
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
                                          widget.request.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.textDark,
                                            letterSpacing: -0.3,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: getStatusColor(widget.request.status).withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          widget.request.status,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: getStatusColor(widget.request.status),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    widget.request.issue,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.grey800,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "🏛️",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Wing ${widget.request.wing} • Floor ${widget.request.floor} • Flat ${widget.request.flat}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.grey800,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    DateFormat('MMM dd, yyyy').format(widget.request.date),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
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

/// MODEL
class ServiceRequest {
  final String id; // ✅ unique id
  final String name;
  final String issue;
  final String wing;
  final String floor;
  final String flat;
  final String status;
  final DateTime date;

  ServiceRequest({
    required this.id, // ✅ pass unique id
    required this.name,
    required this.issue,
    required this.wing,
    required this.floor,
    required this.flat,
    required this.status,
    required this.date,
  });
}
