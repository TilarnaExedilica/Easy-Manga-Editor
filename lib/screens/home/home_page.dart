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
import 'package:easy_manga_editor/shared/widgets/overlay/custom_page_overlay.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearching = false;

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
                    isSearching: _isSearching,
                    resultSearch: ListView.builder(
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(
                              Broken.user,
                            ),
                          ),
                          title: Text(
                            'Tiêu đề mẫu ${index + 1}',
                            style: AppTextStyles.bodyLarge,
                          ),
                          subtitle: Text(
                            'Nội dung phụ cho mục ${index + 1}',
                            style: AppTextStyles.bodySmall,
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Broken.document_download,
                            ),
                            onPressed: () {},
                          ),
                        );
                      },
                    ),
                    onSearch: () {
                      setState(() {
                        _isSearching = !_isSearching;
                      });
                    },
                    onChanged: (value) {},
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
                    icon: Broken.information,
                    color: AppColors.textDark,
                    onPressed: () {
                      CustomPageOverlay.show(
                        context: context,
                        child: const Center(),
                      );
                    },
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
