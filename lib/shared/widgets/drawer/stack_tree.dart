import 'package:easy_localization/easy_localization.dart';
import 'package:easy_manga_editor/app/tr/tr_keys.dart';
import 'package:easy_manga_editor/features/settings/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_manga_editor/app/routes/app_router.dart';
import 'package:easy_manga_editor/app/theme/styles/text_styles.dart';
import 'package:easy_manga_editor/app/theme/styles/broken_icons.dart';
import 'package:easy_manga_editor/shared/widgets/dialogs/custom_dialog.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';
import 'package:easy_manga_editor/shared/widgets/inputs/custom_checkbox.dart';
import 'package:easy_manga_editor/features/settings/settings_bloc.dart';
import 'package:easy_manga_editor/features/settings/settings_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StackTree extends StatelessWidget {
  const StackTree({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final stack = router.stack;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1.5,
          ),
        ),
      ),
      child: Row(
        children: [
          for (var i = 0; i < stack.length; i++) ...[
            if (i > 0) ...[
              const SizedBox(width: 8),
              Icon(
                Broken.arrow_right_3,
                size: 16,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
              const SizedBox(width: 8),
            ],
            InkWell(
              onTap: () async {
                if (i < stack.length - 1) {
                  final routesToPop = stack.length - i - 1;
                  final settingsBloc = context.read<SettingsBloc>();
                  final settingsState = settingsBloc.state;

                  if (!settingsState.remindAlertChangePage) {
                    for (var j = 0; j < routesToPop; j++) {
                      await router.navigatorKey.currentState?.maybePop();
                    }
                    return;
                  }

                  await CustomDialog.show(
                    context: context,
                    title: TrKeys.titleAlertChangePage.tr(),
                    children: [
                      Text(TrKeys.messageAlertChangePage.tr()),
                      const SizedBox(height: AppDimensions.spacingLarge),
                      BlocBuilder<SettingsBloc, SettingsState>(
                        builder: (context, state) {
                          return CustomCheckbox(
                            label: TrKeys.dontRemindMe.tr(),
                            value: !state.remindAlertChangePage,
                            onChanged: (value) {
                              settingsBloc.add(
                                ChangeRemindAlertChangePage(!value),
                              );
                            },
                            activeColor: Theme.of(context).colorScheme.primary,
                            checkColor: Colors.white,
                          );
                        },
                      ),
                    ],
                    onConfirm: () async {
                      for (var j = 0; j < routesToPop; j++) {
                        await router.navigatorKey.currentState?.maybePop();
                      }
                    },
                  );
                }
              },
              child: Text(
                AppRoute.values
                    .firstWhere(
                      (route) =>
                          route.name ==
                          stack[i].name?.replaceAll('Route', '').toLowerCase(),
                      orElse: () => AppRoute.home,
                    )
                    .name
                    .tr(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: i == stack.length - 1
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
