import 'package:flutter/material.dart';
import 'package:visitorapp/widgets/custom_app_bar.dart';

class ManageUsersScreen extends StatefulWidget {
  final int type;

  const ManageUsersScreen({super.key,required this.type});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "Manage Users", showBackButton: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back),
                ),
                SizedBox(width: 8),
                if(widget.type == 1)
                  Text(
                    "Manage Users",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                else
                  Text(
                    "Manage Property",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
              ],
            ),
          ),

          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(12),
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
              children: widget.type == 1
                  ? const [
                _UserCard(
                  icon: Icons.people_outline,
                  title: "Flat Owners\n(Residents)",
                ),
                _UserCard(
                  icon: Icons.shield_outlined,
                  title: "Security Guards",
                ),
                _UserCard(
                  icon: Icons.work_outline,
                  title: "Support Staff",
                ),
                _UserCard(
                  icon: Icons.build_outlined,
                  title: "Vendors",
                ),
              ]
                  : const [
                _UserCard(
                  icon: Icons.build_outlined,
                  title: "Manage Wings",
                ),
                _UserCard(
                  icon: Icons.build_outlined,
                  title: "Manage Floors",
                ),
                _UserCard(
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

  const _UserCard({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
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
              child: Icon(icon, color: Colors.deepOrange, size: 26),
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
    );
  }
}
