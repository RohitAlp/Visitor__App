import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:visitorapp/constants/app_colors.dart';
import 'package:visitorapp/widgets/custom_app_bar.dart';

import '../../../../../utils/enum.dart';
import '../../../../../utils/Validations.dart';
import '../../../../../widgets/text_form_field.dart';
import '../../security_guards/edit_guards_details_form/bloc/editguards_bloc.dart';
import 'bloc/edit_vendor_bloc.dart';

class EditVendorsForm extends StatefulWidget {
  final bool isAddingVendor;
  
  const EditVendorsForm({super.key, this.isAddingVendor = true});

  @override
  State<EditVendorsForm> createState() => _EditVendorsFormState();
}

class _EditVendorsFormState extends State<EditVendorsForm> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  List<PlatformFile> uploadedFiles = [];
  File? selectedFile;
  String? fileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.isAddingVendor ? 'Add Vendor' : 'Edit Vendor Details'),

      body: BlocListener<EditVendorBloc, EditVendorState>(
        listenWhen: (previous, current) =>
        previous.status != current.status,
        listener: (context, state) {

          if (state.status == Status.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(widget.isAddingVendor ? 'Vendor added successfully' : 'Vendor updated successfully'),
                backgroundColor: AppColors.successGreen,
              ),
            );

            Navigator.pop(context);
          }

          if (state.status == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Something went wrong'),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },

        child: SafeArea(
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

                        Text(
                          widget.isAddingVendor ? 'Vendor Information' : 'Edit Vendor Information',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildLabel("Vendor Name"),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Enter Name",
                          validator: AppValidators.validateName,
                          onChanged: (v) {
                            context.read<EditVendorBloc>()
                                .add(VenderNameEvent(v));
                          },
                        ),

                        const SizedBox(height: 16),

                        _buildLabel("Vendor ID"),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Enter ID",
                          validator: AppValidators.validateVendorId,
                          onChanged: (v) {
                            context.read<EditVendorBloc>()
                                .add(VenderIdEvent(v));
                          },
                        ),

                        const SizedBox(height: 16),

                        _buildLabel("Vendor Mobile Number"),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Enter Mobile Number",
                          keyboardType: TextInputType.phone,
                          validator: AppValidators.validateMobile,
                          onChanged: (v) {
                            context.read<EditVendorBloc>()
                                .add(VenderMobileNumberEvent(v));
                          },
                        ),

                        const SizedBox(height: 16),

                        _buildLabel("Vendor Email ID", isRequired: false),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Enter Email",
                          keyboardType: TextInputType.emailAddress,
                          validator: AppValidators.validateOptionalEmail,
                          onChanged: (v) {
                            context.read<EditVendorBloc>()
                                .add(VenderEmailEvent(v));
                          },
                        ),

                        const SizedBox(height: 16),

                        _buildLabel("Vendor Address"),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Enter Address",
                          maxLines: 2,
                          validator: AppValidators.validateAddress,
                          onChanged: (v) {
                            context.read<EditVendorBloc>()
                                .add(VenderAddressEvent(v));
                          },
                        ),

                        const SizedBox(height: 16),

                        BlocBuilder<EditVendorBloc, EditVendorState>(
                          builder: (context, state) {
                            return Container(
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
                                    onTap: pickFile,
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
                                                  "${file.name} (${(file.size / 1024).toStringAsFixed(1)} KB)",
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
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar:
      BlocBuilder<EditVendorBloc, EditVendorState>(
        builder: (context, state) {
          return SafeArea(
            child: Container(
              color: AppColors.scaffoldBg,
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
                  onPressed: state.status == Status.loading
                      ? null
                      : () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isAddingVendor) {
                        context.read<EditVendorBloc>().add(
                          const AddVendorEvent(),
                        );
                      } else {
                        context.read<EditVendorBloc>().add(
                          const UpdateVendorDetailsEvent(),
                        );
                      }
                    }
                  },
                  child: state.status == Status.loading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : Text(
                        widget.isAddingVendor ? 'Add Vendor' : 'Update Vendor',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'mp4'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        uploadedFiles.addAll(result.files);
      });
    }
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
          text: " *",
          style: TextStyle(color: AppColors.errorRed),
        )
      ]
          : [],
    ),
  );
}
