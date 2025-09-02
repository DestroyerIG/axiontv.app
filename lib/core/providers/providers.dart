import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axion_tv/core/providers/device_info_provider.dart';
import 'package:axion_tv/core/providers/auth_provider.dart';
import 'package:axion_tv/core/providers/iptv_provider.dart';
import 'package:axion_tv/core/providers/epg_provider.dart';
import 'package:axion_tv/core/providers/favorites_provider.dart';
import 'package:axion_tv/core/providers/history_provider.dart';
import 'package:axion_tv/core/providers/settings_provider.dart';

// Provider para inicializar todos os providers
Future<void> initializeProviders() async {
  // Inicializar providers que precisam de setup assíncrono
  await Future.wait([
    // Aqui você pode adicionar inicializações específicas
  ]);
}

// Lista de todos os providers para facilitar o dispose
final allProviders = [
  deviceInfoProvider,
  authProvider,
  iptvProvider,
  epgProvider,
  favoritesProvider,
  historyProvider,
  settingsProvider,
];
