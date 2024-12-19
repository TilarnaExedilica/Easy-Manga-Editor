import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:easy_manga_editor/features/settings/settings_event.dart';
import 'package:easy_manga_editor/features/settings/settings_state.dart';

@injectable
class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<ChangeRemindAlertChangePage>(_onChangeRemindAlertChangePage);
  }

  void _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) {
  }

  void _onChangeRemindAlertChangePage(
      ChangeRemindAlertChangePage event, Emitter<SettingsState> emit) {
    emit(state.copyWith(remindAlertChangePage: event.value));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState(
      remindAlertChangePage: json['remindAlertChangePage'] ?? true,
    );
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return {
      'remindAlertChangePage': state.remindAlertChangePage,
    };
  }
}
