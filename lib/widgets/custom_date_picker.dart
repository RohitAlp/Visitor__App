import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String) onChanged;
  final bool? readOnly;

  const CustomDatePickerField({
    super.key,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    required this.onChanged,
    this.readOnly,
  });

  @override
  State<CustomDatePickerField> createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);

      setState(() {
        _controller.text = formattedDate;
      });

      widget.onChanged(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      validator: widget.validator,
      onTap: _selectDate,
      decoration: InputDecoration(
        hintText: widget.hintText ?? "Select Date",
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,

        prefixIcon: widget.prefixIcon,

        suffixIcon: widget.suffixIcon ??
            const Icon(Icons.calendar_today, size: 20),

        contentPadding: const EdgeInsets.symmetric(horizontal: 16),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
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

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}