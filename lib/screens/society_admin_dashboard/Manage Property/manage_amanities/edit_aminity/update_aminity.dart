import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitorapp/constants/app_colors.dart';
import 'package:visitorapp/utils/enum.dart';
import 'package:visitorapp/widgets/custom_app_bar.dart';
import 'package:visitorapp/widgets/text_form_field.dart';
import 'package:visitorapp/widgets/custom_dropdown.dart';

import 'amenity_bloc/aminity_bloc.dart';

class EditAminityForm extends StatefulWidget {
  final bool isAddingAmenity;
  
  const EditAminityForm({super.key, this.isAddingAmenity = false});

  @override
  State<EditAminityForm> createState() => _EditAminityFormState();
}

class _EditAminityFormState extends State<EditAminityForm> {
  final _formKey = GlobalKey<FormState>();
  
  final List<String> _amenityTypes = ['Gym', 'Swimming Pool', 'Club House', 'Garden', 'Parking', 'Other'];
  final List<String> _statuses = ['Active', 'Inactive', 'Under Maintenance'];
  final List<String> _daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AminityBloc(),
      child: Scaffold(
        appBar: CustomAppBar(title: widget.isAddingAmenity ? 'Add Amenity' : 'Edit Amenity'),
        body: BlocListener<AminityBloc, AminityState>(
          listenWhen: (previous, current) => previous.submissionStatus != current.submissionStatus,
          listener: (context, state) {
            if (state.submissionStatus == Status.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(widget.isAddingAmenity ? 'Amenity added successfully' : 'Amenity updated successfully'),
                  backgroundColor: AppColors.successGreen,
                ),
              );
              Navigator.pop(context);
            }

            if (state.submissionStatus == Status.error) {
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
                          widget.isAddingAmenity ? 'Add Amenity' : 'Edit Amenity',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24),

                        _buildLabel('Amenity Name'),
                        const SizedBox(height: 8),
                        BlocBuilder<AminityBloc, AminityState>(
                          builder: (context, state) {
                            return CustomTextField(
                              hintText: 'Enter amenity name',
                              onChanged: (value) {
                                context.read<AminityBloc>().add(AmenityNameChangedEvent(value));
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        _buildLabel('Amenity Type'),
                        const SizedBox(height: 8),
                        BlocBuilder<AminityBloc, AminityState>(
                          builder: (context, state) {
                            return CustomDropdown(
                              value: state.amenityType.isEmpty ? null : state.amenityType,
                              hintText: 'Select amenity type',
                              items: _amenityTypes,
                              onChanged: (String? value) {
                                if (value != null) {
                                  context.read<AminityBloc>().add(AmenityTypeChangedEvent(value));
                                }
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        _buildLabel('Location'),
                        const SizedBox(height: 8),
                        BlocBuilder<AminityBloc, AminityState>(
                          builder: (context, state) {
                            return CustomTextField(
                              hintText: 'Enter location',
                              onChanged: (value) {
                                context.read<AminityBloc>().add(LocationChangedEvent(value));
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        _buildLabel('Status'),
                        const SizedBox(height: 8),
                        BlocBuilder<AminityBloc, AminityState>(
                          builder: (context, state) {
                            return CustomDropdown(
                              value: state.status.isEmpty ? null : state.status,
                              hintText: 'Select status',
                              items: _statuses,
                              onChanged: (String? value) {
                                if (value != null) {
                                  context.read<AminityBloc>().add(StatusChangedEvent(value));
                                }
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Start Time'),
                                  const SizedBox(height: 8),
                                  BlocBuilder<AminityBloc, AminityState>(
                                    builder: (context, state) {
                                      return CustomTextField(
                                        hintText: '09:00 AM',
                                        onChanged: (value) {
                                          context.read<AminityBloc>().add(StartTimeChangedEvent(value));
                                        },
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return 'Required';
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('End Time'),
                                  const SizedBox(height: 8),
                                  BlocBuilder<AminityBloc, AminityState>(
                                    builder: (context, state) {
                                      return CustomTextField(
                                        hintText: '06:00 PM',
                                        onChanged: (value) {
                                          context.read<AminityBloc>().add(EndTimeChangedEvent(value));
                                        },
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return 'Required';
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        _buildLabel('Max Capacity (Optional)'),
                        const SizedBox(height: 8),
                        BlocBuilder<AminityBloc, AminityState>(
                          builder: (context, state) {
                            return CustomTextField(
                              hintText: 'Enter max capacity',
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                context.read<AminityBloc>().add(MaxCapacityChangedEvent(value));
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        _buildLabel('Amenity Fees/per hour (Optional)'),
                        const SizedBox(height: 8),
                        BlocBuilder<AminityBloc, AminityState>(
                          builder: (context, state) {
                            return CustomTextField(
                              hintText: 'Enter fees per hour',
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                context.read<AminityBloc>().add(AmenityFeesChangedEvent(value));
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        _buildLabel('Open Days (Optional)'),
                        const SizedBox(height: 8),
                        BlocBuilder<AminityBloc, AminityState>(
                          builder: (context, state) {
                            return Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _daysOfWeek.map((day) {
                                final isSelected = state.openDays.contains(day);
                                return FilterChip(
                                  label: Text(day),
                                  selected: isSelected,
                                  onSelected: (selected) {
                                    final updatedDays = List<String>.from(state.openDays);
                                    if (selected) {
                                      updatedDays.add(day);
                                    } else {
                                      updatedDays.remove(day);
                                    }
                                    context.read<AminityBloc>().add(OpenDaysChangedEvent(updatedDays));
                                  },
                                  backgroundColor: AppColors.grey200,
                                  selectedColor: AppColors.chipSelectedBg.withOpacity(0.2),
                                  checkmarkColor: AppColors.chipSelectedColor,
                                );
                              }).toList(),
                            );
                          },
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<AminityBloc, AminityState>(
          builder: (context, state) {
            return SafeArea(
              child: Container(
                color: AppColors.scaffoldBg,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.loadingOrange),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppColors.loadingOrange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.loadingOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: state.submissionStatus == Status.loading
                            ? null
                            : () {
                          if (_formKey.currentState!.validate() && state.isFormValid) {
                            if (widget.isAddingAmenity) {
                              context.read<AminityBloc>().add(AddAmenityEvent());
                            } else {
                              context.read<AminityBloc>().add(UpdateAmenityEvent());
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill all required fields'),
                                backgroundColor: AppColors.warningOrange,
                              ),
                            );
                          }
                        },
                        child: state.submissionStatus == Status.loading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : Text(
                          widget.isAddingAmenity ? 'Add Amenity' : 'Update Amenity',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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
}