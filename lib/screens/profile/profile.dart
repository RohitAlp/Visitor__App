import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:visitorapp/screens/profile/bloc/profile_bloc.dart';
import 'package:visitorapp/widgets/text_form_field.dart';

import '../../constants/app_colors.dart';
import '../../utils/enum.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_date_picker.dart';
import '../../widgets/common_dialogue.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _profileImage;
  final _formKey = GlobalKey<FormState>();

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onTap:(){                        Navigator.pop(context);
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
                  ),

                  const SizedBox(width: 12),
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            const Divider(thickness: 1, height: 1, color: Color(0xFFE5E5E5)),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor.withOpacity(0.05),
                          AppColors.primaryColor.withOpacity(0.02),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      border: Border.all(
                        color: AppColors.primaryColor.withOpacity(0.15),
                        width: 1.5,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.primaryColor.withOpacity(
                                              0.1,
                                            ),
                                            Colors.transparent,
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                      ),
                                    ),

                                    // Profile image container
                                    Positioned(
                                      left: 20,
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.primaryColor
                                                .withOpacity(0.2),
                                            width: 2,
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          radius: 38,
                                          backgroundColor: Colors.grey.shade100,
                                          backgroundImage: _profileImage != null
                                              ? FileImage(_profileImage!)
                                              : null,
                                          child: _profileImage == null
                                              ? Icon(
                                                  Icons.person,
                                                  size: 32,
                                                  color: AppColors.primaryColor
                                                      .withOpacity(0.6),
                                                )
                                              : null,
                                        ),
                                      ),
                                    ),

                                    // Camera button with unique design
                                    Positioned(
                                      left: 75,
                                      bottom: 10,
                                      child: GestureDetector(
                                        onTap: pickImage,
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Text content on the right
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Profile Photo",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textDark,
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "Add a photo to personalize\nyour profile",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.textMid,
                                          height: 1.4,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: AppColors.primaryColor
                                                .withOpacity(0.3),
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.camera_alt_outlined,
                                              size: 14,
                                              color: AppColors.primaryColor,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              "Change Photo",
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.primaryColor,
                                                letterSpacing: 0.3,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  _buildSectionCard(
                    title: "Basic Information",
                    icon: Icons.person_outline,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("First Name"),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Enter Name",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                              return 'Name should contain only letters and spaces';
                            }
                            if (value.length < 2) {
                              return 'Name must be at least 2 characters';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            context.read<ProfileBloc>().add(FirstNameEvent(v));
                          },
                        ),

                        const SizedBox(height: 16),

                        _buildLabel("Last Name"),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Enter Name",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                              return 'Name should contain only letters and spaces';
                            }
                            if (value.length < 2) {
                              return 'Name must be at least 2 characters';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            context.read<ProfileBloc>().add(LastNameEvent(v));
                          },
                        ),

                        const SizedBox(height: 16),
                        _buildLabel("Date of Birth"),
                        const SizedBox(height: 6),

                        CustomDatePickerField(
                          hintText: "DD-MM-YYYY",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your date of birth';
                            }
                            try {
                              final parsedDate = DateFormat('dd-MM-yyyy').parse(value);
                              if (parsedDate.isAfter(DateTime.now())) {
                                return 'Date of birth cannot be in the future';
                              }
                              final age = DateTime.now().difference(parsedDate).inDays ~/ 365;
                              if (age < 18) {
                                return 'You must be at least 18 years old';
                              }
                              if (age > 120) {
                                return 'Please enter a valid date of birth';
                              }
                            } catch (e) {
                              return 'Please enter a valid date format (DD-MM-YYYY)';
                            }
                            return null;
                          },
                          onChanged: (date) {
                            try {
                              final parsedDate = DateFormat(
                                'dd-MM-yyyy',
                              ).parse(date);
                              context.read<ProfileBloc>().add(
                                DOBEvent(parsedDate),
                              );
                            } catch (e) {
                              // Handle parsing error if needed
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  _buildSectionCard(
                    title: "Contact Information",
                    icon: Icons.phone_outlined,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("Email Address"),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Enter Email",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email address';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            context.read<ProfileBloc>().add(EmailEvent(v));
                          },
                        ),

                        const SizedBox(height: 16),

                        _buildLabel("Phone Number"),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Enter Number",
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (!RegExp(r'^[0-9]{10}$').hasMatch(value.replaceAll(' ', '').replaceAll('-', ''))) {
                              return 'Please enter a valid 10-digit phone number';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            context.read<ProfileBloc>().add(PhoneNumberEvent(v));
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  _buildSectionCard(
                    title: "Address",
                    icon: Icons.home_outlined,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("Tower Name"),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Enter Tower Name",
                          readOnly: true,
                          onChanged: (v) {
                            context.read<ProfileBloc>().add(TowerEvent(v));
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel("Wing"),
                                  const SizedBox(height: 6),
                                  CustomTextField(
                                    hintText: "Wing",
                                    readOnly: true,
                                    onChanged: (v) {
                                      context.read<ProfileBloc>().add(
                                        WingEvent(v),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel("Floor Name"),
                                  const SizedBox(height: 6),
                                  CustomTextField(
                                    hintText: "Floor Name",
                                    readOnly: true,
                                    onChanged: (v) {
                                      context.read<ProfileBloc>().add(
                                        FloorEvent(v),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        _buildLabel("Society Name"),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Society Name",
                          readOnly: true,
                          onChanged: (v) {
                            context.read<ProfileBloc>().add(SocietyNameEvent(v));
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildLabel("Location"),
                        const SizedBox(height: 6),
                        CustomTextField(
                          hintText: "Location",
                          readOnly: true,
                          onChanged: (v) {
                            context.read<ProfileBloc>().add(LocationEvent(v));
                          },
                        ),

                        const SizedBox(height: 24),

                        // Action Buttons Row
                        Row(
                          children: [
                            // Expanded(
                            //   child: CustomButtonFactory.secondary(
                            //     text: 'Cancel',
                            //     onPressed: () {
                            //       Navigator.pop(context);
                            //     },
                            //   ),
                            // ),
                            // const SizedBox(width: 12),
                            BlocListener<ProfileBloc, ProfileState>(
                              listener: (context, state) {
                                if (state.status == Status.success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.successMessage ?? 'Profile saved successfully'),
                                      backgroundColor: AppColors.successGreen,
                                    ),
                                  );
                                } else if (state.status == Status.error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.errorMessage ?? 'Error saving profile'),
                                      backgroundColor: AppColors.errorRed,
                                    ),
                                  );
                                }
                              },
                              child: BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, state) {
                                  return Expanded(
                                    child: CustomButtonFactory.success(
                                      text: state.status == Status.loading ? 'Saving...' : 'Save',
                                      onPressed: state.status == Status.loading
                                          ? null
                                          : () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<ProfileBloc>().add(
                                            const SaveProfileEvent(),
                                          );
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                      ],
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

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.primaryColor.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
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

      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Delete Account',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
              fontSize: 18,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
            style: TextStyle(
              color: AppColors.textMid,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.textMid,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            CustomButtonFactory.danger(
              text: 'Delete',
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Account deleted successfully'),
                    backgroundColor: AppColors.errorRed,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
