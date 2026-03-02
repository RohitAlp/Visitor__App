import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitorapp/constants/app_colors.dart';
import 'package:visitorapp/screens/society_admin/Manage Property/Manage Flats/edit_flatts_form/flat_bloc/flat_bloc.dart';
import 'package:visitorapp/utils/enum.dart';
import 'package:visitorapp/widgets/custom_app_bar.dart';
import 'package:visitorapp/widgets/text_form_field.dart';
import 'package:visitorapp/widgets/custom_dropdown.dart';

class EditFlatForm extends StatefulWidget {
  const EditFlatForm({super.key});

  @override
  State<EditFlatForm> createState() => _EditFlatFormState();
}

class _EditFlatFormState extends State<EditFlatForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FlatBloc(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Edit Flat'),
        body: BlocListener<FlatBloc, FlatState>(
          listenWhen: (previous, current) => previous.submissionStatus != current.submissionStatus,
          listener: (context, state) {
            if (state.submissionStatus == Status.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Flat updated successfully'),
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
                          'Edit Flat',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24),

                        _buildLabel('Select Tower'),
                        const SizedBox(height: 8),
                        BlocBuilder<FlatBloc, FlatState>(
                          builder: (context, state) {
                            return CustomDropdown(
                              value: state.selectedTower.isEmpty ? null : state.selectedTower,
                              hintText: 'Select a tower',
                              items: state.availableTowers,
                              isLoading: state.isLoadingTowers,
                              onChanged: (String? value) {
                                if (value != null) {
                                  context.read<FlatBloc>().add(TowerChangedEvent(value));
                                }
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        _buildLabel('Select Wing'),
                        const SizedBox(height: 8),
                        BlocBuilder<FlatBloc, FlatState>(
                          builder: (context, state) {
                            return CustomDropdown(
                              value: state.selectedWing.isEmpty ? null : state.selectedWing,
                              hintText: 'Select a wing',
                              items: state.availableWings,
                              isLoading: state.isLoadingWings,
                              enabled: state.selectedTower.isNotEmpty,
                              dependencyText: state.selectedTower.isEmpty 
                                  ? 'Select tower first' 
                                  : null,
                              loadingWidget: const Row(
                                children: [
                                  SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Color(0xFFCC6A00),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text('Loading wings...'),
                                ],
                              ),
                              onChanged: (String? value) {
                                if (value != null) {
                                  context.read<FlatBloc>().add(WingChangedEvent(value));
                                }
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        _buildLabel('Select Floor'),
                        const SizedBox(height: 8),
                        BlocBuilder<FlatBloc, FlatState>(
                          builder: (context, state) {
                            return CustomDropdown(
                              value: state.selectedFloor.isEmpty ? null : state.selectedFloor,
                              hintText: 'Select a floor',
                              items: state.availableFloors,
                              isLoading: state.isLoadingFloors,
                              enabled: state.selectedWing.isNotEmpty,
                              dependencyText: state.selectedWing.isEmpty 
                                  ? 'Select wing first' 
                                  : null,
                              loadingWidget: const Row(
                                children: [
                                  SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Color(0xFFCC6A00),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text('Loading floors...'),
                                ],
                              ),
                              onChanged: (String? value) {
                                if (value != null) {
                                  context.read<FlatBloc>().add(FloorChangedEvent(value));
                                }
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        _buildLabel('Flat Number'),
                        const SizedBox(height: 8),
                        BlocBuilder<FlatBloc, FlatState>(
                          builder: (context, state) {
                            return CustomTextField(
                              hintText: 'e.g., 101, 102, A-201',
                              onChanged: (value) {
                                context.read<FlatBloc>().add(FlatNumberChangedEvent(value));
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

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<FlatBloc, FlatState>(
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
                            context.read<FlatBloc>().add(UpdateFlatEvent());
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
                          'Update Flat',
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
