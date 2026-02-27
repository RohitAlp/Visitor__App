import 'package:flutter/material.dart';

class CommonOtpField extends StatefulWidget {
  final int length;
  final Function(String)? onCompleted;
  final Color? borderColor;
  final Color? fillColor;

  const CommonOtpField({
    super.key,
    this.length = 4,
    this.onCompleted,
    this.borderColor,
    this.fillColor,
  });

  @override
  State<CommonOtpField> createState() => _CommonOtpFieldState();
}

class _CommonOtpFieldState extends State<CommonOtpField> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();

    controllers =
        List.generate(widget.length, (_) => TextEditingController());
    focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _checkCompletion() {
    String otp = controllers.map((e) => e.text).join();
    if (otp.length == widget.length) {
      widget.onCompleted?.call(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultBorder = widget.borderColor ?? Colors.grey.shade300;
    final filledBorder = Colors.grey.shade500;
    final fillColor = widget.fillColor ?? Colors.grey.shade100;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4), // ⭐ spacing
          child: SizedBox(
            width: 50,
            height: 50,
            child: ValueListenableBuilder(
              valueListenable: controllers[index],
              builder: (context, _, __) {
                final isFilled = controllers[index].text.isNotEmpty;
                final isFocused = focusNodes[index].hasFocus;

                return TextFormField(
                  controller: controllers[index],
                  focusNode: focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    counterText: "",
                    filled: true,
                    fillColor: fillColor,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color:  defaultBorder,
                        width: isFocused ? 1.8 : 1,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: filledBorder,
                        width: 2,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});

                    if (value.length == 1 && index < widget.length - 1) {
                      focusNodes[index + 1].requestFocus();
                    }

                    if (value.isEmpty && index > 0) {
                      focusNodes[index - 1].requestFocus();
                    }

                    _checkCompletion();
                  },
                );
              },
            ),
          ),
        );
      }),
    );
  }
}