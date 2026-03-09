import 'dart:async';

import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../model/LoginResponse.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../Notice/notice_screen.dart';
import '../payment/payment.dart';
import '../services/services.dart';
import '../society_admin_dashboard/service_requests/service_request_list/service_request_list_screen.dart';

class DeveloperAdminDashboardScreen extends StatefulWidget {
  const DeveloperAdminDashboardScreen({super.key});

  @override
  State<DeveloperAdminDashboardScreen> createState() => _DeveloperAdminDashboardScreenState();
}

class _DeveloperAdminDashboardScreenState extends State<DeveloperAdminDashboardScreen> {
  int _selectedIndex = 0;

  final List<NavItemData> _navItems = [
    NavItemData(icon: Icons.home_outlined,    activeIcon: Icons.home,           label: 'Home'),
    NavItemData(icon: Icons.currency_rupee,   activeIcon: Icons.currency_rupee, label: 'Payment'),
    NavItemData(icon: Icons.volume_up_outlined, activeIcon: Icons.volume_up,    label: 'Notice'),
    NavItemData(icon: Icons.people_outline,   activeIcon: Icons.people,         label: 'Services'),
    NavItemData(icon: Icons.person_outline,   activeIcon: Icons.person,         label: 'Profile'),
  ];

  LoginResponse? loginResponse;
  late final List<Widget> _pages = <Widget>[
    _DashboardHomePage(),
    Payment(),
    NoticeScreen(),
    Services(),
    // Profile(),
    ServiceRequestListScreen(),
    // const ManageUsersScreen(type: 2,),
    //
    // const ManageUsersScreen(type: 1,),

  ];


  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: CustomAnimatedNavBar(
          items: _navItems,
          selectedIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }
}


