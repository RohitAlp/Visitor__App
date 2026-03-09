import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_colors.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../Notice/notice_screen.dart';
import '../payment/payment.dart';
import '../profile/bloc/profile_bloc.dart';
import '../profile/profile.dart';
import '../../config/Routes/RouteName.dart';
import '../services/services.dart';

class SocietyAdminDashboardScreen extends StatefulWidget {
  const SocietyAdminDashboardScreen({super.key});

  @override
  State<SocietyAdminDashboardScreen> createState() => _SocietyAdminDashboardScreenState();
}

class _SocietyAdminDashboardScreenState extends State<SocietyAdminDashboardScreen> {
  int _selectedIndex = 0;

  final List<NavItemData> _navItems = [
    NavItemData(icon: Icons.home_outlined,      activeIcon: Icons.home,           label: 'Home'),
    NavItemData(icon: Icons.currency_rupee,     activeIcon: Icons.currency_rupee, label: 'Payment'),
    NavItemData(icon: Icons.volume_up_outlined, activeIcon: Icons.volume_up,      label: 'Notice'),
    NavItemData(icon: Icons.people_outline,     activeIcon: Icons.people,         label: 'Services'),
    NavItemData(icon: Icons.person_outline,     activeIcon: Icons.person,         label: 'Profile'),
  ];

  late final List<Widget> _pages = <Widget>[
    const _DashboardHomePage(),
    const Payment(),
    const NoticeScreen(),
    const Services(),   // index 3 → Services
    BlocProvider(
      create: (context) => ProfileBloc(),
      child: const Profile(),
    ),   // index 4 → Profile
  ];

  @override
  Widget build(BuildContext context) {
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


// ─── Dashboard Home ───────────────────────────────────────────────────────────

class _DashboardHomePage extends StatefulWidget {
  const _DashboardHomePage();

  @override
  State<_DashboardHomePage> createState() => _DashboardHomePageState();
}

class _DashboardHomePageState extends State<_DashboardHomePage> {

  late final PageController _pageController;
  late final ValueNotifier<int> _currentIndex;
  Timer? _timer;

  final List<Map<String, String>> _notices = [
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentIndex   = ValueNotifier<int>(0);

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted || !_pageController.hasClients) return;
      final next = (_currentIndex.value + 1) % _notices.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _currentIndex.dispose();
    super.dispose();
  }

  // ── Build ──────────────────────────────────────────────────────────────────

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
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFFDF8F5),
                      borderRadius: BorderRadius.only(
                        topLeft:  Radius.circular(36),
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
                          _buildQuickActionsGrid(context),
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

  // ── Header ─────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white24,
              backgroundImage: const AssetImage('assets/image/user-profile-pic.jpg'),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, Admin",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Society Manager",
                  style: TextStyle(fontSize: 13, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),

        // Notification bell
        Stack(
          children: [
            const Icon(Icons.notifications, color: Colors.white, size: 35),
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

  // ── Quick Actions Grid ─────────────────────────────────────────────────────

  Widget _buildQuickActionsGrid(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'icon': 'assets/image/icons8-google-groups-96.png', 'label': 'Manage User'},
      {'icon': 'assets/image/icons8-building-96.png',      'label': 'Manage Property'},
      {'icon': 'assets/image/icons8-headset-96.png',       'label': 'Service Request'},
      {'icon': 'assets/image/icons8-swimmer-96.png',       'label': 'Amenities'},
      {'icon': 'assets/image/megaphone.png',               'label': 'Notice'},
      {'icon': 'assets/image/icons8-settings-96.png',      'label': 'More'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1,
      ),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () {
            if (index == 0) {
              Navigator.pushNamed(context, RouteName.manageUsersSocietyAdmin, arguments: 1);
            } else if (index == 1) {
              Navigator.pushNamed(context, RouteName.manageUsersSocietyAdmin, arguments: 2);
            } else if (index == 2) {
              Navigator.pushNamed(context, RouteName.ServiceRequestListScreen);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(110, 136, 157, 0.15),
                  offset: Offset(0, 4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  item['icon'] as String,
                  width: 35,
                  height: 35,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 10),
                Text(
                  item['label'] as String,
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
          ),
        );
      },
    );
  }

  // ── Maintenance Card ───────────────────────────────────────────────────────

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
            // Darker oval — top-right
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

            // Faint oval — bottom-left
            Positioned(
              bottom: -50,
              left: -60,
              child: Container(
                width: 300,
                height: 220,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5D5B8),
                  borderRadius: BorderRadius.all(Radius.elliptical(300, 220)),
                ),
              ),
            ),

            // Content
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

  // ── Notice Slider ──────────────────────────────────────────────────────────

  Widget _buildNoticeSlider() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 16 / 13,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _notices.length,
            onPageChanged: (index) => _currentIndex.value = index,
            itemBuilder: (context, index) {
              final notice = _notices[index];
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
                                  child: Icon(Icons.image_outlined,
                                      size: 40, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
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
          valueListenable: _currentIndex,
          builder: (context, value, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _notices.length,
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

  // ── Recent Activity ────────────────────────────────────────────────────────

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
            iconWidget: Image.asset("assets/image/tick-box.png"),
            title: "Complaint #245 Resolved",
            time: "2 hours ago",
          ),
          _buildDivider(),
          _activityItem(
            iconWidget: Image.asset("assets/image/Parcel-img.png"),
            title: "Parcel Received at Gate",
            time: "Today, 11:30 AM",
          ),
          _buildDivider(),
          _activityItem(
            iconWidget: Image.asset("assets/image/calendar-.png"),
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
          SizedBox(width: 32, height: 32, child: Center(child: iconWidget)),
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
}