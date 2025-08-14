class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await ref.read(homeProvider.notifier).loadData();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    final isTV = ref.read(deviceInfoProvider).isTV;

    return Scaffold(
      appBar: isTV ? null : const AxionAppBar(),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error) => ErrorWidget(error),
        loaded: (featuredContent, continueWatching, favorites, liveChannels) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Destaque herói
                if (featuredContent.isNotEmpty)
                  HeroCarousel(content: featuredContent),

                // Continuar assistindo
                if (continueWatching.isNotEmpty)
                  ContentSection(
                    title: 'Continuar Assistindo',
                    content: continueWatching,
                    onSeeAll: () => context.push('/continue-watching'),
                  ),

                // Canais ao vivo
                ContentSection(
                  title: 'Canais ao vivo',
                  content: liveChannels,
                  onSeeAll: () => context.push('/live-tv'),
                ),

                // Favoritos
                if (favorites.isNotEmpty)
                  ContentSection(
                    title: 'Seus favoritos',
                    content: favorites,
                    onSeeAll: () => context.push('/favorites'),
                  ),

                // Espaço adicional para TVs
                if (isTV) const SizedBox(height: 60),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: isTV ? null : const AxionBottomNavigationBar(),
    );
  }
}