class _DashboardHomePage extends StatelessWidget {
  const _DashboardHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appPrimaryColor,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: _buildHeader(),
                ),

                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFFDF8F5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          _buildMaintenanceCard(),
                          const SizedBox(height: 5),
                          _buildQuickActionsGrid(),
                          const SizedBox(height: 5),
                          _buildNoticeSlider(),
                          const SizedBox(height: 15),
                          _buildRecentActivity(),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Profile photo + greeting
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white24,
              // child: const Icon(Icons.person, color: Colors.white, size: 28),

              backgroundImage: AssetImage('assets/image/user-profile-pic.jpg'),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Hi, Admin",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Super Admin",
                  style: TextStyle(fontSize: 13, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),

        // Notification bell
        Stack(
          children: [
            const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 35,
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: const Center(
                  child: Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Widget _buildQuickActionsGrid() {
  //   final List<Map<String, dynamic>> items = [
  //     {'emoji': '👥', 'label': 'Visitors',   'bg': const Color(0xFFFFF3E0)},
  //     {'emoji': '🏢', 'label': 'Complaints', 'bg': const Color(0xFFFFEBEE)},
  //     {'emoji': '🎧', 'label': 'Notice',     'bg': const Color(0xFFFFF8E1)},
  //     {'emoji': '🏊', 'label': 'Deliveries', 'bg': const Color(0xFFE8F5E9)},
  //     {'emoji': '📢', 'label': 'Amenities',  'bg': const Color(0xFFE3F2FD)},
  //     {'emoji': '⚙️', 'label': 'Documents',  'bg': const Color(0xFFF3E5F5)},
  //   ];
  //
  //   return GridView.builder(
  //     shrinkWrap: true,
  //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
  //     physics: const NeverScrollableScrollPhysics(),
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 3,
  //       crossAxisSpacing: 15,
  //       mainAxisSpacing: 15,
  //       childAspectRatio: 100 / 107,
  //     ),
  //     itemCount: items.length,
  //     itemBuilder: (context, index) {
  //       final item = items[index];
  //
  //       return Container(
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(15),
  //           boxShadow: const [
  //             BoxShadow(
  //               color: Color.fromRGBO(110, 136, 157, 0.20),
  //               offset: Offset(0, 4),
  //               blurRadius: 20,
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             // Colored circular background with emoji
  //             Container(
  //               width: 52,
  //               height: 52,
  //               decoration: BoxDecoration(
  //                 color: item['bg'],
  //                 shape: BoxShape.circle,
  //               ),
  //               alignment: Alignment.center,
  //               child: Text(
  //                 item['emoji'],
  //                 style: const TextStyle(fontSize: 30),
  //               ),
  //             ),
  //
  //             const SizedBox(height: 10),
  //
  //             // Label
  //             Text(
  //               item['label'],
  //               textAlign: TextAlign.center,
  //               style: const TextStyle(
  //                 color: Colors.black87,
  //                 fontFamily: 'Mulish',
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  Widget _buildQuickActionsGrid() {
    final List<Map<String, dynamic>> items = [
      {'icon': 'assets/image/building.png', 'label': 'Society Creation'},
      {'icon': 'assets/image/icons8-google-groups-96.png', 'label': 'Manage User'},
      {'icon': 'assets/image/icons8-building-96.png', 'label': 'Manage Property'},
      {'icon': 'assets/image/report.png', 'label': 'MIS & Report'},
      {'icon': 'assets/image/megaphone.png', 'label': 'Notice'},
      {'icon': 'assets/image/icons8-settings-96.png', 'label': 'More'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1, // Square tiles usually look cleaner for 3x3 grids
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(110, 136, 157, 0.15),
                offset: Offset(0, 4),
                blurRadius: 12,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centering vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Centering horizontally
            children: [
              Image.asset(
                item['icon'],
                width: 35,
                height: 35,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10), // Space between image and text
              Text(
                item['label'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Mulish',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMaintenanceCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.MaintenanceCardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.18),
            blurRadius: 16,
            offset: const Offset(0, 8),
            spreadRadius: 3,
          ),
          BoxShadow(
            color: Colors.brown.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            // Darker OVAL — TOP-RIGHT corner
            Positioned(
              top: -25,
              right: -25,
              child: Container(
                width: 150,
                height: 90,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8A070).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),

            // Faint OVAL — BOTTOM-LEFT corner
            Positioned(
              bottom: -50,
              left: -60,
              child: Container(
                width: 300,
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5D5B8),
                  borderRadius: BorderRadius.all(Radius.elliptical(300, 220)),
                ),
              ),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Maintenance Billing",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B2D0E),
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "₹ 3,30,000",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6B2D0E),
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Total for March 2026",
                    style: TextStyle(
                      color: Color(0xFF9E8880),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shadowColor: const Color(0xFF4CAF50).withOpacity(0.4),
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shadowColor: const Color(0xFFFF5722).withOpacity(0.4),
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.10),
            blurRadius: 14,
            offset: const Offset(0, 6),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2D2D2D),
            ),
          ),
          const SizedBox(height: 6),
          _activityItem(
            iconWidget: Image.asset(
                "assets/image/tick-box.png"),
            title: "Complaint #245 Resolved",
            time: "2 hours ago",
          ),
          _buildDivider(),
          _activityItem(
            iconWidget: Image.asset(
                "assets/image/Parcel-img.png"),
            title: "Parcel Received at Gate",
            time: "Today, 11:30 AM",
          ),
          _buildDivider(),
          _activityItem(
            iconWidget: Image.asset(
                "assets/image/calendar-.png"),
            title: "Event: Society Meeting",
            time: "Sunday 22 Feb, 10:30 AM",
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.withOpacity(0.18),
      thickness: 1,
      height: 1,
    );
  }

  Widget _activityItem({
    required Widget iconWidget,
    required String title,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,

            child: Center(child: iconWidget),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xEC2D2D2D),
              ),
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFFBF5B1E),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildNoticeSlider() {
    final PageController pageController = PageController();
    final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

    final List<Map<String, String>> notices = [
      {
        'tag': '📢 Notice',
        'image': 'https://images.unsplash.com/photo-1517048676732-d65bc937f952?w=800',
        'title': 'New Security Guidelines',
        'description': 'Updated security protocols have been implemented for all residents.',
        'date': 'Feb 20',
      },
      {
        'tag': '📢 Notice',
        'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=800',
        'title': 'Maintenance Scheduled',
        'description': 'Water supply will be suspended on March 10th from 9 AM to 1 PM.',
        'date': 'Mar 5',
      },
      {
        'tag': '📢 Notice',
        'image': 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800',
        'title': 'Society Annual Meeting',
        'description': 'All residents are invited to attend the annual general meeting in the clubhouse.',
        'date': 'Mar 12',
      },
      {
        'tag': '📢 Notice',
        'image': 'https://images.unsplash.com/photo-1486325212027-8081e485255e?w=800',
        'title': 'Parking Rules Updated',
        'description': 'New parking allocation rules are effective from April 1st for all wings.',
        'date': 'Mar 18',
      },
    ];

    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!pageController.hasClients) {
        timer.cancel();
        return;
      }
      final next = ((currentIndex.value + 1) % notices.length);
      pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 16 / 13,
          child: PageView.builder(
            controller: pageController,
            itemCount: notices.length,
            onPageChanged: (index) => currentIndex.value = index,
            itemBuilder: (context, index) {
              final notice = notices[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(
                              notice['image']!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: const Color(0xFFF0E8DF),
                                child: const Center(
                                  child: Icon(Icons.image_outlined, size: 40, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                notice['tag']!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF6B2D0E),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notice['title']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1A1A),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Expanded(
                              child: Text(
                                notice['description']!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF757575),
                                  height: 1.5,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today_outlined,
                                        size: 14, color: Color(0xFF9E9E9E)),
                                    const SizedBox(width: 6),
                                    Text(
                                      notice['date']!,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF9E9E9E),
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(
                                  'Read more →',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFBF5B1E),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<int>(
          valueListenable: currentIndex,
          builder: (context, value, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                notices.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: value == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: value == index
                        ? const Color(0xFFBF5B1E)
                        : const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
