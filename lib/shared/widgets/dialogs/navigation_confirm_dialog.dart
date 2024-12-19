import 'package:flutter/material.dart';
import 'package:easy_manga_editor/shared/models/navigation_confirm_result.dart';

class NavigationConfirmDialog extends StatefulWidget {
  const NavigationConfirmDialog({super.key});

  @override
  State<NavigationConfirmDialog> createState() =>
      _NavigationConfirmDialogState();
}

class _NavigationConfirmDialogState extends State<NavigationConfirmDialog> {
  bool _dontShowAgain = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Xác nhận chuyển trang'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Bạn có chắc chắn muốn quay lại trang này?'),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _dontShowAgain,
                onChanged: (value) {
                  setState(() {
                    _dontShowAgain = value ?? false;
                  });
                },
              ),
              Expanded(
                child: Text(
                  'Không nhắc tôi vấn đề này',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(
              const NavigationConfirmResult(
                confirmed: false,
                dontShowAgain: false,
              ),
            );
          },
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(
              NavigationConfirmResult(
                confirmed: true,
                dontShowAgain: _dontShowAgain,
              ),
            );
          },
          child: const Text('Xác nhận'),
        ),
      ],
    );
  }
}
