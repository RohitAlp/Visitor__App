import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitorapp/constants/app_colors.dart';
import 'package:visitorapp/screens/society_admin/Manage Property/manage_amanities/edit_aminity/amenity_bloc/aminity_bloc.dart';
import 'package:visitorapp/utils/enum.dart';
import 'package:visitorapp/widgets/custom_app_bar.dart';
import 'package:visitorapp/widgets/text_form_field.dart';

class EditAminityForm extends StatefulWidget {
  const EditAminityForm({super.key});

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
        appBar: const CustomAppBar(title: 'Edit Amenity'),
        body: BlocListener<AminityBloc, AminityState>(
          listenWhen: (previous, current) => previous.submissionStatus != current.submissionStatus,
          listener: (context, state) {
            if (state.submissionStatus == Status.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Amenity updated successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            }

            if (state.submissionStatus == Status.error) {
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
                          'Edit Amenity',
                          style: TextStyle(
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
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: state.amenityType.isEmpty ? null : state.amenityType,
                                  hint: const Text(
                                    'Select amenity type',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  items: _amenityTypes.map((String type) {
                                    return DropdownMenuItem<String>(
                                      value: type,
                                      child: Text(type),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      context.read<AminityBloc>().add(AmenityTypeChangedEvent(value));
                                    }
                                  },
                                ),
                              ),
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
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: state.status.isEmpty ? null : state.status,
                                  hint: const Text(
                                    'Select status',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  items: _statuses.map((String status) {
                                    return DropdownMenuItem<String>(
                                      value: status,
                                      child: Text(status),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      context.read<AminityBloc>().add(StatusChangedEvent(value));
                                    }
                                  },
                                ),
                              ),
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
                                  backgroundColor: Colors.grey.shade200,
                                  selectedColor: const Color(0xFFCC6A00).withOpacity(0.2),
                                  checkmarkColor: const Color(0xFFCC6A00),
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
                color: const Color(0xFFF5F5F5),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFCC6A00)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFFCC6A00),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCC6A00),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: state.submissionStatus == Status.loading
                            ? null
                            : () {
                          if (_formKey.currentState!.validate() && state.isFormValid) {
                            context.read<AminityBloc>().add(UpdateAmenityEvent());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill all required fields'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          }
                        },
                        child: state.submissionStatus == Status.loading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : const Text(
                          'Update Amenity',
                          style: TextStyle(
                            color: Colors.white,
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
}