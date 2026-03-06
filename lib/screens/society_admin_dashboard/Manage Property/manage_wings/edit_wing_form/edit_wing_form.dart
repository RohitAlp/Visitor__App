import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitorapp/constants/app_colors.dart';
import 'package:visitorapp/widgets/custom_app_bar.dart';
import 'package:visitorapp/widgets/text_form_field.dart';
import 'package:visitorapp/widgets/custom_dropdown.dart';

import '../../../../../utils/enum.dart';
import 'bloc/editwing_bloc.dart';

class EditWingForm extends StatefulWidget {
  const EditWingForm({super.key});

  @override
  State<EditWingForm> createState() => _EditWingFormState();
}

class _EditWingFormState extends State<EditWingForm> {
  final _formKey = GlobalKey<FormState>();
  
  final List<String> towers = ['Tower A', 'Tower B', 'Tower C', 'Tower D'];
  final List<String> wingStatuses = ['Active', 'Inactive', 'Under Maintenance'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Wing'),
      
      body: BlocListener<EditwingBloc, EditwingState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == Status.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Wing updated successfully'),
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
                        const Text(
                          'Edit Wing',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        _buildLabel('Select Tower'),
                        const SizedBox(height: 8),
                        BlocBuilder<EditwingBloc, EditwingState>(
                          builder: (context, state) {
                            return CustomDropdown(
                              value: state.selectedTower.isEmpty ? null : state.selectedTower,
                              hintText: 'Select Tower',
                              items: towers,
                              onChanged: (String? value) {
                                if (value != null) {
                                  context.read<EditwingBloc>().add(SelectTowerEvent(value));
                                }
                              },
                            );
                          },
                        ),
                        
                        const SizedBox(height: 20),
                        
                        _buildLabel('Enter Wing Name'),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Enter Wing Name',
                          onChanged: (value) {
                            context.read<EditwingBloc>().add(EditWingNameEvent(value));
                          },
                        ),
                        
                        const SizedBox(height: 20),
                        
                        _buildLabel('Wing Status'),
                        const SizedBox(height: 8),
                        BlocBuilder<EditwingBloc, EditwingState>(
                          builder: (context, state) {
                            return CustomDropdown(
                              value: state.wingStatus.isEmpty ? null : state.wingStatus,
                              hintText: 'Select Status',
                              items: wingStatuses,
                              onChanged: (String? value) {
                                if (value != null) {
                                  context.read<EditwingBloc>().add(SelectWingStatusEvent(value));
                                }
                              },
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
      
      bottomNavigationBar: BlocBuilder<EditwingBloc, EditwingState>(
        builder: (context, state) {
          return SafeArea(
            child: Container(
              color: AppColors.scaffoldBg,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppColors.black,
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
                      onPressed: state.status == Status.loading
                          ? null
                          : () {
                        if (_formKey.currentState!.validate() &&
                            state.selectedTower.isNotEmpty &&
                            state.wingName.isNotEmpty &&
                            state.wingStatus.isNotEmpty) {
                          context.read<EditwingBloc>().add(const UpdateWingEvent());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill all required fields'),
                              backgroundColor: AppColors.warningOrange,
                            ),
                          );
                        }
                      },
                      child: state.status == Status.loading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        'Update Wing',
                        style: TextStyle(
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
