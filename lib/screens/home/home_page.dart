import 'package:easy_manga_editor/app/routes/app_router.dart';
import 'package:easy_manga_editor/app/theme/styles/colors.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';
import 'package:easy_manga_editor/app/theme/styles/text_styles.dart';
import 'package:easy_manga_editor/shared/widgets/buttons/app_button.dart';
import 'package:easy_manga_editor/shared/widgets/dialogs/custom_dialog.dart';
import 'package:easy_manga_editor/shared/widgets/scaffold/extend_scaffold.dart';
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
              'assets/icons/ww_01.png',
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 60),
              Text(
                'Easy Manga Editor',
                style: AppTextStyles.h2.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 120),
              AppButton(
                text: 'Mở Studio',
                onPressed: () {
                  context.router.push(const StudioRoute());
                },
              ),
              const SizedBox(height: 16),
              AppButton(
                text: 'Test Popup',
                onPressed: () {
                  CustomDialog.show(
                    context: context,
                    children: [
                      const Text('Thoát', style: AppTextStyles.h3),
                      const SizedBox(height: AppDimensions.spacingSmall),
                      const Text('Bạn có muốn thoát không?',
                          style: AppTextStyles.bodyMedium),
                      const Text('Dữ liệu sẽ được lưu lại',
                          style: AppTextStyles.bodyMedium),
                      const SizedBox(height: AppDimensions.spacingLarge),
                    ],
                    onConfirm: () {},
                    onCancel: () {},
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
