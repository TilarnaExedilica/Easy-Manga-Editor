import 'package:easy_localization/easy_localization.dart';
import 'package:easy_manga_editor/app/theme/bloc/theme_bloc.dart';
import 'package:easy_manga_editor/app/theme/bloc/theme_event.dart';
import 'package:easy_manga_editor/app/theme/bloc/theme_state.dart';
import 'package:easy_manga_editor/app/theme/styles/colors.dart';
import 'package:easy_manga_editor/app/tr/tr_keys.dart';
import 'package:easy_manga_editor/screens/settings/setting_section.dart';
import 'package:easy_manga_editor/shared/widgets/inputs/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:easy_manga_editor/app/theme/styles/broken_icons.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';
import 'package:easy_manga_editor/app/theme/styles/text_styles.dart';
import 'package:easy_manga_editor/screens/settings/setting_selection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_manga_editor/features/settings/settings_bloc.dart';
import 'package:easy_manga_editor/features/settings/settings_event.dart';
import 'package:easy_manga_editor/features/settings/settings_state.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppDimensions.padding,
              ),
              child: Text(
                TrKeys.settings.tr(),
                style: AppTextStyles.h3,
              ),
            ),
            SettingSection(
              icon: Broken.autobrightness,
              title: TrKeys.theme.tr(),
              children: [
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    return SettingSelection(
                      items: [
                        SettingOption(
                          label: TrKeys.auto.tr(),
                          value: ThemeMode.system.toString(),
                        ),
                        SettingOption(
                          label: TrKeys.light.tr(),
                          value: ThemeMode.light.toString(),
                        ),
                        SettingOption(
                          label: TrKeys.dark.tr(),
                          value: ThemeMode.dark.toString(),
                        ),
                      ],
                      selectedItem: state.themeMode.toString(),
                      onChanged: (value) {
                        context.read<ThemeBloc>().add(
                              ChangeTheme(ThemeMode.values.firstWhere(
                                (e) => e.toString() == value,
                              )),
                            );
                      },
                    );
                  },
                ),
              ],
            ),
            SettingSection(
              icon: Broken.alarm,
              title: TrKeys.notification.tr(),
              children: [
                BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) {
                    return CustomCheckbox(
                      label: TrKeys.remindAlertChangePage.tr(),
                      value: state.remindAlertChangePage,
                      onChanged: (value) {
                        context.read<SettingsBloc>().add(
                              ChangeRemindAlertChangePage(value),
                            );
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                      checkColor: AppColors.textDark,
                    );
                  },
                ),
              ],
            ),
            SettingSection(
              icon: Broken.translate,
              title: TrKeys.language.tr(),
              children: [
                SettingSelection(
                  items: const [
                    SettingOption(label: 'English', value: 'en'),
                    SettingOption(label: 'Tiếng Việt', value: 'vi'),
                  ],
                  selectedItem: context.locale.languageCode,
                  onChanged: (value) {
                    context.setLocale(Locale(value));
                    WidgetsBinding.instance.reassembleApplication();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
