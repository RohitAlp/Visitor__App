import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_bar.dart';


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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Text(
            _navItems[_selectedIndex].label,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBar: CustomAnimatedNavBar(
          items: _navItems,
          selectedIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          barColor: const Color(0xFFB05A00),
          bubbleColor: const Color(0xFF8B4500),
        ),
      ),
    );
  }
}