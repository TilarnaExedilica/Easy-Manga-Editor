import 'package:easy_manga_editor/core/utils/extensions/radius_extension.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_manga_editor/app/l10n/tr_keys.dart';
import 'package:easy_manga_editor/shared/widgets/buttons/theme_button.dart';
import 'package:easy_manga_editor/core/utils/constants/ui_constants.dart';

class ControlDrawer extends StatelessWidget {
  const ControlDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: UIConstants.drawerWidth,
        decoration: BoxDecoration(
          color: Theme.of(context).drawerTheme.backgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(UIConstants.drawerWidth.r),
            bottomRight: Radius.circular(UIConstants.drawerWidth.r),
          ),
          border: Border(
            right: BorderSide(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              width: UIConstants.border,
            ),
            top: BorderSide(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              width: UIConstants.border,
            ),
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              width: UIConstants.border,
            ),
          ),
        ),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    width: UIConstants.border,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    TrKeys.appName.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            // Main content
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [],
                ),
              ),
            ),
            // Bottom controls
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    width: UIConstants.border,
                  ),
                ),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ThemeButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}