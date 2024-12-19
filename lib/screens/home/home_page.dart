import 'package:easy_localization/easy_localization.dart';
import 'package:easy_manga_editor/app/routes/app_router.dart';
import 'package:easy_manga_editor/app/theme/styles/broken_icons.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';
import 'package:easy_manga_editor/app/tr/tr_icon.dart';
import 'package:easy_manga_editor/app/tr/tr_keys.dart';
import 'package:easy_manga_editor/app/theme/styles/colors.dart';
import 'package:easy_manga_editor/app/theme/styles/text_styles.dart';
import 'package:easy_manga_editor/shared/widgets/buttons/icon_button.dart';
import 'package:easy_manga_editor/shared/widgets/scaffold/extend_scaffold.dart';
import 'package:easy_manga_editor/shared/widgets/search/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_manga_editor/shared/widgets/drawer/control_drawer.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendScaffold(
      backgroundColor: AppColors.customGreyBlue,
      nativeColor: AppColors.customGreyBlue,
      leftDrawer: const ControlDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              TrIcon.ww01,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: AppDimensions.spacingExtraLarge),
              Text(
                TrKeys.appName.tr(),
                style: AppTextStyles.h2.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppDimensions.spacingExtraLarge),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: 300,
                  child: SearchWidget(
                    hintText: TrKeys.placeholder_search.tr(),
                    onChanged: (value) {},
                    onSearch: () {},
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spacingMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppIconButton(
                    icon: Broken.add_square,
                    color: AppColors.textDark,
                    onPressed: () {
                      context.router.push(const StudioRoute());
                    },
                  ),
                  const SizedBox(width: AppDimensions.spacingMedium),
                  AppIconButton(
                    icon: Broken.document_code_2,
                    color: AppColors.textDark,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
