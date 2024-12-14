import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_manga_editor/features/permission/permission_bloc.dart';
import 'dart:io';
import 'package:easy_manga_editor/shared/widgets/dialogs/custom_dialog.dart';

class ProjectTree extends StatelessWidget {
  const ProjectTree({super.key});

  Widget _buildFolderList(Directory directory) {
    final folders = directory
        .listSync()
        .whereType<Directory>()
        .map((dir) => dir.path.split('/').last)
        .toList();

    return folders.isEmpty
        ? const Center(
            child: Text('Không có thư mục nào trong Easy Manga Editor.'))
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: folders.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.folder),
                title: Text(folders[index]),
              );
            },
          );
  }

  void _showPermissionDialog(BuildContext context) {
    CustomDialog.show(
      context: context,
      title: 'Cấp Quyền Truy Cập',
      children: const [
        Text(
            'Ứng dụng cần quyền truy cập bộ nhớ để tạo và quản lý thư mục dự án.'),
      ],
      onConfirm: () {
        context.read<PermissionBloc>().add(CheckPermission());
        Navigator.pop(context);
      },
      onCancel: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PermissionBloc()..add(CheckPermission()),
      child: BlocConsumer<PermissionBloc, PermissionState>(
        listener: (context, state) {
          if (state.message != null) {
            CustomDialog.show(
              context: context,
              title: 'Thông Báo',
              children: [
                Text(state.message!),
              ],
              onConfirm: () {
                Navigator.pop(context);
                if (state.isPermissionGranted && !state.isFolderCreated) {
                  context.read<PermissionBloc>().add(CreateFolder());
                }
              },
              onCancel: () {
                Navigator.pop(context);
              },
            );
          }
        },
        builder: (context, state) {
          if (!state.isPermissionGranted) {
            return Center(
              child: ElevatedButton(
                onPressed: () => _showPermissionDialog(context),
                child: const Text('Cấp Quyền Truy Cập'),
              ),
            );
          }

          final directory = Directory('${state.storagePath}/Easy Manga Editor');

          if (!directory.existsSync()) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<PermissionBloc>().add(CreateFolder());
                },
                child: const Text('Tạo Thư Mục Easy Manga Editor'),
              ),
            );
          }

          return _buildFolderList(directory);
        },
      ),
    );
  }
}
