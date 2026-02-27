import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:visitorapp/constants/app_colors.dart';
import 'package:visitorapp/screens/society_admin/Manage%20User/security_guards/edit_guards_details_form/bloc/editguards_bloc.dart';
import 'package:visitorapp/widgets/custom_app_bar.dart';

import '../../../../../utils/enum.dart';
import '../../../../../widgets/text_form_field.dart';

class EditSecurityGuardsForm extends StatefulWidget {
  const EditSecurityGuardsForm({super.key});

  @override
  State<EditSecurityGuardsForm> createState() => _EditSecurityGuardsFormState();
}

class _EditSecurityGuardsFormState extends State<EditSecurityGuardsForm> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Edit Guards Details'),

      body: BlocListener<EditguardsBloc, EditguardsState>(
        listenWhen: (previous, current) =>
        previous.status != current.status,
        listener: (context, state) {

          if (state.status == Status.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Guard updated successfully'),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.pop(context);
          }

          if (state.status == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Something went wrong'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },

        child: SafeArea(
          child: Container(
            color: const Color(0xFFF5F5F5),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          'Guard Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildLabel("Guard Name"),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Enter Name",
                          onChanged: (v) {
                            context.read<EditguardsBloc>()
                                .add(EditGuardNameEvent(v));
                          },
                        ),

                        const SizedBox(height: 16),

                        _buildLabel("Guard ID"),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Enter ID",
                          onChanged: (v) {
                            context.read<EditguardsBloc>()
                                .add(EditGuardIDEvent(v));
                          },
                        ),

                        const SizedBox(height: 16),

                        _buildLabel("Guard Mobile Number"),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Enter Mobile Number",
                          keyboardType: TextInputType.phone,
                          onChanged: (v) {
                            context.read<EditguardsBloc>()
                                .add(EditGuardMobileNumberEvent(v));
                          },
                        ),

                        const SizedBox(height: 16),

                        _buildLabel("Guard Email ID", isRequired: false),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Enter Email",
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (v) {},
                        ),

                        const SizedBox(height: 16),

                        _buildLabel("Guard Address"),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Enter Address",
                          maxLines: 2,
                          onChanged: (v) {},
                        ),

                        const SizedBox(height: 16),

                        BlocBuilder<EditguardsBloc, EditguardsState>(
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Upload Document",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: _pickImage,
                                  child: Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        style: BorderStyle.solid,
                                      ),
                                      color: Colors.grey.shade50,
                                    ),
                                    child: state.guardPhotoBase64 != null
                                        ? _buildDocumentPreview(state.guardPhotoBase64!)
                                        : _buildUploadPlaceholder(),
                                  ),
                                ),
                              ],
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
      BlocBuilder<EditguardsBloc, EditguardsState>(
        builder: (context, state) {
          return SafeArea(
            child: Container(
              color: const Color(0xFFF5F5F5),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: SizedBox(
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCC6A00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: state.status == Status.loading
                      ? null
                      : () {
                    if (_formKey.currentState!.validate()) {
                      context.read<EditguardsBloc>().add(
                        const UpdateGuardDetailsEvent(),
                      );
                    }
                  },
                  child: state.status == Status.loading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text(
                    'Update Security Guard',
                    style: TextStyle(
                      color: Colors.white,
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

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _captureImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: const Text('Choose PDF'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickPDF();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _captureImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);
        final bytes = await imageFile.readAsBytes();
        final base64String = base64Encode(bytes);

        final extension = pickedFile.path.split('.').last.toLowerCase();
        final formattedBase64 = 'data:image/$extension;base64,$base64String';

        context.read<EditguardsBloc>().add(EditGuardPhotoEvent(formattedBase64));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error capturing image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);
        final bytes = await imageFile.readAsBytes();
        final base64String = base64Encode(bytes);

        final extension = pickedFile.path.split('.').last.toLowerCase();
        final formattedBase64 = 'data:image/$extension;base64,$base64String';

        context.read<EditguardsBloc>().add(EditGuardPhotoEvent(formattedBase64));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        final File pdfFile = File(result.files.single.path!);
        final bytes = await pdfFile.readAsBytes();
        final base64String = base64Encode(bytes);
        final formattedBase64 = 'data:application/pdf;base64,$base64String';

        context.read<EditguardsBloc>().add(EditGuardPhotoEvent(formattedBase64));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF uploaded successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

}

Widget _buildDocumentPreview(String base64String){
  try {

    if (base64String.startsWith('data:application/pdf')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.picture_as_pdf,
                size: 40,
                color: Colors.red,
              ),
              const SizedBox(height: 8),
              Text(
                'PDF Document',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      );
    }
    else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(
          base64Decode(base64String.split(',').last),
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return _buildUploadPlaceholder();
          },
        ),
      );
    }
  } catch (e) {
    return _buildUploadPlaceholder();
  }
}

Widget _buildUploadPlaceholder() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(
        Icons.upload_file,
        size: 30,
        color: Colors.grey,
      ),
      const SizedBox(height: 8),
      const Text(
        "Tap to upload or drag and drop",
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      const SizedBox(height: 4),
      const Text(
        "PNG, JPG, PDF (max. 5MB)",
        style: TextStyle(
          fontSize: 11,
          color: Colors.grey,
        ),
      ),
    ],
  );
}

Widget _buildLabel(String text, {bool isRequired = true}) {
  return RichText(
    text: TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      children: isRequired
          ? const [
        TextSpan(
          text: " *",
          style: TextStyle(color: Colors.red),
        )
      ]
          : [],
    ),
  );
}
