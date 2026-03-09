import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../service_request_list/service_request_list_screen.dart';

class RequestDetailsScreen extends StatefulWidget {
  final ServiceRequest request;
  const RequestDetailsScreen({super.key, required this.request});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  String? selectedVendorDepartment;
  bool get isFormValid =>
      selectedVendorDepartment != null && selectedVendorName != null;
  List<String> vendorNames = [
    "GreenLeaf Cleaning Co.",
    "SparkleClean Services",
    "PureShine Housekeeping",
  ];

  String? selectedVendorName;
  final List<String> vendorsDepartment = [
    "Plumbing Services",
    "Electrical Services",
    "Carpentry Services",
    "Civil & Structural Services",
    "Appliance Repair Services",
    "Pest Control Services",
    "Housekeeping Services"
  ];
  Color getStatusBg(String status) {
    switch (status) {
      case "Pending":
        return Colors.amber.shade100;
      case "Assigned":
        return Colors.blue.shade100;
      case "Completed":
        return Colors.green.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Color getStatusText(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange.shade800;
      case "Assigned":
        return Colors.blue.shade800;
      case "Completed":
        return Colors.green.shade800;
      default:
        return Colors.grey.shade700;
    }
  }
  String formatDate(DateTime date) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return "${months[date.month - 1]} ${date.day}, ${date.year}";
  }

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
                      'Request Details',
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              requestInfoCard(widget.request),
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
                    Text(
                      "Request Description",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "There is a water leakage in the bathroom ceiling. Water is dripping continuously from the corner near the window. This has been happening for the past 2 days. Please send someone to fix this urgently.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
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
                          "Current Status",
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: getStatusBg(widget.request.status),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.request.status,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: getStatusText(widget.request.status),
                                ),
                              ),
                            ],
                          ),
                        )
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
                              "Vendor Department",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                        SizedBox(height: 5),
                        DropdownButtonFormField<String>(
                          value: selectedVendorDepartment,
                          hint: const Text(
                            "Select Department",
                            style: TextStyle(fontSize: 12),
                          ),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: Colors.grey.shade400),
                            ),
                          ),

                          /// DROPDOWN MENU ITEMS
                          items: vendorsDepartment.map((vendor) {
                            return DropdownMenuItem<String>(
                              value: vendor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    vendor,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                  ),

                                  if (selectedVendorDepartment == vendor)
                                    const Icon(Icons.check, size: 18, color: Colors.green),
                                ],
                              ),
                            );
                          }).toList(),

                          /// SELECTED FIELD VIEW (NO CHECK ICON)
                          selectedItemBuilder: (context) {
                            return vendorsDepartment.map((vendor) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  vendor,
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                              );
                            }).toList();
                          },

                          onChanged: (value) {
                            setState(() {
                              selectedVendorDepartment = value;
                              selectedVendorName = null;
                            });
                          },
                        )                      ],
                    ),
                  ),
              if (selectedVendorDepartment != null) ...[
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

                        /// TITLE
                        Row(
                          children: const [
                            Text(
                              "Vendor Name",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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

                        const SizedBox(height: 8),

                        /// DROPDOWN
                        DropdownButtonFormField<String>(
                          value: selectedVendorName,
                          hint: const Text(
                            "Select Vendor",
                            style: TextStyle(fontSize: 12),
                          ),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: Colors.grey.shade400),
                            ),
                          ),

                          /// DROPDOWN ITEMS
                          items: vendorNames.map((vendor) {
                            return DropdownMenuItem<String>(
                              value: vendor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    vendor,
                                    style: const TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.w600),
                                  ),

                                  if (selectedVendorName == vendor)
                                    const Icon(Icons.check, size: 18, color: Colors.green),
                                ],
                              ),
                            );
                          }).toList(),

                          /// SELECTED FIELD VIEW
                          selectedItemBuilder: (context) {
                            return vendorNames.map((vendor) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  vendor,
                                  style: const TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                              );
                            }).toList();
                          },

                          onChanged: (value) {
                            setState(() {
                              selectedVendorName = value;
                            });
                          },
                        ),
                      ],
                    ),
                  )
  ],
                  SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isFormValid
                          ? () {
                        print("Assign Vendor");
                      }
                          : null,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFormValid
                            ? AppColors.primaryColor
                            : AppColors.primaryColor.withOpacity(0.06),

                        disabledBackgroundColor: AppColors.primaryColor.withOpacity(0.60),

                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                      child: Text(
                        "Assign Vendor",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
            ]),
          ),
        ),
      ),
    );
  }

  Widget requestInfoCard(ServiceRequest request) {
    return Container(
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
          /// Title
          const Text(
            "Request Information",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 16),

          /// Request From
          const Text(
            "Request From",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            request.name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 16),

          /// Wing Floor Flat Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoColumn("Wing", request.wing),
              _infoColumn("Floor", request.floor),
              _infoColumn("Flat", request.flat),
            ],
          ),

          const SizedBox(height: 16),

          /// Complaint Category
          const Text(
            "Complaint Category",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            request.issue,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 16),

          /// Request Date
          const Text(
            "Request Date",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            formatDate(request.date),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _infoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
