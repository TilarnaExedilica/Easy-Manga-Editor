import 'package:easy_manga_editor/app/theme/styles/broken_icons.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';
import 'package:easy_manga_editor/screens/settings/setting_widget.dart';
import 'package:easy_manga_editor/shared/widgets/buttons/custom_button.dart';
import 'package:easy_manga_editor/shared/widgets/drawer/project_tree.dart';
import 'package:easy_manga_editor/shared/widgets/drawer/stack_tree.dart';
import 'package:easy_manga_editor/shared/widgets/overlay/custom_page_overlay.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_manga_editor/app/tr/tr_keys.dart';
import 'package:easy_manga_editor/shared/widgets/buttons/theme_button.dart';
import 'package:easy_manga_editor/core/utils/constants/ui_constants.dart';

class ControlDrawer extends StatelessWidget {
  const ControlDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UIConstants.drawerWidth,
      constraints: const BoxConstraints.expand(width: UIConstants.drawerWidth),
      decoration: BoxDecoration(
        color: Theme.of(context).drawerTheme.backgroundColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(AppDimensions.radius),
          bottomRight: Radius.circular(AppDimensions.radius),
        ),
        border: Border(
          right: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: AppDimensions.borderWidth,
          ),
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: AppDimensions.borderWidth,
          ),
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: AppDimensions.borderWidth,
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
                  color: Theme.of(context).colorScheme.outline,
                  width: AppDimensions.borderWidth,
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  TrKeys.controlDrawerTitle.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const StackTree(),
          // Main content
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [ProjectTree()],
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
                  color: Theme.of(context).colorScheme.outline,
                  width: AppDimensions.borderWidth,
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ThemeButton(),
                const SizedBox(height: AppDimensions.paddingSmall),
                CustomButton(
                  textColor: Theme.of(context).colorScheme.onSurface,
                  leading: const Icon(Broken.setting_2),
                  text: TrKeys.settings.tr(),
                  onPressed: () {
                    CustomPageOverlay.show(
                      context: context,
                      child: const SettingsWidget(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
