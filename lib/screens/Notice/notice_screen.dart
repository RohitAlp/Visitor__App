import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../widgets/swipenoticecard.dart';
import 'add_notice_screen.dart';

class Notice {
  final String title;
  final String date;
  final String timeAgo;
  final String description;

  Notice({
    required this.title,
    required this.date,
    required this.timeAgo,
    required this.description,
  });
}

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final List<Notice> notices = [
    Notice(
      title: "Society Meeting - March 2026",
      date: "Mar 1, 2026",
      timeAgo: "6 days ago",
      description:
      "Annual general meeting scheduled for all residents to discuss upcoming maintenance plans and budget allocation for the year.",
    ),
    Notice(
      title: "Water Supply Maintenance",
      date: "Feb 28, 2026",
      timeAgo: "7 days ago",
      description:
      "Water supply will be temporarily disrupted on March 6th from 10 AM to 2 PM for maintenance work on overhead tanks.",
    ),
    Notice(
      title: "Holi Celebration Event",
      date: "Feb 25, 2026",
      timeAgo: "1 week ago",
      description:
      "Join us for Holi celebrations in the community hall on March 14th. All residents are welcome with their families.",
    ),
    Notice(
      title: "New Security Guidelines",
      date: "Feb 20, 2026",
      timeAgo: "2 weeks ago",
      description:
      "Updated security protocols have been implemented. All visitors must register at the gate with valid ID proof before entry.",
    ),
  ];
  void _deleteNotice(int index) {
    final notice = filteredNotices[index];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Delete Notice',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${notice.title}"?',
          style: const TextStyle(color: AppColors.textMid),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textLight),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              setState(() {
                notices.remove(notice);
              });

              Navigator.pop(ctx);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Notice deleted'),
                  backgroundColor: AppColors.primaryColor,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
  List<Notice> get filteredNotices {
    if (_searchQuery.isEmpty) return notices;

    return notices.where((notice) {
      return notice.title
          .toLowerCase()
          .contains(_searchQuery.toLowerCase()) ||
          notice.description
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
    }).toList();
  }

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

                    /// TITLE + COUNT
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Notices',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "${filteredNotices.length} Notices",
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),

                    const Spacer(),

                    /// ADD BUTTON
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddNoticeScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.primaryLight,
                              AppColors.primaryColor
                            ],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
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
          children: [

            /// SEARCH BAR
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Search notices by title or description",
                    hintStyle: TextStyle(fontSize: 12),
                    prefixIcon: Icon(Icons.search_rounded,
                        color: AppColors.primaryColor),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
            ),

            /// NOTICE LIST
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredNotices.length,
                itemBuilder: (context, index) {
                  final notice = filteredNotices[index];

                  return  SwipeNoticeCard(
                    onDelete: () => _deleteNotice(index),
                    onEdit: () {},

                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
                      ),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.amber.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/image/megaphone.png"),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  notice.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Row(
                                  children: [
                                    Icon(Icons.calendar_today_outlined,
                                        size: 11,
                                        color: Colors.grey.shade600),
                                    const SizedBox(width: 5),
                                    Text(
                                      "${notice.date} • ${notice.timeAgo}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  notice.description,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}