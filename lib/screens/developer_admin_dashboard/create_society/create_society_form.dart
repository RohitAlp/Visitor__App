import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitorapp/screens/developer_admin_dashboard/create_society/bloc/create_society_bloc.dart';
import 'package:visitorapp/screens/developer_admin_dashboard/create_society/bloc/create_society_event.dart';
import 'package:visitorapp/screens/developer_admin_dashboard/create_society/bloc/create_society_state.dart';
import '../../../config/Routes/RouteName.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/constant.dart';
import '../../../constants/utils.dart';
import '../../../utils/enum.dart';
import '../../../widgets/custom_app_bar.dart';

class CreateSocietyScreen extends StatelessWidget {
  const CreateSocietyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SocietyBloc(),
      child: const CreateSocietyForm(),
    );
  }
}

class CreateSocietyForm extends StatefulWidget {
  const CreateSocietyForm({super.key});

  @override
  State<CreateSocietyForm> createState() => _CreateSocietyFormState();
}

class _CreateSocietyFormState extends State<CreateSocietyForm> {
  final _formKey = GlobalKey<FormState>();
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
                ),
              ]
            : [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: CustomAppBar(title: "Add Society"),

      body: BlocListener<SocietyBloc, SocietyState>(
        listener: (context, state) {
          /// LOADING
          if (state.submissionStatus == Status.loading) {
            Utils.onLoading(context);
          }

          /// SUCCESS
          if (state.submissionStatus == Status.success) {
            Navigator.pop(context); // close loader

            Utils.showToast(context, message: "Society added successfully");

            Navigator.pop(context);
          }

          /// ERROR
          if (state.submissionStatus == Status.error) {
            Navigator.pop(context); // close loader

            Utils.showToast(
              context,
              message: state.errorMessage ?? 'Something went wrong',
            );
          }
        },
        child: BlocBuilder<SocietyBloc, SocietyState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// BASIC INFORMATION
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          /// HEADER
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Color(0xffF3E4D8),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffC96B16),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.apartment,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Basic Information",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// BODY
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                /// SOCIETY NAME
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel(
                                      "Society Name",
                                      isRequired: true,
                                    ),
                                    const SizedBox(height: 6),

                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Enter society name",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                        filled: true,
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return "Society name is required";
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        context.read<SocietyBloc>().add(
                                          SocietyNameChanged(value),
                                        );
                                      },
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                Row(
                                  children: [
                                    /// REG NUMBER
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildLabel(
                                            "Registration Number",
                                            isRequired: false,
                                          ),
                                          const SizedBox(height: 6),

                                          TextFormField(
                                            decoration: InputDecoration(
                                              hintText: "REG-XXXX",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                ),
                                              ),
                                              filled: true,
                                            ),
                                            onChanged: (value) {
                                              context.read<SocietyBloc>().add(
                                                RegistrationNumberChanged(
                                                  value,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    /// ESTABLISHED YEAR
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildLabel(
                                            "Established Year",
                                            isRequired: true,
                                          ),
                                          const SizedBox(height: 6),

                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: "YYYY",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                ),
                                              ),
                                              filled: true,
                                              suffixIcon: const Icon(
                                                Icons.calendar_today,
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Year required";
                                              }

                                              if (value.length != 4) {
                                                return "Enter valid year";
                                              }

                                              return null;
                                            },
                                            onChanged: (value) {
                                              context.read<SocietyBloc>().add(
                                                EstablishedYearChanged(value),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// ADDRESS INFORMATION
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          /// HEADER
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Color(0xffF3E4D8),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffC96B16),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Address Information",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// BODY
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                /// STREET
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel(
                                      "Street Address",
                                      isRequired: true,
                                    ),
                                    const SizedBox(height: 6),

                                    TextFormField(
                                      keyboardType: TextInputType.streetAddress,
                                      decoration: InputDecoration(
                                        hintText: "Enter street address",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                        filled: true,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Street address required";
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        context.read<SocietyBloc>().add(
                                          StreetAddressChanged(value),
                                        );
                                      },
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                /// LANDMARK
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel("Landmark", isRequired: false),
                                    const SizedBox(height: 6),

                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText:
                                            "Enter Nearby landmark(Optional)",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                        filled: true,
                                      ),
                                      onChanged: (value) {
                                        context.read<SocietyBloc>().add(
                                          LandmarkChanged(value),
                                        );
                                      },
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                /// CITY & STATE
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildLabel("City", isRequired: true),
                                          const SizedBox(height: 6),

                                          TextFormField(
                                            decoration: InputDecoration(
                                              hintText: "City",

                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                ),
                                              ),
                                              filled: true,
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "City required";
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              context.read<SocietyBloc>().add(
                                                CityChanged(value),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildLabel(
                                            "State",
                                            isRequired: true,
                                          ),
                                          const SizedBox(height: 6),

                                          TextFormField(
                                            decoration: InputDecoration(
                                              hintText: "State",

                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                ),
                                              ),
                                              filled: true,
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "State required";
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              context.read<SocietyBloc>().add(
                                                StateChanged(value),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                /// PINCODE & COUNTRY
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildLabel(
                                            "Pincode",
                                            isRequired: true,
                                          ),
                                          const SizedBox(height: 6),

                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: "Pincode",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                ),
                                              ),
                                              filled: true,
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Pincode required";
                                              }
                                              if (value.length != 6) {
                                                return "Enter valid pincode";
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              context.read<SocietyBloc>().add(
                                                PincodeChanged(value),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildLabel(
                                            "Country",
                                            isRequired: true,
                                          ),
                                          const SizedBox(height: 6),

                                          TextFormField(
                                            decoration: InputDecoration(
                                              hintText: "Country",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade400,
                                                ),
                                              ),
                                              filled: true,
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Country required";
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              context.read<SocietyBloc>().add(
                                                CountryChanged(value),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      /// BOTTOM BUTTONS
      bottomNavigationBar: BlocBuilder<SocietyBloc, SocietyState>(
        builder: (context, state) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  /// CANCEL BUTTON
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xffC96B16)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Color(0xffC96B16),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// ADD SOCIETY BUTTON
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffC96B16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: state.isSubmitting
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<SocietyBloc>().add(
                                  SaveSocietyPressed(),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Please fill all required fields",
                                    ),
                                  ),
                                );
                              }
                            },
                      child: state.isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "Add Society",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
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
}
