import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppConstants {
  // Informações da aplicação
  static const String appName = 'Axion TV';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Reprodutor IPTV moderno para múltiplas plataformas';
  
  // Cores principais
  static const Color primaryColor = Color(0xFF1E88E5);
  static const Color secondaryColor = Color(0xFF1565C0);
  static const Color accentColor = Color(0xFF42A5F5);
  static const Color backgroundColor = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color textSecondaryColor = Color(0xFFB0B0B0);
  
  // Durações
  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration snackbarDuration = Duration(seconds: 4);
  
  // Tamanhos
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double buttonHeight = 48.0;
  
  // URLs e endpoints
  static const String baseUrl = 'https://api.axiontv.com';
  static const String epgUrl = 'https://epg.axiontv.com';
  
  // Chaves de armazenamento
  static const String authTokenKey = 'auth_token';
  static const String userPreferencesKey = 'user_preferences';
  static const String favoritesKey = 'favorites';
  static const String historyKey = 'history';
  static const String settingsKey = 'settings';
  
  // Localizações suportadas
  static const List<Locale> supportedLocales = [
    Locale('pt', 'BR'),
    Locale('en', 'US'),
    Locale('es', 'ES'),
  ];
  
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  
  // Configurações do player
  static const int maxRetryAttempts = 3;
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration readTimeout = Duration(seconds: 60);
  
  // Configurações de cache
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB
  static const Duration cacheExpiration = Duration(days: 7);
  
  // Configurações de qualidade
  static const List<String> supportedQualities = [
    'Auto',
    '1080p',
    '720p',
    '480p',
    '360p',
  ];
  
  // Configurações de áudio
  static const List<String> supportedAudioCodecs = [
    'AAC',
    'MP3',
    'AC3',
    'EAC3',
  ];
  
  // Configurações de legendas
  static const List<String> supportedSubtitleFormats = [
    'SRT',
    'VTT',
    'ASS',
    'SSA',
  ];
}
