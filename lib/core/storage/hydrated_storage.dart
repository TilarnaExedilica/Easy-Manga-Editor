import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

class AppHydratedStorage {
  static Future<HydratedStorage> init() async {
    final storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory(),
    );
    return storage;
  }
}
