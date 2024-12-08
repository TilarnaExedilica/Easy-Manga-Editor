import 'package:easy_manga_editor/app/routes/app_router.dart';
import 'package:easy_manga_editor/shared/widgets/scaffold/extend_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_manga_editor/shared/widgets/drawer/source_drawer.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendScaffold(
      leftDrawer: const SourceDrawer(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.router.push(const StudioRoute());
          },
          child: const Text('Mở Studio'),
        ),
      ),
    );
  }
}
