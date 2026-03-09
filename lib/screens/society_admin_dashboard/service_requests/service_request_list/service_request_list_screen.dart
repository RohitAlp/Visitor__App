import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/utils.dart';
import '../../../../widgets/swipenoticecard.dart';
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
  String getIssueImage(String issue) {
    switch (issue) {
      case "Water Leakage":
        return "assets/image/iconswaterdrop.png";

      case "Electrical Issue":
      case "Light Switch Broken":
        return "assets/image/lightning_bolt.png";

      case "Paint Work Required":
        return "assets/image/paint_palette.png";

      case "AC Not Working":
      case "Light Switch Broke":
        return "assets/image/setting.png";

      case "Door Lock Required":
        return "assets/image/hammer.png";
      default:
        return "assets/image/setting.png";
    }
  }
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
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.15),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 16,
                        ),
                      ),
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

                  return SwipeNoticeCard(
                    onDelete: () async {

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
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
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
                    },


                    child: GestureDetector(
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
                      child: requestCard(request),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// REQUEST CARD
  Widget requestCard(ServiceRequest request) {
    String formattedDate = DateFormat('MMM dd, yyyy').format(request.date);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT IMAGE BOX
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                getIssueImage(request.issue),
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// RIGHT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// NAME
                Text(
                  request.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                /// ISSUE
                Text(
                  request.issue,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                /// LOCATION
                Text(
                  "Wing ${request.wing} • Floor ${request.floor} • Flat ${request.flat}",
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),

                const SizedBox(height: 12),

                /// STATUS + DATE
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: getStatusColor(request.status).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        request.status,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: getStatusColor(request.status),
                        ),
                      ),
                    ),

                    const Spacer(),

                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
