import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_manga_editor/app/l10n/tr_keys.dart';
import 'package:easy_manga_editor/shared/widgets/buttons/theme_button.dart';
import 'package:easy_manga_editor/core/utils/constants/ui_constants.dart';

class SourceDrawer extends StatelessWidget {
  const SourceDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UIConstants.drawerWidth,
      color: Theme.of(context).drawerTheme.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                TrKeys.home.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const ThemeButton(),
          ],
        ),
      ),
    );
  }
}
