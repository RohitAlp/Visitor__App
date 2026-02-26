import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitorapp/screens/society_admin/Manage%20User/security_guards/edit_guards_details_form/bloc/editguards_bloc.dart';
import 'package:visitorapp/widgets/custom_app_bar.dart';

import '../../../../../widgets/text_form_field.dart';

class EditSecurityGuardsForm extends StatefulWidget {
  const EditSecurityGuardsForm({super.key});

  @override
  State<EditSecurityGuardsForm> createState() => _EditSecurityGuardsFormState();
}

class _EditSecurityGuardsFormState extends State<EditSecurityGuardsForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Edit Guards Details'),
      body: SafeArea(
          child: BlocProvider(
            create: (context) => EditguardsBloc(), child: Form(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Guard Information',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 22),

                    Text('Guard Name'),
                    SizedBox(height: 8),
                    BlocBuilder<EditguardsBloc, EditguardsState>(
                      builder: (context, state) {
                        return CustomTextField(
                          hintText: "Enter Guard Name",
                          onChanged: (v) {
                            context.read<EditguardsBloc>().add(
                                EditGuardNameEvent(v));
                          },
                        );
                      },
                    ),

                    SizedBox(height: 16),
                    Text('Guard ID'),
                    SizedBox(height: 8),
                    BlocBuilder<EditguardsBloc, EditguardsState>(
                      builder: (context, state) {
                        return CustomTextField(
                          hintText: "Enter Guard ID",
                          onChanged: (v) {
                            context.read<EditguardsBloc>().add(
                                EditGuardIDEvent(v));
                          },
                        );
                      },
                    ),

                    SizedBox(height: 16),
                    Text('Guard Mobile Number'),
                    SizedBox(height: 8),
                    BlocBuilder<EditguardsBloc, EditguardsState>(
                      builder: (context, state) {
                        return CustomTextField(
                          hintText: "Enter Mobile Number",
                          keyboardType: TextInputType.phone,
                          onChanged: (v) {
                            context.read<EditguardsBloc>().add(
                                EditGuardMobileNumberEvent(v));
                          },
                        );
                      },
                    ),

                    SizedBox(height: 16),
                    Text('Guard Email ID'),
                    SizedBox(height: 8),
                    BlocBuilder<EditguardsBloc, EditguardsState>(
                      builder: (context, state) {
                        return CustomTextField(
                          hintText: "Enter Email",
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (v) {},
                        );
                      },
                    ),

                    SizedBox(height: 16),
                    Text('Guard Address'),
                    SizedBox(height: 8),
                    BlocBuilder<EditguardsBloc, EditguardsState>(
                      builder: (context, state) {
                        return CustomTextField(
                          hintText: "Enter Address",
                          maxLines: 3,
                          onChanged: (v) {},
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),)
      ),
    );
  }
}
