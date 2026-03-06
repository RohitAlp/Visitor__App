import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? borderRadius;
  final TextStyle? textStyle;
  final Widget? child;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.borderRadius,
    this.textStyle,
    this.child,
  });

  const CustomButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor = AppColors.loadingOrange,
    this.textColor = AppColors.white,
    this.height = 45,
    this.borderRadius = 8,
    this.textStyle,
    this.child,
  });

  const CustomButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = AppColors.white,
    this.height = 45,
    this.borderRadius = 8,
    this.textStyle,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.loadingOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          elevation: 0,
          disabledBackgroundColor: backgroundColor?.withOpacity(0.6) ?? AppColors.loadingOrange.withOpacity(0.6),
        ),
        onPressed: (isLoading || onPressed == null) ? null : onPressed,
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              )
            : child ??
                Text(
                  text,
                  style: textStyle ??
                      const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                ),
      ),
    );
  }
}

class CustomButtonFactory {
  static Widget primary({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Color? backgroundColor,
    Color? textColor,
    double? height,
    double? borderRadius,
    TextStyle? textStyle,
    Widget? child,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      backgroundColor: backgroundColor ?? AppColors.loadingOrange,
      textColor: textColor ?? AppColors.white,
      height: height ?? 45,
      borderRadius: borderRadius ?? 8,
      textStyle: textStyle,
      child: child,
    );
  }

  static Widget secondary({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Color? backgroundColor,
    Color? textColor,
    double? height,
    double? borderRadius,
    TextStyle? textStyle,
    Widget? child,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      textColor: textColor ?? AppColors.white,
      height: height ?? 45,
      borderRadius: borderRadius ?? 8,
      textStyle: textStyle,
      child: child,
    );
  }

  static Widget success({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Color? backgroundColor,
    Color? textColor,
    double? height,
    double? borderRadius,
    TextStyle? textStyle,
    Widget? child,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      backgroundColor:  AppColors.loadingOrange,
      textColor: textColor ?? AppColors.white,
      height: height ?? 45,
      borderRadius: borderRadius ?? 8,
      textStyle: textStyle,
      child: child,
    );
  }

  static Widget danger({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Color? backgroundColor,
    Color? textColor,
    double? height,
    double? borderRadius,
    TextStyle? textStyle,
    Widget? child,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      backgroundColor: backgroundColor ?? AppColors.errorRed,
      textColor: textColor ?? AppColors.white,
      height: height ?? 45,
      borderRadius: borderRadius ?? 8,
      textStyle: textStyle,
      child: child,
    );
  }
}