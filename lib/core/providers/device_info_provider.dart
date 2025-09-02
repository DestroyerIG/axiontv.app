import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceInfo {
  final bool isTV;
  final bool isMobile;
  final bool isTablet;
  final String platform;
  final String deviceModel;
  final String osVersion;

  DeviceInfo({
    required this.isTV,
    required this.isMobile,
    required this.isTablet,
    required this.platform,
    required this.deviceModel,
    required this.osVersion,
  });
}

class DeviceInfoNotifier extends StateNotifier<DeviceInfo?> {
  DeviceInfoNotifier() : super(null);

  Future<void> initialize() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      DeviceInfo info;

      if (kIsWeb) {
        info = DeviceInfo(
          isTV: false,
          isMobile: false,
          isTablet: false,
          platform: 'web',
          deviceModel: 'Web Browser',
          osVersion: 'Web',
        );
      } else {
        if (defaultTargetPlatform == TargetPlatform.android) {
          final androidInfo = await deviceInfo.androidInfo;
          info = DeviceInfo(
            isTV: androidInfo.displayMetrics.widthPx > 1000 || 
                   androidInfo.displayMetrics.heightPx > 1000,
            isMobile: androidInfo.displayMetrics.widthPx < 600,
            isTablet: androidInfo.displayMetrics.widthPx >= 600 && 
                     androidInfo.displayMetrics.widthPx < 1000,
            platform: 'android',
            deviceModel: androidInfo.model,
            osVersion: 'Android ${androidInfo.version.release}',
          );
        } else if (defaultTargetPlatform == TargetPlatform.iOS) {
          final iosInfo = await deviceInfo.iosInfo;
          info = DeviceInfo(
            isTV: iosInfo.name?.toLowerCase().contains('tv') == true ||
                   iosInfo.model.toLowerCase().contains('tv'),
            isMobile: iosInfo.name?.toLowerCase().contains('iphone') == true,
            isTablet: iosInfo.name?.toLowerCase().contains('ipad') == true,
            platform: 'ios',
            deviceModel: iosInfo.model,
            osVersion: 'iOS ${iosInfo.systemVersion}',
          );
        } else {
          info = DeviceInfo(
            isTV: false,
            isMobile: false,
            isTablet: false,
            platform: 'unknown',
            deviceModel: 'Unknown Device',
            osVersion: 'Unknown OS',
          );
        }
      }

      state = info;
    } catch (e) {
      // Fallback para informações básicas
      state = DeviceInfo(
        isTV: false,
        isMobile: true,
        isTablet: false,
        platform: 'unknown',
        deviceModel: 'Unknown Device',
        osVersion: 'Unknown OS',
      );
    }
  }
}

final deviceInfoProvider = StateNotifierProvider<DeviceInfoNotifier, DeviceInfo?>(
  (ref) => DeviceInfoNotifier(),
);
