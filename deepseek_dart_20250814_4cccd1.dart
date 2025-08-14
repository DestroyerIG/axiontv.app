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
    ),
    OnboardingPage(
      title: 'Conteúdo Organizado',
      description: 'Acesse canais ao vivo, filmes e séries de forma intuitiva',
      image: 'assets/images/onboarding2.png',
    ),
    OnboardingPage(
      title: 'Multiplataforma',
      description: 'Assista em smartphones, tablets e TVs com experiência adaptada',
      image: 'assets/images/onboarding3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isTV = ref.read(deviceInfoProvider).isTV;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(page: _pages[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botão de pular na primeira página
                  if (_currentPage == 0)
                    TextButton(
                      onPressed: _skipOnboarding,
                      child: const Text('Pular'),
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
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? AppConstants.primaryColor
                                : Colors.grey,
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1 ? 'Começar' : 'Próximo',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isTV)
              const SizedBox(height: 20), // Espaço adicional para TV
          ],
        ),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  void _completeOnboarding() {
    ref.read(onboardingProvider).completeOnboarding();
    context.go('/login');
  }
}