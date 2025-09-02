import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:axion_tv/core/constants/app_constants.dart';
import 'package:axion_tv/core/providers/device_info_provider.dart';
import 'package:axion_tv/core/providers/iptv_provider.dart';
import 'package:axion_tv/core/providers/auth_provider.dart';
import 'package:axion_tv/core/providers/favorites_provider.dart';
import 'package:axion_tv/core/providers/history_provider.dart';
import 'package:axion_tv/core/providers/epg_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceInfo = ref.watch(deviceInfoProvider);
    final authState = ref.watch(authProvider);
    final iptvState = ref.watch(iptvProvider);
    final isTV = deviceInfo?.isTV ?? false;

    // Redirecionar se não estiver autenticado
    if (!authState.isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/login');
      });
      return const Scaffold();
    }

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Row(
        children: [
          // Sidebar para TV
          if (isTV) _buildTVSidebar(),
          
          // Conteúdo principal
          Expanded(
            child: Column(
              children: [
                // AppBar
                _buildAppBar(isTV, authState),
                
                // Conteúdo das páginas
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    children: [
                      _buildChannelsPage(isTV, iptvState),
                      _buildFavoritesPage(isTV),
                      _buildHistoryPage(isTV),
                      _buildSettingsPage(isTV),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Bottom navigation para mobile
      bottomNavigationBar: !isTV ? _buildBottomNavigation() : null,
    );
  }

  Widget _buildTVSidebar() {
    return Container(
      width: 200,
      color: AppConstants.surfaceColor,
      child: Column(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.tv,
                  color: AppConstants.primaryColor,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Text(
                  'Axion TV',
                  style: TextStyle(
                    color: AppConstants.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(color: Colors.grey),
          
          // Menu de navegação
          Expanded(
            child: ListView(
              children: [
                _buildSidebarItem(
                  icon: Icons.tv,
                  title: 'Canais',
                  isSelected: _currentIndex == 0,
                  onTap: () => _onTabTapped(0),
                ),
                _buildSidebarItem(
                  icon: Icons.favorite,
                  title: 'Favoritos',
                  isSelected: _currentIndex == 1,
                  onTap: () => _onTabTapped(1),
                ),
                _buildSidebarItem(
                  icon: Icons.history,
                  title: 'Histórico',
                  isSelected: _currentIndex == 2,
                  onTap: () => _onTabTapped(2),
                ),
                _buildSidebarItem(
                  icon: Icons.settings,
                  title: 'Configurações',
                  isSelected: _currentIndex == 3,
                  onTap: () => _onTabTapped(3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppConstants.primaryColor : Colors.white.withOpacity(0.7),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppConstants.primaryColor : Colors.white,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onTap: onTap,
      tileColor: isSelected ? AppConstants.primaryColor.withOpacity(0.1) : null,
    );
  }

  Widget _buildAppBar(bool isTV, AuthState authState) {
    return Container(
      padding: EdgeInsets.all(isTV ? 20 : 16),
      color: AppConstants.surfaceColor,
      child: Row(
        children: [
          if (!isTV) ...[
            Icon(
              Icons.tv,
              color: AppConstants.primaryColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              'Axion TV',
              style: TextStyle(
                color: AppConstants.primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          
          const Spacer(),
          
          // Barra de busca
          if (isTV)
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar canais...',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          
          // Botão de busca (mobile)
          if (!isTV)
            IconButton(
              onPressed: () {
                // Implementar busca
              },
              icon: Icon(
                Icons.search,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          
          // Avatar do usuário
          GestureDetector(
            onTap: () {
              // Mostrar menu do usuário
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppConstants.primaryColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                color: AppConstants.primaryColor,
                size: isTV ? 28 : 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppConstants.surfaceColor,
      selectedItemColor: AppConstants.primaryColor,
      unselectedItemColor: Colors.white.withOpacity(0.7),
      currentIndex: _currentIndex,
      onTap: _onTabTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.tv),
          label: 'Canais',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favoritos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Histórico',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Configurações',
        ),
      ],
    );
  }

  Widget _buildChannelsPage(bool isTV, IPTVState iptvState) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isTV ? 30 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Canais Disponíveis',
            style: TextStyle(
              color: Colors.white,
              fontSize: isTV ? 32 : 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 20),
          
          if (iptvState.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (iptvState.error != null)
            _buildErrorWidget(iptvState.error!)
          else
            _buildChannelsGrid(iptvState.allChannels, isTV),
        ],
      ),
    );
  }

  Widget _buildChannelsGrid(List<Channel> channels, bool isTV) {
    final crossAxisCount = isTV ? 6 : 3;
    final childAspectRatio = isTV ? 1.5 : 1.2;
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: channels.length,
      itemBuilder: (context, index) {
        final channel = channels[index];
        return _buildChannelCard(channel, isTV);
      },
    );
  }

  Widget _buildChannelCard(Channel channel, bool isTV) {
    return GestureDetector(
      onTap: () {
        // Navegar para o player
        context.go('/home/player', queryParameters: {
          'channelId': channel.id,
          'channelName': channel.name,
          'streamUrl': channel.streamUrl,
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppConstants.surfaceColor,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Logo do canal
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppConstants.borderRadius),
                    topRight: Radius.circular(AppConstants.borderRadius),
                  ),
                ),
                child: channel.logo != null
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppConstants.borderRadius),
                          topRight: Radius.circular(AppConstants.borderRadius),
                        ),
                        child: Image.network(
                          channel.logo!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.tv,
                              size: isTV ? 48 : 32,
                              color: AppConstants.primaryColor,
                            );
                          },
                        ),
                      )
                    : Icon(
                        Icons.tv,
                        size: isTV ? 48 : 32,
                        color: AppConstants.primaryColor,
                      ),
              ),
            ),
            
            // Nome do canal
            Container(
              padding: EdgeInsets.all(isTV ? 16 : 12),
              child: Text(
                channel.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTV ? 16 : 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesPage(bool isTV) {
    final favoritesState = ref.watch(favoritesProvider);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(isTV ? 30 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meus Favoritos',
            style: TextStyle(
              color: Colors.white,
              fontSize: isTV ? 32 : 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 20),
          
          if (favoritesState.favoriteChannels.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: isTV ? 80 : 64,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Nenhum canal favorito ainda',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: isTV ? 18 : 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Adicione canais aos favoritos para encontrá-los facilmente',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: isTV ? 14 : 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            _buildChannelsGrid(favoritesState.favoriteChannels, isTV),
        ],
      ),
    );
  }

  Widget _buildHistoryPage(bool isTV) {
    final historyState = ref.watch(historyProvider);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(isTV ? 30 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Histórico de Visualização',
            style: TextStyle(
              color: Colors.white,
              fontSize: isTV ? 32 : 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 20),
          
          if (historyState.viewHistory.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.history,
                    size: isTV ? 80 : 64,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Nenhum histórico ainda',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: isTV ? 18 : 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Seu histórico de canais assistidos aparecerá aqui',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: isTV ? 14 : 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            _buildHistoryList(historyState.viewHistory, isTV),
        ],
      ),
    );
  }

  Widget _buildHistoryList(List<ViewHistory> history, bool isTV) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final item = history[index];
        return ListTile(
          leading: Container(
            width: isTV ? 60 : 48,
            height: isTV ? 60 : 48,
            decoration: BoxDecoration(
              color: AppConstants.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.tv,
              color: AppConstants.primaryColor,
              size: isTV ? 32 : 24,
            ),
          ),
          title: Text(
            item.channelName,
            style: TextStyle(
              color: Colors.white,
              fontSize: isTV ? 18 : 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            'Assistido em ${_formatDate(item.viewedAt)}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: isTV ? 14 : 12,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              // Remover do histórico
              ref.read(historyProvider.notifier).removeFromHistory(item.channelId);
            },
            icon: Icon(
              Icons.close,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          onTap: () {
            // Navegar para o canal
            context.go('/home/player', queryParameters: {
              'channelId': item.channelId,
              'channelName': item.channelName,
              'streamUrl': item.streamUrl ?? '',
            });
          },
        );
      },
    );
  }

  Widget _buildSettingsPage(bool isTV) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isTV ? 30 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Configurações',
            style: TextStyle(
              color: Colors.white,
              fontSize: isTV ? 32 : 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 30),
          
          _buildSettingsSection(
            title: 'Aparência',
            icon: Icons.palette,
            isTV: isTV,
            children: [
              _buildSettingsTile(
                title: 'Modo Escuro',
                subtitle: 'Ativar tema escuro',
                icon: Icons.dark_mode,
                isTV: isTV,
                onTap: () {
                  // Implementar toggle do tema
                },
              ),
              _buildSettingsTile(
                title: 'Idioma',
                subtitle: 'Português (Brasil)',
                icon: Icons.language,
                isTV: isTV,
                onTap: () {
                  // Implementar seleção de idioma
                },
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          _buildSettingsSection(
            title: 'Player',
            icon: Icons.play_circle,
            isTV: isTV,
            children: [
              _buildSettingsTile(
                title: 'Qualidade Padrão',
                subtitle: 'Automática',
                icon: Icons.high_quality,
                isTV: isTV,
                onTap: () {
                  // Implementar seleção de qualidade
                },
              ),
              _buildSettingsTile(
                title: 'Reprodução Automática',
                subtitle: 'Ativada',
                icon: Icons.play_arrow,
                isTV: isTV,
                onTap: () {
                  // Implementar toggle de autoplay
                },
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          _buildSettingsSection(
            title: 'Conta',
            icon: Icons.account_circle,
            isTV: isTV,
            children: [
              _buildSettingsTile(
                title: 'Sair',
                subtitle: 'Fazer logout da conta',
                icon: Icons.logout,
                isTV: isTV,
                onTap: () async {
                  await ref.read(authProvider.notifier).logout();
                  context.go('/login');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required IconData icon,
    required bool isTV,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppConstants.primaryColor,
              size: isTV ? 28 : 24,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: isTV ? 20 : 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        Container(
          decoration: BoxDecoration(
            color: AppConstants.surfaceColor,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isTV,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white.withOpacity(0.7),
        size: isTV ? 28 : 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: isTV ? 18 : 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: isTV ? 14 : 12,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.white.withOpacity(0.5),
      ),
      onTap: onTap,
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red.withOpacity(0.7),
          ),
          const SizedBox(height: 20),
          Text(
            'Erro ao carregar canais',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            error,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Tentar recarregar
            },
            child: const Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} dia${difference.inDays > 1 ? 's' : ''} atrás';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hora${difference.inHours > 1 ? 's' : ''} atrás';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minuto${difference.inMinutes > 1 ? 's' : ''} atrás';
    } else {
      return 'Agora mesmo';
    }
  }
}
