import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visitorapp/screens/Notice/notice_model.dart';

import '../../constants/app_colors.dart';
import '../../constants/utils.dart';

class EditNoticeScreen extends StatefulWidget {
  final Notice notice;

  const EditNoticeScreen({super.key, required this.notice});

  @override
  State<EditNoticeScreen> createState() => _EditNoticeScreenState();
}

class _EditNoticeScreenState extends State<EditNoticeScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController noticeTitleController;
  late final TextEditingController noticeDescriptionController;
  final FocusNode noticeTitleFocus = FocusNode();
  final FocusNode noticeDescriptionFocus = FocusNode();
  File? selectedFile;
  final ImagePicker picker = ImagePicker();
  String? fileName;
  List<PlatformFile> uploadedFiles = [];
  Future<void> pickFile() async {
    if (uploadedFiles.length >= 5) {
      Utils.showToast(context, message: "You can upload maximum 5 images");
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'mp4'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        int remainingSlots = 5 - uploadedFiles.length;
        uploadedFiles.addAll(result.files.take(remainingSlots));
      });
    }
  }
  @override
  void initState() {
    super.initState();
    noticeTitleController = TextEditingController(text: widget.notice.title);
    noticeDescriptionController = TextEditingController(text: widget.notice.description);

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
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.cardBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.15),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Edit Notice',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              const Divider(thickness: 1, height: 1, color: Color(0xFFE5E5E5)),
            ],
          ),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Notice Title",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              " *",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        TextFormField(
                          controller: noticeTitleController,
                          focusNode: noticeTitleFocus,
                          style: const TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            hintText: "e.g., Society Meeting, Water Supply Maintenance",
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: const [
                            Text(
                              "Notice Description",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              " *",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: noticeDescriptionController,
                          focusNode: noticeDescriptionFocus,
                          style: const TextStyle(fontSize: 12),
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: "Enter the details of the notice here...",
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        // Inside build → after TextFormField for description
                        Align(
                          alignment: Alignment.centerRight,
                          child: ValueListenableBuilder<TextEditingValue>(
                            valueListenable: noticeDescriptionController,
                            builder: (context, value, child) {
                              return Text(
                                "${value.text.length}/500 characters",
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                        Text(
                          "Images (Optional)",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Upload up to 5 images (JPG, PNG, WEBP - max 5MB each)",
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(height: 10),
                        /// Upload Box
                        GestureDetector(
                          onTap: pickFile, // function to pick multiple files
                          child: DottedBorder(
                            dashPattern: const [6, 4],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(12),
                            color: AppColors.primaryColor,
                            strokeWidth: 1.5,
                            child: Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/image/upload.png',
                                    width: 28,
                                    height: 28,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Tap to upload images",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "5 slots remaining",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        /// Show uploaded files
                        if (uploadedFiles.isNotEmpty)
                          Column(
                            children: uploadedFiles.map((file) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.primaryColor.withOpacity(0.4),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/image/upload.png',
                                      width: 20,
                                      height: 20,
                                      color: AppColors.primaryColor,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "${file.name} (${(file.size / 1024).toStringAsFixed(1)} KB)", // show size in KB
                                        style: const TextStyle(fontSize: 13),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          uploadedFiles.remove(file);
                                        });
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: AppColors.primaryColor,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {    Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {

                            if (noticeTitleController.text.trim().isEmpty) {
                              Utils.showToast(context, message: "Please add notice title");
                              return;
                            }

                            if (noticeDescriptionController.text.trim().isEmpty) {
                              Utils.showToast(context, message: "Please add notice description");
                              return;
                            }

                            if (noticeDescriptionController.text.length > 500) {
                              Utils.showToast(context, message: "Description cannot exceed 500 characters");
                              return;
                            }
                            // SUCCESS
                            Utils.showToast(context, message: "Notice Published Successfully");
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Update Notice",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
