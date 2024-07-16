sealed class ThemeModeState {}

final class InitialThemeModeState extends ThemeModeState {}

final class LoadingThemeModeState extends ThemeModeState {}

final class LoadedThemeModeState extends ThemeModeState {}

final class ErrorThemeModeState extends ThemeModeState {
  final String message;

  ErrorThemeModeState(this.message);
}
