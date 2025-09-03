import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:axion_tv/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:axion_tv/features/auth/presentation/screens/login_screen.dart';
import 'package:axion_tv/features/auth/presentation/screens/splash_screen.dart';
import 'package:axion_tv/features/home/presentation/screens/home_screen.dart';
import 'package:axion_tv/features/player/presentation/screens/player_screen.dart';
import 'package:axion_tv/features/settings/presentation/screens/settings_screen.dart';
import 'package:axion_tv/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:axion_tv/features/search/presentation/screens/search_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      // Splash Screen
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Onboarding
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      
      // Login
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      
      // Home (principal)
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          // Player
          GoRoute(
            path: 'player',
            name: 'player',
            builder: (context, state) {
              final channelId = state.uri.queryParameters['channelId'];
              final channelName = state.uri.queryParameters['channelName'];
              final streamUrl = state.uri.queryParameters['streamUrl'];
              
              return PlayerScreen(
                channelId: channelId ?? '',
                channelName: channelName ?? '',
                streamUrl: streamUrl ?? '',
              );
            },
          ),
          
          // Favoritos
          GoRoute(
            path: 'favorites',
            name: 'favorites',
            builder: (context, state) => const FavoritesScreen(),
          ),
          
          // Busca
          GoRoute(
            path: 'search',
            name: 'search',
            builder: (context, state) => const SearchScreen(),
          ),
          
          // Configurações
          GoRoute(
            path: 'settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
    
    // Redirecionamentos baseados no estado de autenticação
    redirect: (context, state) {
      // Aqui você pode implementar lógica de redirecionamento
      // baseada no estado de autenticação do usuário
      return null;
    },
    
    // Tratamento de erros
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Página não encontrada',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'A página ${state.uri.path} não existe',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Voltar ao Início'),
            ),
          ],
        ),
      ),
    ),
  );
});
