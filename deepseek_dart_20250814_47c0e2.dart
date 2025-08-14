class AppConstants {
  static const String appName = 'Axion TV';
  static const String appVersion = '1.0.0';
  static const String appAuthor = 'Axion Team';
  static const String appWebsite = 'https://axiontv.example.com';
  
  // Cores da marca Axion
  static const Color primaryColor = Color(0xFF0066FF);
  static const Color secondaryColor = Color(0xFF00D1FF);
  static const Color accentColor = Color(0xFFFFC107);
  
  // Configurações de tempo
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration channelChangeDelay = Duration(milliseconds: 300);
  
  // Localização
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
}