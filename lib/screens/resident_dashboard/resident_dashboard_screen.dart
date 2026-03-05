import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visitorapp/constants/app_colors.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../Notice/notice.dart';
import '../payment/payment.dart';
import '../profile/profile.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<NavItemData> _navItems = [
    NavItemData(icon: Icons.home_outlined,    activeIcon: Icons.home,           label: 'Home'),
    NavItemData(icon: Icons.currency_rupee,   activeIcon: Icons.currency_rupee, label: 'Payment'),
    NavItemData(icon: Icons.volume_up_outlined, activeIcon: Icons.volume_up,    label: 'Notice'),
    NavItemData(icon: Icons.people_outline,   activeIcon: Icons.people,         label: 'Services'),
    NavItemData(icon: Icons.person_outline,   activeIcon: Icons.person,         label: 'Profile'),
  ];

  late final List<Widget> _pages = <Widget>[
    const _DashboardHomePage(),
    const Payment(),
    const Notice(),
    const Profile(),
    // const Services(),
    const Profile(),
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

                const SizedBox(height: 20),
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
                  "Hi, Runal",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Wing A - Flat 912",
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

  Widget _buildQuickActionsGrid() {
    final List<Map<String, dynamic>> items = [
      {'icon': 'assets/image/visitor.svg',    'label': 'Visitors'},
      {'icon': 'assets/image/Notice.svg',     'label': 'Notices'},
      {'icon': 'assets/image/complaints.svg', 'label': 'Complaints', 'color': Colors.lightBlueAccent},
      {'icon': 'assets/image/Group.svg',      'label': 'Amenities',  'color': Colors.yellow[700]},
      {'icon': 'assets/image/deliveries.svg', 'label': 'Deliveries'},
      {'icon': 'assets/image/Documents.svg',  'label': 'Documents',  'color': Colors.orange},
    ];

    return GridView.builder(
      shrinkWrap: true,
     // padding: const EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 100 / 107,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return SizedBox(
          width: 100,
          height: 107,
          child: Stack(
            children: <Widget>[
              // Background Card
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow:   [
                      BoxShadow(
                        color: Color.fromRGBO(110, 136, 157, 0.25),
                        offset: Offset(0, 0),
                        blurRadius: 26,
                      )
                    ],
                    color: Colors.white,
                  ),
                ),
              ),

              // // Circular Shadow/Background behind Icon
              // Positioned(
              //   top: 10,create design for custom header widget
              // create design for custom bottom bar widget
              // Dashboard desing for the User (Resedent)
              //   left: 22,
              //   child: Container(
              //     width: 55.8,
              //     height: 55.0,
              //     decoration: const BoxDecoration(
              //       boxShadow: [
              //         BoxShadow(
              //           color: Color.fromRGBO(138, 149, 158, 0.25),
              //           offset: Offset(0, 10),
              //           blurRadius: 40,
              //         )
              //       ],
              //       color: Colors.white,
              //       shape: BoxShape.circle,
              //     ),
              //   ),
              // ),

              // Label Text
              Positioned(
                top: 75,
                left: 0,
                right: 0,
                child: Text(
                  item['label'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Mulish',
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),

              // Icon Container
              Positioned(
                top: 15,
                left: 35,
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    item['icon'],
                    width: 26,
                    height: 26,
                    colorFilter: item['color'] != null
                        ? ColorFilter.mode(
                      item['color'],
                      BlendMode.srcIn,
                    )
                        : null,
                  ),
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
        color: const Color(0xFFFEF0E6),
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
                  // Using a huge circular radius on a non-square container
                  // is the easiest way to ensure a perfect oval.
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
                  // Radius matches the container shape to force the oval
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
                    "Maintenance",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B2D0E),
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "₹ 25,500",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6B2D0E),
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Due By 5th March 2026",
                    style: TextStyle(
                      color: Color(0xFF9E8880),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.appPrimaryColor,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shadowColor: const Color(0xFFBF5B1E).withOpacity(0.4),
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        "Pay Now",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
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
        color: const Color(0xFFFDF4EC),
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
          _activityItem(iconWidget: const Icon(Icons.check_circle_outline_rounded, color: Color(0xFFBF5B1E), size: 16), title: "Complaint #245 Resolved",  time: "2 hours ago"),
          _buildDivider(),
          _activityItem(
            iconWidget: SvgPicture.asset(
              "assets/image/parcel-tracker.svg",
              width: 22,
              height: 22,
              fit: BoxFit.contain,
              color: const Color(0xFFBF5B1E),
            ),
            title: "Parcel Received at Gate",
            time: "Today, 11:30 AM",
          ),_buildDivider(),
          _activityItem(iconWidget: const Icon(Icons.calendar_month_outlined, color: Color(0xFFBF5B1E), size: 16),      title: "Event: Society Meeting",   time: "Sunday 22 Feb, 10:30 AM"),
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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFE8C9A8),
                width: 1,
              ),
            ),
            child: Center(child: iconWidget),
          ),
          const SizedBox(width: 8),
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