import 'dart:io';

import 'package:flutter/material.dart';
import 'package:visitorapp/constants/app_colors.dart';
import 'package:visitorapp/widgets/custom_app_bar.dart';
import 'package:visitorapp/widgets/text_form_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../../../widgets/custom_dropdown.dart';

class AddFlatOwnerForm extends StatefulWidget {
  final String? initialName;
  final String? initialMobile;
  final String? initialFlatNumber;

  const AddFlatOwnerForm({
    super.key,
    this.initialName,
    this.initialMobile,
    this.initialFlatNumber,
  });

  @override
  State<AddFlatOwnerForm> createState() => _AddFlatOwnerFormState();
}

class _AddFlatOwnerFormState extends State<AddFlatOwnerForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _flatNumberController = TextEditingController();

  final List<String> _towers = ['Sunset Towers', 'Green Meadows', 'Skyline Residency'];
  final List<String> _wings = ['A Wing', 'B Wing', 'C Wing', 'D Wing'];
  final List<String> _floors = List<String>.generate(20, (i) => '${i + 1}');
  final List<String> _vehicleTypes = ['Two Wheeler', 'Four Wheeler'];

  String? _selectedTower;
  String? _selectedWing;
  String? _selectedFloor;
  final List<_VehicleData> _vehicles = [_VehicleData()];

  // File upload variables
  List<PlatformFile> uploadedFiles = [];
  File? selectedFile;
  final ImagePicker picker = ImagePicker();
  String? fileName;

  @override
  void initState() {
    super.initState();
    if (widget.initialName != null) {
      _nameController.text = widget.initialName!;
    }
    if (widget.initialMobile != null) {
      _mobileController.text = widget.initialMobile!;
    }
    if (widget.initialFlatNumber != null) {
      _flatNumberController.text = widget.initialFlatNumber!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _flatNumberController.dispose();
    super.dispose();
  }

  // File picker function
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:   CustomAppBar(title: 'Add Flat Owner'),
        body: SafeArea(
          child: Container(
            color: AppColors.scaffoldBg,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Personal Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
      
                        _buildLabel('Owner Name'),
                        const SizedBox(height: 6),
                        CustomTextField(
                          controller: _nameController,
                          hintText: 'Enter full name',
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Required';
                            return null;
                          },
                          onChanged: (_) {},
                        ),
                        const SizedBox(height: 16),
                        _buildLabel('Mobile Number'),
                        const SizedBox(height: 6),
                        CustomTextField(
                          controller: _mobileController,
                          hintText: 'Enter mobile number',
                          keyboardType: TextInputType.phone,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Required';
                            final d = v.replaceAll(RegExp(r'\\D'), '');
                            if (d.length < 10) return 'Enter a valid number';
                            return null;
                          },
                          onChanged: (_) {},
                        ),
                        const SizedBox(height: 16),
                        _buildLabel('Email ID'),
                        const SizedBox(height: 6),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Enter email address',
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Required';
                            final emailRegex = RegExp(r'^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$');
                            if (!emailRegex.hasMatch(v.trim())) return 'Enter a valid email';
                            return null;
                          },
                          onChanged: (_) {},
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Flat Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Tower Name'),
                        const SizedBox(height: 6),
                      CustomDropdown(
                        value: _selectedTower,
                        items: _towers,
                        hintText: 'Select Tower',
                        onChanged: (v) => setState(() => _selectedTower = v),
                      ),
                        const SizedBox(height: 16),
                        _buildLabel('Wing'),
                        const SizedBox(height: 6),
                      CustomDropdown(
                        value: _selectedWing,
                        items: _wings,
                        hintText: 'Select Wing',
                        onChanged: (v) => setState(() => _selectedWing = v),
                      ),
                        const SizedBox(height: 16),
                        _buildLabel('Floor'),
                        const SizedBox(height: 6),
                      CustomDropdown(
                        value: _selectedFloor,
                        items: _floors,
                        hintText: 'Select Floor',
                        onChanged: (v) => setState(() => _selectedFloor = v),
                      ),
                        const SizedBox(height: 16),
                        _buildLabel('Flat Number'),
                        const SizedBox(height: 6),
                        CustomTextField(
                          controller: _flatNumberController,
                          hintText: 'Enter flat number',
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Required';
                            if (!RegExp(r'^\\d+[A-Za-z]?\$').hasMatch(v.trim())) return 'Enter a valid number';
                            return null;
                          },
                          onChanged: (_) {},
                        ),
                        const SizedBox(height: 24),
                        
                        // File Upload Section
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
                        const SizedBox(height: 24),
                        const Text(
                          'Parking',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(_vehicles.length, (index) => _buildVehicleBlock(index)),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _vehicles.add(_VehicleData());
                            });
                          },
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF7F0),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.loadingOrange),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.add, color: AppColors.loadingOrange),
                                SizedBox(width: 8),
                                Text(
                                  'Add Another Vehicle',
                                  style: TextStyle(
                                    color: AppColors.loadingOrange,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: const Color(0xFFF5F5F5),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: SizedBox(
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.loadingOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                final isValid = _formKey.currentState!.validate() && _validateVehicles();
                if (isValid) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Owner saved'),
                      backgroundColor: AppColors.successGreen,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Save Owner',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

 

  Widget _buildVehicleBlock(int index) {
    final data = _vehicles[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Vehicle ${index + 1}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (_vehicles.length > 1)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      data.dispose();
                      _vehicles.removeAt(index);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEFEF),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.deleteRed),
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.deleteRed,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          _buildLabel('Vehicle Type'),
          const SizedBox(height: 6),
          CustomDropdown(
            hintText: 'Vehicle Type',
            value: data.type,
            items: _vehicleTypes,
            onChanged: (v) => setState(() => data.type = v),
          ),
          const SizedBox(height: 12),
          _buildLabel('Vehicle Number'),
          const SizedBox(height: 6),
          CustomTextField(
            controller: data.numberController,
            hintText: 'e.g., MH-01-AB-1234',
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              return null;
            },
            onChanged: (_) {},
          ),
          const SizedBox(height: 12),
          _buildLabel('Parking Slot'),
          const SizedBox(height: 6),
          CustomTextField(
            controller: data.slotController,
            hintText: 'e.g., P-23',
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Required';
              return null;
            },
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }

  bool _validateVehicles() {
    for (final v in _vehicles) {
      final typeOk = v.type != null;
      final numOk = v.numberController.text.trim().isNotEmpty;
      final slotOk = v.slotController.text.trim().isNotEmpty;
      if (!(typeOk && numOk && slotOk)) return false;
    }
    return true;
  }
}

Widget _buildLabel(String text, {bool isRequired = true}) {
  return RichText(
    text: TextSpan(
      text: text,
      style: const TextStyle(
        color: AppColors.black,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      children: isRequired
          ? const [
              TextSpan(
                text: ' *',
                style: TextStyle(color: AppColors.errorRed),
              )
            ]
          : [],
    ),
  );
}

class _VehicleData {
  String? type;
  final TextEditingController numberController = TextEditingController();
  final TextEditingController slotController = TextEditingController();
  void dispose() {
    numberController.dispose();
    slotController.dispose();
  }
}
