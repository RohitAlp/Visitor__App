import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String) onChanged; // ✅ onChanged added
  final bool? readOnly;
  final int? maxLines;

  const CustomTextField({
    super.key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    required this.onChanged,
    this.readOnly,
    this.maxLines,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final bool isPasswordField = widget.obscureText == true;

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      obscureText: _obscureText,
      validator: widget.validator,
      onChanged: widget.onChanged,
      readOnly: widget.readOnly ?? false,
      maxLines: widget.maxLines ?? 1,
      decoration: InputDecoration(
        hintText: widget.hintText ?? '',
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: widget.prefixIcon,
        suffixIcon: isPasswordField
            ? IconButton(
          icon: Icon(
            _obscureText
                ? Icons.visibility_off
                : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : widget.suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
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
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}