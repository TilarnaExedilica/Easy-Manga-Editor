import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

abstract class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object> get props => [];
}

class CheckPermission extends PermissionEvent {}

class CreateFolder extends PermissionEvent {}

class PermissionState extends Equatable {
  final bool isPermissionGranted;
  final bool isFolderCreated;
  final String? message;
  final String? storagePath;

  const PermissionState({
    required this.isPermissionGranted,
    required this.isFolderCreated,
    this.message,
    this.storagePath,
  });

  PermissionState copyWith({
    bool? isPermissionGranted,
    bool? isFolderCreated,
    String? message,
    String? storagePath,
  }) {
    return PermissionState(
      isPermissionGranted: isPermissionGranted ?? this.isPermissionGranted,
      isFolderCreated: isFolderCreated ?? this.isFolderCreated,
      message: message,
      storagePath: storagePath ?? this.storagePath,
    );
  }

  @override
  List<Object?> get props =>
      [isPermissionGranted, isFolderCreated, message, storagePath];
}

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc()
      : super(const PermissionState(
          isPermissionGranted: false,
          isFolderCreated: false,
        )) {
    on<CheckPermission>(_onCheckPermission);
    on<CreateFolder>(_onCreateFolder);
  }

  Future<void> _onCheckPermission(
      CheckPermission event, Emitter<PermissionState> emit) async {
    final status = await Permission.storage.status;
    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();
      emit(state.copyWith(
        isPermissionGranted: true,
        message: 'Đã có quyền truy cập.',
        storagePath: externalDir?.path,
      ));
    } else {
      final result = await Permission.storage.request();
      if (result.isGranted) {
        final externalDir = await getExternalStorageDirectory();
        emit(state.copyWith(
          isPermissionGranted: true,
          message: 'Quyền truy cập được cấp.',
          storagePath: externalDir?.path,
        ));
        add(CreateFolder());
      } else {
        emit(state.copyWith(
          isPermissionGranted: false,
          message: 'Quyền truy cập bị từ chối.',
        ));
      }
    }
  }

  Future<void> _onCreateFolder(
      CreateFolder event, Emitter<PermissionState> emit) async {
    if (!state.isPermissionGranted) {
      emit(state.copyWith(message: 'Chưa có quyền truy cập.'));
      return;
    }

    try {
      final path = '${state.storagePath}/Easy Manga Editor';
      final folder = Directory(path);

      if (!(await folder.exists())) {
        await folder.create(recursive: true);
        emit(state.copyWith(
          isFolderCreated: true,
          message: 'Đã tạo thư mục thành công.',
        ));
      } else {
        emit(state.copyWith(
          isFolderCreated: true,
          message: 'Thư mục đã tồn tại.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Lỗi khi tạo thư mục: $e'));
    }
  }
}
