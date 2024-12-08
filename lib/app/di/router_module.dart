import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RouterModule {
  @singleton
  AutoRouter get router => const AutoRouter();
}
