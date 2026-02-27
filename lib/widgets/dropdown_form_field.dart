import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatelessWidget {
  final List<String> items;
  final String? value;
  final String? hintText;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onChanged;
  final bool isExpanded;

  const CustomDropdownFormField({
    super.key,
    required this.items,
    this.value,
    this.hintText,
    this.validator,
    this.onChanged,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: isExpanded,
      validator: validator,
      onChanged: onChanged,
      // Logic: Use provided hintText, otherwise default to 'Select'
      hint: Text(hintText ?? 'Select'),
      items: items
          .map((e) => DropdownMenuItem<String>(
        value: e,
        child: Text(e),
      ))
          .toList(),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        ),
        // Ensures the error text doesn't push the layout too aggressively
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}