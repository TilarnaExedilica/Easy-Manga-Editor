abstract class SettingsEvent {}

class LoadSettings extends SettingsEvent {}

class ChangeRemindAlertChangePage extends SettingsEvent {
  final bool value;

  ChangeRemindAlertChangePage(this.value);
}
