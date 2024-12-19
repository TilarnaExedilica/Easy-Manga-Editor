import 'package:easy_localization/easy_localization.dart';
import 'package:easy_manga_editor/app/theme/bloc/theme_bloc.dart';
import 'package:easy_manga_editor/app/theme/bloc/theme_event.dart';
import 'package:easy_manga_editor/app/theme/bloc/theme_state.dart';
import 'package:easy_manga_editor/app/tr/tr_keys.dart';
import 'package:easy_manga_editor/screens/settings/setting_item.dart';
import 'package:easy_manga_editor/screens/settings/setting_section.dart';
import 'package:flutter/material.dart';
import 'package:easy_manga_editor/app/theme/styles/broken_icons.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';
import 'package:easy_manga_editor/app/theme/styles/text_styles.dart';
import 'package:easy_manga_editor/screens/settings/setting_selection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                SettingsItem(title: TrKeys.remindAlertChangePage.tr()),
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
                    SettingOption(label: '日本語', value: 'ja'),
                    SettingOption(label: '한국어', value: 'ko'),
                    SettingOption(label: '中文', value: 'zh'),
                    SettingOption(label: 'Français', value: 'fr'),
                    SettingOption(label: 'Deutsch', value: 'de'),
                    SettingOption(label: 'Italiano', value: 'it'),
                    SettingOption(label: 'Português', value: 'pt'),
                    SettingOption(label: 'Русский', value: 'ru'),
                    SettingOption(label: 'Español', value: 'es'),
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
