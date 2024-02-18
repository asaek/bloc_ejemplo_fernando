import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    bool isDarkmode = false,
  }) : super(ThemeState(isDarkmode: isDarkmode));

  void toggleTheme() {
    emit(ThemeState(isDarkmode: !state.isDarkmode));
  }

  void setDarkMode() {
    emit(const ThemeState(isDarkmode: true));
  }

  void setLightMode() {
    emit(const ThemeState(isDarkmode: false));
  }
}
