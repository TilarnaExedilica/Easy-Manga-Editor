import 'package:hydrated_bloc/hydrated_bloc.dart';

abstract class BaseHydratedBloc<Event, State>
    extends HydratedBloc<Event, State> {
  BaseHydratedBloc(super.initialState);

  @override
  Map<String, dynamic>? toJson(State state) {
    try {
      return (state as dynamic).toJson();
    } catch (_) {
      return null;
    }
  }

  @override
  State? fromJson(Map<String, dynamic> json) {
    try {
      return fromJsonMap(json);
    } catch (_) {
      return null;
    }
  }

  State? fromJsonMap(Map<String, dynamic> json);
}
