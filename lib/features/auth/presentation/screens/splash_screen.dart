import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:axion_tv/core/constants/app_constants.dart';
import 'package:axion_tv/core/providers/device_info_provider.dart';
import 'package:axion_tv/core/providers/auth_provider.dart';
import 'package:axion_tv/core/providers/iptv_provider.dart';
import 'package:axion_tv/core/providers/epg_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _fadeController;
  late Animation<double> _logoAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initApp();
  }

  void _setupAnimations() {
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _logoController.forward();
    _fadeController.forward();
  }

  Future<void> _initApp() async {
    try {
      // Inicializar informações do dispositivo
      await ref.read(deviceInfoProvider.notifier).initialize();
      
      // Aguardar um tempo mínimo para a animação
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Inicializações paralelas
      await Future.wait([
        ref.read(iptvProvider.notifier).loadPlaylist(''),
        ref.read(epgProvider.notifier).loadEPG(''),
        Future.delayed(AppConstants.splashDuration),
      ]);

      if (mounted) {
        final isLoggedIn = ref.read(authProvider).isAuthenticated;
        context.go(isLoggedIn ? '/home' : '/onboarding');
      }
    } catch (e) {
      // Em caso de erro, ainda redirecionar para onboarding
      if (mounted) {
        context.go('/onboarding');
      }
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceInfo = ref.watch(deviceInfoProvider);
    final isTV = deviceInfo?.isTV ?? false;

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppConstants.primaryColor.withOpacity(0.8),
              AppConstants.backgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo animado
                AnimatedBuilder(
                  animation: _logoAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _logoAnimation.value,
                      child: Container(
                        width: isTV ? 300 : 200,
                        height: isTV ? 300 : 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                          boxShadow: [
                            BoxShadow(
                              color: AppConstants.primaryColor.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.tv,
                          size: isTV ? 150 : 100,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 30),
                
                // Nome da aplicação
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        AppConstants.appName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isTV ? 48 : 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 10),
                
                // Descrição
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        AppConstants.appDescription,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: isTV ? 18 : 14,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 50),
                
                // Indicador de carregamento
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: SizedBox(
                        width: isTV ? 60 : 40,
                        height: isTV ? 60 : 40,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white.withOpacity(0.8),
                          ),
                          strokeWidth: isTV ? 4 : 3,
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 30),
                
                // Informações do dispositivo (apenas para debug)
                if (deviceInfo != null) ...[
                  AnimatedBuilder(
                    animation: _fadeAnimation,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          '${deviceInfo.platform} - ${deviceInfo.deviceModel}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: isTV ? 14 : 10,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
