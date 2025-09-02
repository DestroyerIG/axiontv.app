import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  final bool isDarkMode;
  final String language;
  final String defaultQuality;
  final bool autoPlay;
  final bool showSubtitles;
  final String subtitleLanguage;
  final bool parentalControl;
  final String parentalRating;
  final bool notifications;
  final bool autoUpdate;
  final int cacheSize;
  final bool hardwareAcceleration;

  AppSettings({
    this.isDarkMode = false,
    this.language = 'pt_BR',
    this.defaultQuality = 'Auto',
    this.autoPlay = true,
    this.showSubtitles = false,
    this.subtitleLanguage = 'pt',
    this.parentalControl = false,
    this.parentalRating = 'L',
    this.notifications = true,
    this.autoUpdate = true,
    this.cacheSize = 100,
    this.hardwareAcceleration = true,
  });

  AppSettings copyWith({
    bool? isDarkMode,
    String? language,
    String? defaultQuality,
    bool? autoPlay,
    bool? showSubtitles,
    String? subtitleLanguage,
    bool? parentalControl,
    String? parentalRating,
    bool? notifications,
    bool? autoUpdate,
    int? cacheSize,
    bool? hardwareAcceleration,
  }) {
    return AppSettings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
      defaultQuality: defaultQuality ?? this.defaultQuality,
      autoPlay: autoPlay ?? this.autoPlay,
      showSubtitles: showSubtitles ?? this.showSubtitles,
      subtitleLanguage: subtitleLanguage ?? this.subtitleLanguage,
      parentalControl: parentalControl ?? this.parentalControl,
      parentalRating: parentalRating ?? this.parentalRating,
      notifications: notifications ?? this.notifications,
      autoUpdate: autoUpdate ?? this.autoUpdate,
      cacheSize: cacheSize ?? this.cacheSize,
      hardwareAcceleration: hardwareAcceleration ?? this.hardwareAcceleration,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_dark_mode': isDarkMode,
      'language': language,
      'default_quality': defaultQuality,
      'auto_play': autoPlay,
      'show_subtitles': showSubtitles,
      'subtitle_language': subtitleLanguage,
      'parental_control': parentalControl,
      'parental_rating': parentalRating,
      'notifications': notifications,
      'auto_update': autoUpdate,
      'cache_size': cacheSize,
      'hardware_acceleration': hardwareAcceleration,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      isDarkMode: json['is_dark_mode'] ?? false,
      language: json['language'] ?? 'pt_BR',
      defaultQuality: json['default_quality'] ?? 'Auto',
      autoPlay: json['auto_play'] ?? true,
      showSubtitles: json['show_subtitles'] ?? false,
      subtitleLanguage: json['subtitle_language'] ?? 'pt',
      parentalControl: json['parental_control'] ?? false,
      parentalRating: json['parental_rating'] ?? 'L',
      notifications: json['notifications'] ?? true,
      autoUpdate: json['auto_update'] ?? true,
      cacheSize: json['cache_size'] ?? 100,
      hardwareAcceleration: json['hardware_acceleration'] ?? true,
    );
  }
}

class SettingsState {
  final AppSettings settings;
  final bool isLoading;
  final String? error;

  SettingsState({
    required this.settings,
    this.isLoading = false,
    this.error,
  });

  SettingsState copyWith({
    AppSettings? settings,
    bool? isLoading,
    String? error,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState(settings: AppSettings())) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsJson = prefs.getString('app_settings');
      
      if (settingsJson != null) {
        final settings = AppSettings.fromJson(
          Map<String, dynamic>.from(
            // Aqui você pode usar jsonDecode se necessário
            // Por enquanto, vamos usar um Map simples
            {'is_dark_mode': false, 'language': 'pt_BR'}
          ),
        );
        state = state.copyWith(settings: settings);
      }
    } catch (e) {
      // Usar configurações padrão em caso de erro
    }
  }

  Future<void> updateSettings(AppSettings newSettings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('app_settings', newSettings.toJson().toString());
      
      state = state.copyWith(settings: newSettings);
    } catch (e) {
      state = state.copyWith(
        error: 'Erro ao salvar configurações: ${e.toString()}',
      );
    }
  }

  void toggleDarkMode() {
    final newSettings = state.settings.copyWith(
      isDarkMode: !state.settings.isDarkMode,
    );
    updateSettings(newSettings);
  }

  void setLanguage(String language) {
    final newSettings = state.settings.copyWith(language: language);
    updateSettings(newSettings);
  }

  void setDefaultQuality(String quality) {
    final newSettings = state.settings.copyWith(defaultQuality: quality);
    updateSettings(newSettings);
  }

  void toggleAutoPlay() {
    final newSettings = state.settings.copyWith(
      autoPlay: !state.settings.autoPlay,
    );
    updateSettings(newSettings);
  }

  void toggleSubtitles() {
    final newSettings = state.settings.copyWith(
      showSubtitles: !state.settings.showSubtitles,
    );
    updateSettings(newSettings);
  }

  void setSubtitleLanguage(String language) {
    final newSettings = state.settings.copyWith(subtitleLanguage: language);
    updateSettings(newSettings);
  }

  void toggleParentalControl() {
    final newSettings = state.settings.copyWith(
      parentalControl: !state.settings.parentalControl,
    );
    updateSettings(newSettings);
  }

  void setParentalRating(String rating) {
    final newSettings = state.settings.copyWith(parentalRating: rating);
    updateSettings(newSettings);
  }

  void toggleNotifications() {
    final newSettings = state.settings.copyWith(
      notifications: !state.settings.notifications,
    );
    updateSettings(newSettings);
  }

  void toggleAutoUpdate() {
    final newSettings = state.settings.copyWith(
      autoUpdate: !state.settings.autoUpdate,
    );
    updateSettings(newSettings);
  }

  void setCacheSize(int size) {
    final newSettings = state.settings.copyWith(cacheSize: size);
    updateSettings(newSettings);
  }

  void toggleHardwareAcceleration() {
    final newSettings = state.settings.copyWith(
      hardwareAcceleration: !state.settings.hardwareAcceleration,
    );
    updateSettings(newSettings);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void resetToDefaults() {
    updateSettings(AppSettings());
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) => SettingsNotifier(),
);
