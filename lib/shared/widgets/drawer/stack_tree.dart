import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_manga_editor/app/routes/app_router.dart';
import 'package:easy_manga_editor/app/theme/styles/text_styles.dart';
import 'package:easy_manga_editor/app/theme/styles/broken_icons.dart';

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
            Text(
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
          ],
        ],
      ),
    );
  }
}
