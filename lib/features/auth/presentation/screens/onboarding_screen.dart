import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:axion_tv/core/constants/app_constants.dart';
import 'package:axion_tv/core/providers/device_info_provider.dart';

class OnboardingPage {
  final String title;
  final String description;
  final String image;
  final IconData icon;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
    required this.icon,
  });
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Bem-vindo ao Axion TV',
      description: 'O melhor reprodutor IPTV com qualidade premium e performance excepcional',
      image: 'assets/images/onboarding1.png',
      icon: Icons.tv,
    ),
    OnboardingPage(
      title: 'Conteúdo Organizado',
      description: 'Acesse canais ao vivo, filmes e séries de forma intuitiva e organizada',
      image: 'assets/images/onboarding2.png',
      icon: Icons.grid_view,
    ),
    OnboardingPage(
      title: 'Multiplataforma',
      description: 'Assista em smartphones, tablets e TVs com experiência adaptada para cada dispositivo',
      image: 'assets/images/onboarding3.png',
      icon: Icons.devices,
    ),
    OnboardingPage(
      title: 'EPG Completo',
      description: 'Guia de programação eletrônica com informações detalhadas sobre todos os programas',
      image: 'assets/images/onboarding4.png',
      icon: Icons.schedule,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipOnboarding() {
    context.go('/login');
  }

  void _completeOnboarding() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final deviceInfo = ref.watch(deviceInfoProvider);
    final isTV = deviceInfo?.isTV ?? false;

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Barra superior com botão de pular
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo pequeno
                  Row(
                    children: [
                      Icon(
                        Icons.tv,
                        color: AppConstants.primaryColor,
                        size: isTV ? 32 : 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Axion TV',
                        style: TextStyle(
                          color: AppConstants.primaryColor,
                          fontSize: isTV ? 20 : 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  // Botão de pular
                  TextButton(
                    onPressed: _skipOnboarding,
                    child: Text(
                      'Pular',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: isTV ? 16 : 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(_pages[index], isTV);
                },
              ),
            ),
            
            // Controles de navegação
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botão de anterior
                  if (_currentPage > 0)
                    TextButton(
                      onPressed: _previousPage,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_back_ios, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            'Anterior',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: isTV ? 16 : 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    const SizedBox(width: 80),

                  // Indicadores de página
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          width: isTV ? 12 : 8,
                          height: isTV ? 12 : 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? AppConstants.primaryColor
                                : Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Botão de próximo/concluir
                  ElevatedButton(
                    onPressed: _currentPage == _pages.length - 1
                        ? _completeOnboarding
                        : _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: isTV ? 32 : 24,
                        vertical: isTV ? 16 : 12,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _currentPage == _pages.length - 1 ? 'Começar' : 'Próximo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isTV ? 18 : 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (_currentPage < _pages.length - 1) ...[
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingPage page, bool isTV) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Imagem/Ícone
          Container(
            width: isTV ? 300 : 200,
            height: isTV ? 300 : 200,
            decoration: BoxDecoration(
              color: AppConstants.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppConstants.primaryColor.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(
              page.icon,
              size: isTV ? 120 : 80,
              color: AppConstants.primaryColor,
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Título
          Text(
            page.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: isTV ? 36 : 28,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 20),
          
          // Descrição
          Text(
            page.description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: isTV ? 20 : 16,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
