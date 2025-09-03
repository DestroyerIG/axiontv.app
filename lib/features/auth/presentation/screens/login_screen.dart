import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:axion_tv/core/constants/app_constants.dart';
import 'package:axion_tv/core/providers/auth_provider.dart';
import 'package:axion_tv/core/providers/device_info_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _playlistUrlController = TextEditingController();
  final _usernameController2 = TextEditingController();
  final _passwordController2 = TextEditingController();
  
  bool _isLoginMode = true;
  bool _obscurePassword = true;
  bool _obscurePassword2 = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _playlistUrlController.dispose();
    _usernameController2.dispose();
    _passwordController2.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _togglePasswordVisibility2() {
    setState(() {
      _obscurePassword2 = !_obscurePassword2;
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_isLoginMode) {
        await ref.read(authProvider.notifier).login(
          _usernameController.text,
          _passwordController.text,
        );
      } else {
        await ref.read(authProvider.notifier).register(
          _usernameController2.text,
          _usernameController2.text, // Usando username como email por simplicidade
          _passwordController2.text,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final deviceInfo = ref.watch(deviceInfoProvider);
    final isTV = deviceInfo?.isTV ?? false;

    // Redirecionar se já estiver autenticado
    if (authState.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/home');
      });
    }

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isTV ? 40 : 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                
                // Logo e título
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: isTV ? 120 : 80,
                        height: isTV ? 120 : 80,
                        decoration: BoxDecoration(
                          color: AppConstants.primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppConstants.primaryColor,
                            width: 3,
                          ),
                        ),
                        child: Icon(
                          Icons.tv,
                          size: isTV ? 60 : 40,
                          color: AppConstants.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppConstants.appName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isTV ? 36 : 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _isLoginMode ? 'Faça login para continuar' : 'Crie sua conta',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: isTV ? 18 : 16,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 50),
                
                // Formulário
                if (_isLoginMode) ...[
                  // Modo Login
                  _buildTextField(
                    controller: _usernameController,
                    label: 'Usuário',
                    icon: Icons.person,
                    isTV: isTV,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Senha',
                    icon: Icons.lock,
                    isTV: isTV,
                    isPassword: true,
                    obscureText: _obscurePassword,
                    onToggleVisibility: _togglePasswordVisibility,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _playlistUrlController,
                    label: 'URL da Playlist (opcional)',
                    icon: Icons.link,
                    isTV: isTV,
                    hintText: 'https://exemplo.com/playlist.m3u',
                  ),
                ] else ...[
                  // Modo Registro
                  _buildTextField(
                    controller: _usernameController2,
                    label: 'Nome de usuário',
                    icon: Icons.person,
                    isTV: isTV,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _passwordController2,
                    label: 'Senha',
                    icon: Icons.lock,
                    isTV: isTV,
                    isPassword: true,
                    obscureText: _obscurePassword2,
                    onToggleVisibility: _togglePasswordVisibility2,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _playlistUrlController,
                    label: 'URL da Playlist',
                    icon: Icons.link,
                    isTV: isTV,
                    hintText: 'https://exemplo.com/playlist.m3u',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'URL da playlist é obrigatória';
                      }
                      final uri = Uri.tryParse(value);
                      if (uri == null || !uri.hasAbsolutePath) {
                        return 'URL inválida';
                      }
                      return null;
                    },
                  ),
                ],
                
                const SizedBox(height: 40),
                
                // Botão de submit
                ElevatedButton(
                  onPressed: authState.isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                    padding: EdgeInsets.symmetric(
                      vertical: isTV ? 20 : 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    ),
                  ),
                  child: authState.isLoading
                      ? SizedBox(
                          height: isTV ? 24 : 20,
                          width: isTV ? 24 : 20,
                          child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          _isLoginMode ? 'Entrar' : 'Criar Conta',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTV ? 20 : 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
                
                const SizedBox(height: 20),
                
                // Botão de alternar modo
                TextButton(
                  onPressed: _toggleMode,
                  child: Text(
                    _isLoginMode
                        ? 'Não tem uma conta? Criar conta'
                        : 'Já tem uma conta? Fazer login',
                    style: TextStyle(
                      color: AppConstants.primaryColor,
                      fontSize: isTV ? 16 : 14,
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Mensagem de erro
                if (authState.error != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error, color: Colors.red),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            authState.error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        IconButton(
                          onPressed: () => ref.read(authProvider.notifier).clearError(),
                          icon: const Icon(Icons.close, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isTV,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    String? hintText,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return '$label é obrigatório';
        }
        return null;
      },
      style: TextStyle(
        color: Colors.white,
        fontSize: isTV ? 18 : 16,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: isTV ? 16 : 14,
        ),
        labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: isTV ? 16 : 14,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.white.withOpacity(0.7),
          size: isTV ? 24 : 20,
        ),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: onToggleVisibility,
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white.withOpacity(0.7),
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(color: AppConstants.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
      ),
    );
  }
}
