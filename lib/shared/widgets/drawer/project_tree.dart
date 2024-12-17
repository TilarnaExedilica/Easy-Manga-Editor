import 'package:easy_localization/easy_localization.dart';
import 'package:easy_manga_editor/app/l10n/tr_keys.dart';
import 'package:easy_manga_editor/shared/widgets/buttons/app_button.dart';
import 'package:easy_manga_editor/shared/widgets/loading/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_manga_editor/features/permission/permission_bloc.dart';
import 'dart:io';
import 'package:easy_manga_editor/shared/widgets/dialogs/custom_dialog.dart';
import 'package:easy_manga_editor/app/theme/styles/dimensions.dart';

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
        if (folders.isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: AppDimensions.treeIndentation),
            child: Text(TrKeys.noSubfolders.tr()),
          )
        else
          ...folders.map(
            (folder) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.treeItemPadding,
                vertical: AppDimensions.treeItemSpacing,
              ),
              child: AppButton(
                onPressed: () {},
                isExpand: true,
                text: folder,
              ),
            ),
          ),
      ],
    );
  }

  void _showPermissionDialog(BuildContext context) {
    CustomDialog.show(
      context: context,
      title: TrKeys.accessPermission.tr(),
      children: [
        Text(TrKeys.permissionMessage.tr()),
      ],
      onConfirm: () {
        context.read<PermissionBloc>().add(RequestPermission());
      },
      onCancel: () {},
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
              title: TrKeys.notification.tr(),
              children: [Text(state.message!)],
              cancelText: TrKeys.confirm.tr(),
              onCancel: () {},
            );
          }
        },
        builder: (context, state) {
          if (!state.isPermissionGranted) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.treeButtonPadding),
                child: AppButton(
                  onPressed: () => _showPermissionDialog(context),
                  text: TrKeys.managePermissions.tr(),
                ),
              ),
            );
          }

          if (!state.isFolderCreated || state.folderPath == null) {
            return const Center(
              child: SizedBox(
                width: AppDimensions.treeProgressSize,
                height: AppDimensions.treeProgressSize,
                child: LoadingIndicator(),
              ),
            );
          }

          final directory = Directory(state.folderPath!);
          if (!directory.existsSync()) {
            return Center(
              child: Text(TrKeys.folderNotFound.tr()),
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
