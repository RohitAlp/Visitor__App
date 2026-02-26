import 'package:flutter/material.dart';
import 'package:visitorapp/widgets/custom_app_bar.dart';

import '../../../config/Routes/RouteName.dart';

class ManageUsersScreen extends StatelessWidget {
  const ManageUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "Manage Users",
        showBackButton: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              "Manage Users",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          /// Grid
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(12),
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
              children: [
                _UserCard(
                  icon: Icons.people_outline,
                  title: "Flat Owners\n(Residents)",
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.FlatOwnersScreen);
                  },
                ),
                const _UserCard(
                  icon: Icons.shield_outlined,
                  title: "Security Guards",
                ),
                const _UserCard(
                  icon: Icons.work_outline,
                  title: "Support Staff",
                ),
                const _UserCard(
                  icon: Icons.build_outlined,
                  title: "Vendors",
                ),
                const _UserCard(
                  icon: Icons.build_outlined,
                  title: "Manage Wings",
                ),
                const _UserCard(
                  icon: Icons.build_outlined,
                  title: "Manage Floors",
                ),
                const _UserCard(
                  icon: Icons.build_outlined,
                  title: "Manage Flats",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const _UserCard({
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 4,
                spreadRadius: 0,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xffFBE9E0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.deepOrange,
                  size: 26,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}