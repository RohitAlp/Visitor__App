import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../config/Routes/RouteName.dart';
import '../Notice/notice.dart';
import '../payment/payment.dart';
import '../profile/profile.dart';
import '../services/services.dart';

void main() => runApp(const MaterialApp(home: DashboardScreen()));

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<NavItemData> _navItems = [
    //  NavItemData(assetIcon: 'assets/image/home-01.svg', activeAssetIcon: 'assets/image/home-01.svg', label: 'Home'),
    NavItemData(icon: Icons.home_outlined,   activeIcon: Icons.home, label: 'Home'),
    NavItemData(icon: Icons.currency_rupee,   activeIcon: Icons.currency_rupee, label: 'Payment'),
    NavItemData(icon: Icons.volume_up_outlined, activeIcon: Icons.volume_up,    label: 'Notice'),
    NavItemData(icon: Icons.people_outline,   activeIcon: Icons.people,         label: 'Services'),
    NavItemData(icon: Icons.person_outline,   activeIcon: Icons.person,         label: 'Profile'),
  ];

  late final List<Widget> _pages = <Widget>[
    const _DashboardHomePage(),
    const Payment(),
    const Notice(),
    const Services(),
    const Profile(),
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
          barColor: const Color(0xFFC5610F),
          bubbleColor: const Color(0xFFC5610F),
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
      backgroundColor: const Color(0xFFFDF8F5),
      body: Stack(
        children: [

          // Positioned(
          //   top: -100,
          //   left: 0,
          //   right: 0,
          //   child: ClipRRect(
          //     borderRadius: const BorderRadius.vertical(bottom: Radius.circular(150)),
          //     child: Container(
          //       height: 200,
          //       decoration: BoxDecoration(
          //         gradient: LinearGradient(
          //           begin: Alignment.topLeft,
          //           end: Alignment.bottomRight,
          //           colors: [
          //             const Color(0xFFF7EEE7),
          //             const Color(0xFFF4EAE0),
          //           ],
          //         ),
          //       ),
          //       child: Stack(
          //         clipBehavior: Clip.none,
          //         children: [
          //           Positioned(
          //             top: -260,
          //             right: -170,
          //             child: Container(
          //               width: 520,
          //               height: 520,
          //               decoration: BoxDecoration(
          //                 shape: BoxShape.circle,
          //                 gradient: RadialGradient(
          //                   colors: [
          //                     const Color(0xFFE9D5C7).withValues(alpha: 0.55),
          //                     const Color(0xFFE9D5C7).withValues(alpha: 0.2),
          //                     Colors.transparent,
          //                   ],
          //                   stops: const [0.0, 0.55, 1.0],
          //                   center: Alignment.center,
          //                   radius: 0.85,
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Positioned(
          //             top: -170,
          //             left: -140,
          //             child: Container(
          //               width: 360,
          //               height: 360,
          //               decoration: BoxDecoration(
          //                 shape: BoxShape.circle,
          //                 gradient: RadialGradient(
          //                   colors: [
          //                     const Color(0xFFF1E3D7).withValues(alpha: 0.65),
          //                     const Color(0xFFF1E3D7).withValues(alpha: 0.2),
          //                     Colors.transparent,
          //                   ],
          //                   stops: const [0.0, 0.6, 1.0],
          //                   center: Alignment.center,
          //                   radius: 0.9,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildHeader(context),
                  const SizedBox(height: 25),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildQuickActionsGrid(),
                          const SizedBox(height: 10),
                          _buildMaintenanceCard(),
                          const SizedBox(height: 15),
                          _buildRecentActivity(),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Image.asset(
          'assets/image/Applogo.png',
          height: 40,
          //fit: BoxFit.contain,
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text("Hi, Runal", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Text("Wing A - Flat 912", style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            const SizedBox(width: 10),
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.notificationScreen);
                  },
                  customBorder: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: SvgPicture.asset('assets/image/Header.svg'),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _buildQuickActionsGrid() {
    final List<Map<String, dynamic>> items = [
      {'icon': 'assets/image/Vector.svg', 'label': 'Visitors'},
      {'icon': 'assets/image/Notice.svg', 'label': 'Notices'},
      {'icon': 'assets/image/complaints.svg', 'label': 'Complaints'},
      {'icon': 'assets/image/Group.svg', 'label': 'Amenities'},
      {'icon': 'assets/image/deliveries.svg', 'label': 'Deliveries'},
      {'icon': 'assets/image/Documents.svg', 'label': 'Documents'},
    ];

    return GridView.builder(

      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 20,
        childAspectRatio: 100 / 107, // Matches your frame dimensions
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Container(
          color: Colors.white,
          width: 100,
          height: 107,
          child: Stack(
            children: <Widget>[
              // Background Card
              Positioned(
                top: 0,
                left: 0,
                right: 0, // Fill width
                bottom: 0, // Fill height
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
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

              // Circular Shadow/Background behind Icon
              Positioned(
                top: 10,
                left: 22,
                child: Container(
                  width: 55.8,
                  height: 55.0,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(138, 149, 158, 0.25),
                        offset: Offset(0, 10),
                        blurRadius: 40,
                      )
                    ],
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // Label Text
              Positioned(
                top: 75, // Slightly adjusted for better centering
                left: 0,
                right: 0,
                child: Text(
                  item['label'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Mulish',
                    fontSize: 13, // Scaled down slightly to fit 3-column grid
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),

              // Icon Container
              Positioned(
                top: 15,
                left: 30,
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    item['icon'],
                    width: 24, // Control SVG size here
                    height: 24,
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5F6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Maintenance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(border: Border.all(color: Colors.red), borderRadius: BorderRadius.circular(8)),
                child: const Text("Due", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("₹ 25,500", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFFC5610F))),
              const Text("Due By 5th March 2026", style: TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            // width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2F2F),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
              ),
              child: const Text("Pay Now", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Recent Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFC5610F))),
          const SizedBox(height: 15),
          _activityItem(Icons.check_circle_outline, "Complaint #245 Resolved", "2 hours ago", Colors.orange),
          const Divider(),
          _activityItem(Icons.card_giftcard, "Parcel Received at Gate", "Today, 11:30 AM", Colors.orange),
          const Divider(),
          _activityItem(Icons.calendar_today, "Event: Society Meeting", "Sunday 22 Feb, 10:30 AM", Colors.orange),
        ],
      ),
    );
  }

  Widget _activityItem(IconData icon, String title, String time, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 15),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500))),
          Text(time, style: const TextStyle(color: Colors.black87, fontSize: 12)),
        ],
      ),
    );
  }
}
