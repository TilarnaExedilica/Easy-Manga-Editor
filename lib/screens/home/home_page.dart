import 'package:easy_manga_editor/app/routes/app_router.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';
import 'package:easy_manga_editor/app/theme/styles/text_styles.dart';
import 'package:easy_manga_editor/shared/widgets/buttons/app_button.dart';
import 'package:easy_manga_editor/shared/widgets/dialogs/custom_dialog.dart';
import 'package:easy_manga_editor/shared/widgets/scaffold/extend_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_manga_editor/shared/widgets/drawer/control_drawer.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendScaffold(
      leftDrawer: const ControlDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
      ),
    );
  }
}
