import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_bar.dart';
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
    const Services(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
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
    return const Center(
      child: Text(
        'Home',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
    );
  }
}