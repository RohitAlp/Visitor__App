import 'package:flutter/material.dart';
import 'package:visitorapp/constants/app_colors.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final String hintText;
  final List<String> items;
  final bool isLoading;
  final bool enabled;
  final ValueChanged<String?> onChanged;
  final Widget? loadingWidget;
  final String? dependencyText;

  const CustomDropdown({
    super.key,
    this.value,
    required this.hintText,
    required this.items,
    this.isLoading = false,
    this.enabled = true,
    required this.onChanged,
    this.loadingWidget,
    this.dependencyText,
  });

  @override
  Widget build(BuildContext context) {
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
          value: value?.isEmpty == true ? null : value,
          hint: _buildHintWidget(),
          dropdownColor: Colors.white,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: enabled && !isLoading ? onChanged : null,
          icon: isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xFFCC6A00),
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildHintWidget() {
    if (isLoading) {
      return loadingWidget ??
          const Row(
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
              Text('Loading...'),
            ],
          );
    }

    if (dependencyText != null) {
      return Text(
        dependencyText!,
        style: const TextStyle(color: Colors.grey),
      );
    }

    return Text(
      hintText,
      style: const TextStyle(color: Colors.grey),
    );
  }
}
