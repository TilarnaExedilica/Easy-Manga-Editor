import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_manga_editor/app/theme/bloc/theme_bloc.dart';
import 'package:easy_manga_editor/app/theme/bloc/theme_event.dart';
import 'package:easy_manga_editor/app/theme/bloc/theme_state.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildThemeOption(
                context,
                Icons.settings,
                ThemeMode.system,
                state.themeMode,
              ),
              _buildThemeOption(
                context,
                Icons.light_mode,
                ThemeMode.light,
                state.themeMode,
              ),
              _buildThemeOption(
                context,
                Icons.dark_mode,
                ThemeMode.dark,
                state.themeMode,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    IconData icon,
    ThemeMode mode,
    ThemeMode currentMode,
  ) {
    final isSelected = mode == currentMode;
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () => context.read<ThemeBloc>().add(ChangeTheme(mode)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: isSelected
              ? Theme.of(context).colorScheme.secondaryContainer
              : Colors.transparent,
        ),
        child: Icon(
          icon,
          size: 20,
          color: isSelected
              ? Theme.of(context).colorScheme.onSecondaryContainer
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
