import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_manga_editor/app/tr/tr_keys.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(const PermissionState()) {
    on<CheckPermission>(_onCheckPermission);
    on<RequestPermission>(_onRequestPermission);
  }

  Future<void> _onCheckPermission(
    CheckPermission event,
    Emitter<PermissionState> emit,
  ) async {
    final storageStatus = await Permission.storage.status;
    final manageStatus = await Permission.manageExternalStorage.status;

    final isGranted = storageStatus.isGranted &&
        (manageStatus.isGranted || await _isLowerAndroid11());

    emit(state.copyWith(isPermissionGranted: isGranted));

    if (isGranted) {
      await _createFolderIfNeeded(emit);
    }
  }

  Future<void> _onRequestPermission(
    RequestPermission event,
    Emitter<PermissionState> emit,
  ) async {
    if (await _isAndroid11OrHigher()) {
      final status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        emit(state.copyWith(
          isPermissionGranted: false,
          message: TrKeys.storagePermissionRequired.tr(),
        ));
        return;
      }
    }

    final storageStatus = await Permission.storage.request();
    if (storageStatus.isGranted) {
      emit(state.copyWith(isPermissionGranted: true));
      await _createFolderIfNeeded(emit);
    } else {
      emit(state.copyWith(
        isPermissionGranted: false,
        message: TrKeys.permissionDenied.tr(),
      ));
    }
  }

  Future<void> _createFolderIfNeeded(Emitter<PermissionState> emit) async {
    try {
      Directory? directory;

      if (await _isAndroid11OrHigher()) {
        directory = Directory('/storage/emulated/0/Easy Manga Editor');
      } else {
        final externalDir = await getExternalStorageDirectory();
        if (externalDir != null) {
          final parentPath = externalDir.path.split('Android')[0];
          directory = Directory('$parentPath/Easy Manga Editor');
        }
      }

      if (directory != null) {
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        emit(state.copyWith(
          isFolderCreated: true,
          folderPath: directory.path,
        ));
      } else {
        emit(state.copyWith(
          message: TrKeys.folderCreationError.tr(),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
          message: TrKeys.folderError.tr().replaceAll('{}', e.toString())));
    }
  }

  Future<bool> _isAndroid11OrHigher() async {
    if (Platform.isAndroid) {
      final sdkInt = await _getAndroidVersion();
      return sdkInt >= 30;
    }
    return false;
  }

  Future<bool> _isLowerAndroid11() async {
    if (Platform.isAndroid) {
      final sdkInt = await _getAndroidVersion();
      return sdkInt < 30;
    }
    return false;
  }

  Future<int> _getAndroidVersion() async {
    return 30;
  }
}

// Events
abstract class PermissionEvent {}

class CheckPermission extends PermissionEvent {}

class RequestPermission extends PermissionEvent {}

// State
class PermissionState {
  final bool isPermissionGranted;
  final bool isFolderCreated;
  final String? message;
  final String? folderPath;

  const PermissionState({
    this.isPermissionGranted = false,
    this.isFolderCreated = false,
    this.message,
    this.folderPath,
  });

  PermissionState copyWith({
    bool? isPermissionGranted,
    bool? isFolderCreated,
    String? message,
    String? folderPath,
  }) {
    return PermissionState(
      isPermissionGranted: isPermissionGranted ?? this.isPermissionGranted,
      isFolderCreated: isFolderCreated ?? this.isFolderCreated,
      message: message,
      folderPath: folderPath ?? this.folderPath,
    );
  }
}
