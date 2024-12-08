import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_manga_editor/app/di/injection.dart';
import 'package:easy_manga_editor/app/routes/app_router.dart';
import 'package:easy_manga_editor/app/theme/bloc/theme_bloc.dart';
import 'package:easy_manga_editor/app/theme/bloc/theme_event.dart';
import 'package:easy_manga_editor/app/theme/bloc/theme_state.dart';
import 'package:easy_manga_editor/app/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_manga_editor/core/utils/constants/app_constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
      );
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarContrastEnforced: false,
          systemNavigationBarColor: Color(0x00000000),
          systemNavigationBarDividerColor: Color(0x00000000),
          statusBarColor: Color(0x00000000),
        ),
      );
    });

    final appRouter = getIt<AppRouter>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ThemeBloc>()..add(LoadTheme()),
        ),
      ],
      child: BlocConsumer<ThemeBloc, ThemeState>(
        listener: (context, state) {
          final isDark = state.themeMode == ThemeMode.dark ||
              (state.themeMode == ThemeMode.system &&
                  MediaQuery.platformBrightnessOf(context) == Brightness.dark);

          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              systemNavigationBarContrastEnforced: false,
              systemNavigationBarColor: const Color(0x00000000),
              systemNavigationBarDividerColor: const Color(0x00000000),
              systemNavigationBarIconBrightness:
                  isDark ? Brightness.light : Brightness.dark,
              statusBarColor: const Color(0x00000000),
              statusBarIconBrightness:
                  isDark ? Brightness.light : Brightness.dark,
              statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
            ),
          );
        },
        builder: (context, state) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: const Color(0x00000000),
              statusBarIconBrightness: state.themeMode == ThemeMode.dark
                  ? Brightness.light
                  : Brightness.dark,
              statusBarBrightness: state.themeMode == ThemeMode.dark
                  ? Brightness.dark
                  : Brightness.light,
            ),
            child: MaterialApp.router(
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: state.themeMode,
              routerConfig: appRouter.config(),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
            ),
          );
        },
      ),
    );
  }
}
