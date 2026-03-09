import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'custom_button.dart';

enum DialogueType {
  logout,
  closeApp,
  custom,
}

class CommonDialogue extends StatelessWidget {
  final DialogueType type;
  final String? title;
  final String? message;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final Widget? icon;
  final Color? confirmButtonColor;
  final Color? cancelButtonColor;

  const CommonDialogue({
    super.key,
    required this.type,
    this.title,
    this.message,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.icon,
    this.confirmButtonColor,
    this.cancelButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      backgroundColor: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(),
            const SizedBox(height: 16),
            _buildTitle(),
            const SizedBox(height: 12),
            _buildMessage(),
            const SizedBox(height: 24),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (icon != null) return icon!;
    
    switch (type) {
      case DialogueType.logout:
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.errorRed.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.logout,
            color: AppColors.errorRed,
            size: 32,
          ),
        );
      case DialogueType.closeApp:
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.warningOrange.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.close,
            color: AppColors.warningOrange,
            size: 32,
          ),
        );
      case DialogueType.custom:
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.infoBlue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.info_outline,
            color: AppColors.infoBlue,
            size: 32,
          ),
        );
    }
  }

  Widget _buildTitle() {
    String dialogueTitle = title ?? '';
    
    switch (type) {
      case DialogueType.logout:
        dialogueTitle = title ?? 'Logout';
        break;
      case DialogueType.closeApp:
        dialogueTitle = title ?? 'Close App';
        break;
      case DialogueType.custom:
        dialogueTitle = title ?? 'Confirm Action';
        break;
    }
    
    return Text(
      dialogueTitle,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMessage() {
    String dialogueMessage = message ?? '';
    
    switch (type) {
      case DialogueType.logout:
        dialogueMessage = message ?? 'Are you sure you want to logout?';
        break;
      case DialogueType.closeApp:
        dialogueMessage = message ?? 'Are you sure you want to close the app?';
        break;
      case DialogueType.custom:
        dialogueMessage = message ?? 'Are you sure you want to perform this action?';
        break;
    }
    
    return Text(
      dialogueMessage,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textMid,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: cancelText ?? 'Cancel',
            onPressed: onCancel,
            backgroundColor: cancelButtonColor ?? AppColors.grey200,
            textColor: AppColors.textDark,
            height: 45,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomButton(
            text: confirmText ?? _getDefaultConfirmText(),
            onPressed: onConfirm,
            backgroundColor: confirmButtonColor ?? _getDefaultConfirmColor(),
            textColor: AppColors.white,
            height: 45,
          ),
        ),
      ],
    );
  }

  String _getDefaultConfirmText() {
    switch (type) {
      case DialogueType.logout:
        return 'Logout';
      case DialogueType.closeApp:
        return 'Close';
      case DialogueType.custom:
        return 'Confirm';
    }
  }

  Color _getDefaultConfirmColor() {
    switch (type) {
      case DialogueType.logout:
        return AppColors.errorRed;
      case DialogueType.closeApp:
        return AppColors.warningOrange;
      case DialogueType.custom:
        return AppColors.primaryColor;
    }
  }
}

class DialogueHelper {
  static Future<bool?> showLogoutDialogue({
    required BuildContext context,
    String? title,
    String? message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => CommonDialogue(
        type: DialogueType.logout,
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: () {
          onConfirm?.call();
          Navigator.of(context).pop(true);
        },
        onCancel: () {
          onCancel?.call();
          Navigator.of(context).pop(false);
        },
      ),
    );
  }

  static Future<bool?> showCloseAppDialogue({
    required BuildContext context,
    String? title,
    String? message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => CommonDialogue(
        type: DialogueType.closeApp,
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: () {
          onConfirm?.call();
          Navigator.of(context).pop(true);
        },
        onCancel: () {
          onCancel?.call();
          Navigator.of(context).pop(false);
        },
      ),
    );
  }

  static Future<bool?> showCustomDialogue({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Widget? icon,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => CommonDialogue(
        type: DialogueType.custom,
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: () {
          onConfirm?.call();
          Navigator.of(context).pop(true);
        },
        onCancel: () {
          onCancel?.call();
          Navigator.of(context).pop(false);
        },
        icon: icon,
        confirmButtonColor: confirmButtonColor,
        cancelButtonColor: cancelButtonColor,
      ),
    );
  }
}
