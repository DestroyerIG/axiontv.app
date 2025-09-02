import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:axion_tv/core/constants/app_constants.dart';
import 'package:axion_tv/core/router/app_router.dart';
import 'package:axion_tv/core/theme/app_theme.dart';
import 'package:axion_tv/core/providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configurações do sistema
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  // Inicializar Hive
  await Hive.initFlutter();
  
  // Inicializar providers
  await initializeProviders();
  
  runApp(const ProviderScope(child: AxionTVApp()));
}

class AxionTVApp extends ConsumerWidget {
  const AxionTVApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      localizationsDelegates: AppConstants.localizationsDelegates,
      supportedLocales: AppConstants.supportedLocales,
    );
  }
}
