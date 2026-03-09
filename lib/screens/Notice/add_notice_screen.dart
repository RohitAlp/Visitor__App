import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class AddNoticeScreen extends StatefulWidget {
  const AddNoticeScreen({super.key});

  @override
  State<AddNoticeScreen> createState() => _AddNoticeScreenState();
}

class _AddNoticeScreenState extends State<AddNoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 80,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [

                /// BACK BUTTON
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_back_ios_rounded, size: 16),
                ),

                const SizedBox(width: 12),
                     Text(
                      'Notices',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w800),
                    ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          const Divider(
            thickness: 1,
            height: 1,
            color: Color(0xFFE5E5E5),
          ),
        ],
      ),
    ),

    body: Column(
    children: [],
    ),),);
  }
}
