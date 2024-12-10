import 'package:easy_manga_editor/app/routes/app_router.dart';
import 'package:easy_manga_editor/shared/widgets/dialogs/confirm_dialog.dart';
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
            ElevatedButton(
              onPressed: () {
                context.router.push(const StudioRoute());
              },
              child: const Text('Mở Studio'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const ConfirmDialog(
                    title: 'Test Popup',
                    message: 'This is a test popup',
                  ),
                );
              },
              child: const Text('Test Popup'),
            ),
          ],
        ),
      ),
    );
  }
}
