import 'package:easy_manga_editor/screens/settings/setting_item.dart';
import 'package:easy_manga_editor/screens/settings/setting_section.dart';
import 'package:flutter/material.dart';
import 'package:easy_manga_editor/app/theme/styles/broken_icons.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';
import 'package:easy_manga_editor/app/theme/styles/text_styles.dart';
import 'package:easy_manga_editor/screens/settings/setting_selection.dart';

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
            const Padding(
              padding: EdgeInsets.only(
                bottom: AppDimensions.padding,
              ),
              child: Text(
                'Cài đặt',
                style: AppTextStyles.h3,
              ),
            ),
            SettingSection(
              icon: Broken.autobrightness,
              title: 'Chủ đề',
              children: [
                SettingSelection(
                  items: const ['Tự động', 'Tối', 'Sáng'],
                  selectedItem: 'Tự động',
                  onChanged: (value) {},
                ),
              ],
            ),
            const SettingSection(
              icon: Broken.alarm,
              title: 'Thông báo',
              children: [
                SettingsItem(title: 'Nhắc chuyển trang'),
              ],
            ),
            SettingSection(
              icon: Broken.translate,
              title: 'Ngôn ngữ',
              children: [
                SettingSelection(
                  items: const [
                    'English',
                    'Tiếng Việt',
                    '日本語',
                    '한국어',
                    '中文',
                    'Français',
                    'Deutsch',
                    'Italiano',
                    'Português',
                    'Русский',
                    'Español',
                  ],
                  selectedItem: 'English',
                  onChanged: (value) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
