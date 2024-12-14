import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_manga_editor/features/permission/permission_bloc.dart';
import 'dart:io';
import 'package:easy_manga_editor/shared/widgets/dialogs/custom_dialog.dart';

class ProjectTree extends StatelessWidget {
  const ProjectTree({super.key});

  Widget _buildFolderStructure(Directory directory) {
    final folders = directory
        .listSync()
        .whereType<Directory>()
        .map((dir) => dir.path.split('/').last)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.folder),
              SizedBox(width: 8),
              Text('Easy Manga Editor'),
            ],
          ),
        ),
        if (folders.isEmpty)
          const Padding(
            padding: EdgeInsets.only(left: 32.0),
            child: Text('(Chưa có thư mục con)'),
          )
        else
          ...folders.map((folder) => Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Row(
                  children: [
                    const Text('└── '),
                    const Icon(Icons.folder, size: 20),
                    const SizedBox(width: 8),
                    Text(folder),
                  ],
                ),
              )),
      ],
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
        context.read<PermissionBloc>().add(RequestPermission());
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
              children: [Text(state.message!)],
              onConfirm: () => Navigator.pop(context),
              onCancel: () => Navigator.pop(context),
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

          if (!state.isFolderCreated || state.folderPath == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final directory = Directory(state.folderPath!);
          if (!directory.existsSync()) {
            return const Center(
              child: Text('Không tìm thấy thư mục Easy Manga Editor'),
            );
          }

          return SingleChildScrollView(
            child: _buildFolderStructure(directory),
          );
        },
      ),
    );
  }
}
