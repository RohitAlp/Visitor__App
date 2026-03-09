import 'package:flutter/material.dart';
import 'package:visitorapp/constants/app_colors.dart';
import 'package:visitorapp/widgets/custom_app_bar.dart';

import '../../config/Routes/RouteName.dart';

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
                  ? [
                _UserCard(
                  // icon: Icons.people_outline,
                  text: '👤',
                  title: "Flat Owners\n(Residents)",
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.FlatOwnersScreen);
                  },
                ),
                 _UserCard(
                  // icon: Icons.shield_outlined,
                   text: '🛡️',
                  title: "Security Guards",
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.SecurityGuardsScreen);
                  },
                ),
                const _UserCard(
                  // icon: Icons.work_outline,
                  text: '👔',
                  title: "Support Staff",
                ),
                 _UserCard(
                  // icon: Icons.build_outlined,
                   text: '🔧',
                  title: "Vendors",
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.VendorsScreens);
                  },
                ),
              ]
                  :  [
                _UserCard(
                  // icon: Icons.build_outlined,
                  text: '🏢',
                  title: "Manage Tower",
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.ManageTowersScreen);
                  },
                ),
                _UserCard(
                  // icon: Icons.build_outlined,
                  text: '🏛️',
                  title: "Manage Wings",
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.ManageWingScreen);
                  },
                ),
                _UserCard(
                  // icon: Icons.build_outlined,
                  text: '🏗️',
                  title: "Manage Floors",
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.ManageFloorsScreen);
                  },
                ),
                _UserCard(
                  // icon: Icons.build_outlined,
                  text: '🏠',
                  title: "Manage Flats",
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.ManageFlatsScreen);
                  },
                ),
                _UserCard(
                  // icon: Icons.build_outlined,
                  text: '🌴',
                  title: "Manage Amenities",
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.ManageAmanitiesScreen);
                  },
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
  final IconData? icon;
  final String? text;
  final String title;
  final VoidCallback? onTap;

  const _UserCard({
     this.icon,
    this.text,
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
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x66000000),
                blurRadius: 3,
                spreadRadius: 0,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                // decoration: BoxDecoration(
                //   color: const Color(0xffFBE9E0),
                //   borderRadius: BorderRadius.circular(12),
                // ),
                child: text != null
                    ? (text!.startsWith('👤') || text!.startsWith('🛡️') || text!.startsWith('👔') || text!.startsWith('🔧') || text!.startsWith('🏢') || text!.startsWith('🏛️') || text!.startsWith('🏗️') || text!.startsWith('🏠') || text!.startsWith('🌴'))
                        ? Text(
                            text!,
                            style: const TextStyle(
                              fontSize: 45,
                              color: Colors.deepOrange,
                            ),
                          )
                        : Image.asset(
                            text!,
                            width: 26,
                            height: 26,
                            color: Colors.deepOrange,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                icon,
                                color: Colors.deepOrange,
                                size: 26,
                              );
                            },
                          )
                    : Icon(
                        icon,
                        color: Colors.deepOrange,
                        size: 26,
                      ),
              ),
              // const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
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
