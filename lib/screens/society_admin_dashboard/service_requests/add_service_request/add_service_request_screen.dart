import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/utils.dart';

class AddServiceRequestScreen extends StatefulWidget {
  const AddServiceRequestScreen({super.key});

  @override
  State<AddServiceRequestScreen> createState() =>
      _AddServiceRequestScreenState();
}

class _AddServiceRequestScreenState extends State<AddServiceRequestScreen> {
  // Inside your StatefulWidget
  final _formKey = GlobalKey<FormState>();
  List<PlatformFile> uploadedFiles = [];
  final TextEditingController descriptionController = TextEditingController();

  // Focus nodes
  final FocusNode towerFocus = FocusNode();
  final FocusNode wingFocus = FocusNode();
  final FocusNode categoryFocus = FocusNode();
  final FocusNode priorityFocus = FocusNode();
  final FocusNode descriptionFocus = FocusNode();
  File? selectedFile;
  final ImagePicker picker = ImagePicker();
  String? fileName;
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'mp4'],
      allowMultiple: true, // ✅ allow multiple files
    );

    if (result != null) {
      setState(() {
        uploadedFiles.addAll(result.files); // add new files to the list
      });
    }
  }
  String? selectedTower;
  String? selectedWing;
  String? selectedCategories;
  String? selectedPriority;
  List<String> houseServicePriority = ["High", "Low", "Medium"];

  List<String> houseServiceSubCategories = [
    "Pest Control",
    "Electrical",
    "Housekeeping",
    "Plumbing",
    "Carpentry",
    "Painting",
    "AC Service",
    "Appliance Repair",
    "Water Leakage",
    "Door Lock Repair",
    "Cleaning Service",
    "Other",
  ];
  List<String> towersList = [
    "Sunrise Tower ",
    "Sunset Tower ",
    "Skyline Tower ",
    "Garden Tower ",
    "Ocean View Tower ",
  ];

  List<String> wingsList = ["A", "B", "C", "D", "E"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          titleSpacing: 0,
          title: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        borderRadius: BorderRadius.circular(12),

                        // Soft Grey Border
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.15),
                          width: 1,
                        ),

                        // Light Shadow
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back_ios_rounded, size: 16),
                    ),

                    const SizedBox(width: 12),
                    Text(
                      'Add Service Request',
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
                        Text(
                          "Location Details",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Tower",
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
                        commonDropdownField(
                          hint: "Select Tower",
                          items: towersList,
                          value: selectedTower,
                          focusNode: towerFocus,
                          onChanged: (value) {
                            setState(() {
                              selectedTower = value;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "wing",
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
                        commonDropdownField(
                          hint: "Select Wing",
                          items: wingsList,
                          value: selectedWing,
                          focusNode: wingFocus,
                          onChanged: (value) {
                            setState(() {
                              selectedWing = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
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
                          children: [
                            Text(
                              "Request Category",
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
                        commonDropdownField(
                          hint: "Select Category",
                          items: houseServiceSubCategories,
                          value: selectedCategories,
                          focusNode: categoryFocus,
                          onChanged: (value) {
                            setState(() {
                              selectedCategories = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
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
                          children: [
                            Text(
                              "Priority",
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
                        commonDropdownField(
                          hint: "Select Priority",
                          items: houseServicePriority,
                          value: selectedPriority,
                          focusNode: priorityFocus,
                          onChanged: (value) {
                            setState(() {
                              selectedPriority = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
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
                              "Description",
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
                          controller: descriptionController,
                          focusNode: descriptionFocus,
                          maxLines: 5,
                          style: const TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            hintText: "Describe your request in detail...",
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
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
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
                        const Text(
                          "Upload Photo/Video (Optional)",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),

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
                                    "Click to upload files",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "Image or Video (Max 10MB)",
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
                  SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        disabledBackgroundColor: AppColors.primaryColor
                            .withOpacity(0.60),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        // Validate form
                        if (_formKey.currentState!.validate()) {
                          // Validate dropdowns manually
                          if (selectedTower == null) {
                            Utils.showToast(context, message: "Please select a Tower");
                            FocusScope.of(context).requestFocus(towerFocus);
                            return;
                          }
                          if (selectedWing == null) {
                            Utils.showToast(context, message: "Please select a Wing");
                            FocusScope.of(context).requestFocus(wingFocus);
                            return;
                          }
                          if (selectedCategories == null) {
                            Utils.showToast(context, message: "Please select a Category");
                            FocusScope.of(context).requestFocus(categoryFocus);
                            return;
                          }
                          if (selectedPriority == null) {
                            Utils.showToast(context, message: "Please select a Priority");
                            FocusScope.of(context).requestFocus(priorityFocus);
                            return;
                          }

                          Navigator.pop(context);
                        } else {
                          // Description field is invalid – focus on it
                          Utils.showToast(context, message: "Please enter a description");
                          FocusScope.of(context).requestFocus(descriptionFocus);
                        }
                      },
                      child: Text(
                        "Submit Request",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget commonDropdownField({
    required String hint,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
    FocusNode? focusNode, // ✅ Add this optional parameter
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      focusNode: focusNode, // ✅ Pass it here
      hint: Text(hint, style: const TextStyle(fontSize: 12)),
      isExpanded: true,
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(10),
      icon: const Icon(Icons.keyboard_arrow_down_rounded),

      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),

      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (value == item)
                const Icon(Icons.check, size: 18, color: Colors.green),
            ],
          ),
        );
      }).toList(),

      selectedItemBuilder: (context) {
        return items.map((item) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Text(
              item,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          );
        }).toList();
      },

      onChanged: onChanged,
    );
  }
}
