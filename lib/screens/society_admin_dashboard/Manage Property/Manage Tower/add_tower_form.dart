import 'package:flutter/material.dart';
import 'package:visitorapp/constants/app_colors.dart';
import 'package:visitorapp/controller/tower_controller.dart';
import 'package:visitorapp/model/AddTowerResponse.dart';
import 'package:visitorapp/widgets/custom_app_bar.dart';
import 'package:visitorapp/widgets/custom_dropdown.dart';
import 'package:visitorapp/widgets/text_form_field.dart';
import '../../../../config/Routes/RouteName.dart';
import '../../../../constants/constant.dart';
import '../../../../constants/utils.dart';
import '../../../../widgets/owner_card.dart';
import 'Add_tower.dart';

class AddTowerForm extends StatefulWidget {
  const AddTowerForm({super.key});

  @override
  State<AddTowerForm> createState() => _AddTowerFormState();
}

class _AddTowerFormState extends State<AddTowerForm> {
  final _formKey = GlobalKey<FormState>();

  final _towerNameController = TextEditingController();
  final _towerCodeController = TextEditingController();
  final _wingsController = TextEditingController();

  final List<String> _statuses = ['Active', 'Inactive'];
  String? _selectedStatus = 'Active';

  bool _didInitFromArgs = false;
  bool _isEdit = false;

  Future<void> _addTower(BuildContext context) async {
    if (await Utils.isConnected()) {
      bool _isLoading = true;
      Utils.onLoading(context);

      Map<String, dynamic> data = {
        "buildingName": _towerNameController.text ?? "",
        "numberOfFloors": 9,
        "societyId": 3,
      };

      TowerController loginUserController = TowerController();
      try {
        final response = await loginUserController.addTower(data);

        if (response != null) {
          AddTowerResponse res = AddTowerResponse.fromJson(response.data);

          if (res.status == true && res.statusCode==200) {
            Utils.showToast(context, message: '${res.message}');

            Navigator.pop(context);
            _isLoading = false;
            Navigator.pushReplacementNamed(context, RouteName.ManageTowersScreen);
          } else {
            Utils.showToast(context, message: '${res.message}');
          }
        } else {
          Utils.showToast(context, message: 'Something went wrong!');
          print(response);
        }
      } catch (e) {
        Utils.showToast(context, message: 'Something went wrong!');
        print(e);
      } finally {
        if (_isLoading) {
          Navigator.pop(context);
        }
      }
    } else {
      Utils.showToast(context, message: Constant.internetConMsg);
    }
  }

  @override
  void dispose() {
    _towerNameController.dispose();
    _towerCodeController.dispose();
    _wingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (!_didInitFromArgs && args is Map) {
      _didInitFromArgs = true;
      final isEditArg = args['isEdit'];
      _isEdit = isEditArg == true;

      final towerArg = args['tower'];
      if (towerArg is Owner) {
        _towerNameController.text = towerArg.name;
        _towerCodeController.text = towerArg.towerCode ?? '';
        _wingsController.text = towerArg.wings?.toString() ?? '0';
        _selectedStatus = towerArg.isActive ? 'Active' : 'Inactive';
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: _isEdit ? 'Update Tower' : 'Add Tower'),
        body: Container(
          color: AppColors.scaffoldBg,
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
                    _buildLabel('Tower Name'),
                    const SizedBox(height: 6),
                    CustomTextField(
                      controller: _towerNameController,
                      hintText: 'Enter tower name',
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Required';
                        return null;
                      },
                      onChanged: (_) {},
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Tower Code'),
                    const SizedBox(height: 6),
                    CustomTextField(
                      controller: _towerCodeController,
                      hintText: 'Enter tower code',
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Required';
                        return null;
                      },
                      onChanged: (_) {},
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Number of Wings'),
                    const SizedBox(height: 6),
                    CustomTextField(
                      controller: _wingsController,
                      hintText: 'Enter number of wings',
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Required';
                        final digitsOnly = RegExp(r'^[0-9]+$');
                        if (!digitsOnly.hasMatch(v.trim())) {
                          return 'Enter a valid number';
                        }
                        if (int.tryParse(v.trim()) == 0) {
                          return 'Must be greater than 0';
                        }
                        return null;
                      },
                      onChanged: (_) {},
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Tower Status'),
                    const SizedBox(height: 6),
                    CustomDropdown(
                      hintText: '',
                      value: _selectedStatus,
                      items: _statuses,
                      onChanged: (v) => setState(() => _selectedStatus = v),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: AppColors.scaffoldBg,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: SizedBox(
            height: 45,
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
                    onPressed: () {
                      final valid = _formKey.currentState!.validate();
                      if (valid) {
                        if(_isEdit)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _isEdit ? 'Tower updated' : 'Tower added',
                              ),
                              backgroundColor: AppColors.successGreen,
                            ),
                          );
                          Navigator.pop(context);
                        }else{
                          _addTower(context);
                        }
                      }
                    },
                    child: Text(
                      _isEdit ? 'Update Tower' : 'Add Tower',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
                text: ' *',
                style: TextStyle(color: AppColors.errorRed),
              ),
            ]
          : [],
    ),
  );
}
