import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:axion_tv/core/constants/app_constants.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String? avatar;
  final DateTime createdAt;
  final bool isPremium;
  final List<String> permissions;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.avatar,
    required this.createdAt,
    this.isPremium = false,
    this.permissions = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      isPremium: json['is_premium'] ?? false,
      permissions: List<String>.from(json['permissions'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'avatar': avatar,
      'created_at': createdAt.toIso8601String(),
      'is_premium': isPremium,
      'permissions': permissions,
    };
  }
}

class AuthState {
  final User? user;
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;
  final String? token;

  AuthState({
    this.user,
    this.isAuthenticated = false,
    this.isLoading = false,
    this.error,
    this.token,
  });

  AuthState copyWith({
    User? user,
    bool? isAuthenticated,
    bool? isLoading,
    String? error,
    String? token,
  }) {
    return AuthState(
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      token: token ?? this.token,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState()) {
    _loadStoredAuth();
  }

  Future<void> _loadStoredAuth() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConstants.authTokenKey);
      
      if (token != null) {
        // Aqui você pode validar o token com a API
        // Por enquanto, vamos apenas carregar o token
        state = state.copyWith(
          token: token,
          isAuthenticated: true,
        );
      }
    } catch (e) {
      // Erro ao carregar autenticação salva
    }
  }

  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simular login - substitua por chamada real da API
      await Future.delayed(const Duration(seconds: 2));
      
      // Criar usuário de exemplo
      final user = User(
        id: '1',
        username: username,
        email: '$username@example.com',
        createdAt: DateTime.now(),
        isPremium: true,
        permissions: ['watch', 'favorites', 'settings'],
      );
      
      // Salvar token
      final prefs = await SharedPreferences.getInstance();
      const token = 'sample_token_123';
      await prefs.setString(AppConstants.authTokenKey, token);
      
      state = state.copyWith(
        user: user,
        isAuthenticated: true,
        isLoading: false,
        token: token,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Erro ao fazer login: ${e.toString()}',
      );
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppConstants.authTokenKey);
      
      state = AuthState();
    } catch (e) {
      // Erro ao fazer logout
    }
  }

  Future<void> register(String username, String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simular registro - substitua por chamada real da API
      await Future.delayed(const Duration(seconds: 2));
      
      // Criar usuário
      final user = User(
        id: '2',
        username: username,
        email: email,
        createdAt: DateTime.now(),
        isPremium: false,
        permissions: ['watch'],
      );
      
      // Salvar token
      final prefs = await SharedPreferences.getInstance();
      const token = 'sample_token_456';
      await prefs.setString(AppConstants.authTokenKey, token);
      
      state = state.copyWith(
        user: user,
        isAuthenticated: true,
        isLoading: false,
        token: token,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Erro ao fazer registro: ${e.toString()}',
      );
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
