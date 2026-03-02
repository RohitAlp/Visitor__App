import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final Color? iconColor;
  final Color? borderColor;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int? maxLength;
  final bool isRequired;
  final bool readOnly;

  const CommonTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.iconColor,
    this.borderColor,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLength,
    this.isRequired = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBorderColor =
        borderColor ?? Colors.grey.shade300;

    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLength: maxLength,
      readOnly: readOnly,
      decoration: InputDecoration(
        counterText: "",

        // ⭐ Hint with optional *
        hint: RichText(
          text: TextSpan(
            text: hintText,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
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
        ),

        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: iconColor ?? Colors.grey)
            : null,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),

        // ⭐ light grey filled background
        filled: true,
        fillColor: Colors.grey.shade100,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: effectiveBorderColor),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: effectiveBorderColor,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),

        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}