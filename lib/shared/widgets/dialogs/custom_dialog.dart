import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_manga_editor/app/l10n/tr_keys.dart';
import 'package:easy_manga_editor/shared/widgets/buttons/app_button.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';

class CustomDialog extends StatelessWidget {
  final List<Widget> children;
  final String? title;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String? confirmText;
  final String? cancelText;
  final bool showActions;

  const CustomDialog({
    super.key,
    required this.children,
    this.title,
    this.onConfirm,
    this.onCancel,
    this.confirmText,
    this.cancelText,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null) ...[
              Text(
                title!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppDimensions.spacing),
            ],
            ...children,
            if (showActions && (onConfirm != null || onCancel != null)) ...[
              const SizedBox(height: AppDimensions.spacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onCancel != null)
                    AppButton(
                      text: cancelText ?? TrKeys.cancel.tr(),
                      isOutlined: true,
                      onPressed: () {
                        Navigator.of(context).pop();
                        onCancel?.call();
                      },
                    ),
                  if (onConfirm != null) ...[
                    const SizedBox(width: AppDimensions.spacingSmall),
                    AppButton(
                      text: confirmText ?? TrKeys.confirm.tr(),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConfirm?.call();
                      },
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  static Future<bool?> show({
    required BuildContext context,
    required List<Widget> children,
    String? title,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String? confirmText,
    String? cancelText,
    bool showActions = true,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => CustomDialog(
        title: title,
        onConfirm: onConfirm,
        onCancel: onCancel,
        confirmText: confirmText,
        cancelText: cancelText,
        showActions: showActions,
        children: children,
      ),
    );
  }
}
