import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:axion_tv/core/constants/app_constants.dart';
import 'package:axion_tv/core/providers/device_info_provider.dart';

class PlayerScreen extends ConsumerStatefulWidget {
  final String channelId;
  final String channelName;
  final String streamUrl;

  const PlayerScreen({
    super.key,
    required this.channelId,
    required this.channelName,
    required this.streamUrl,
  });

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceInfo = ref.watch(deviceInfoProvider);
    final isTV = deviceInfo?.isTV ?? false;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar do player
            Container(
              padding: EdgeInsets.all(isTV ? 20 : 16),
              color: Colors.black.withOpacity(0.8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.go('/home'),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: isTV ? 32 : 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      widget.channelName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isTV ? 24 : 20,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Implementar favoritos
                    },
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: isTV ? 28 : 24,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Implementar configurações do player
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: isTV ? 28 : 24,
                    ),
                  ),
                ],
              ),
            ),
            
            // Área do player
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Placeholder do player
                    Container(
                      width: isTV ? 800 : double.infinity,
                      height: isTV ? 450 : 250,
                      decoration: BoxDecoration(
                        color: AppConstants.surfaceColor,
                        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                        border: Border.all(
                          color: AppConstants.primaryColor.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            size: isTV ? 80 : 64,
                            color: AppConstants.primaryColor,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Player de Vídeo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isTV ? 24 : 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Canal: ${widget.channelName}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: isTV ? 16 : 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Implementar reprodução
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstants.primaryColor,
                              padding: EdgeInsets.symmetric(
                                horizontal: isTV ? 32 : 24,
                                vertical: isTV ? 16 : 12,
                              ),
                            ),
                            child: Text(
                              'Reproduzir',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isTV ? 18 : 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Informações do canal
                    Container(
                      padding: EdgeInsets.all(isTV ? 24 : 20),
                      margin: EdgeInsets.symmetric(horizontal: isTV ? 40 : 20),
                      decoration: BoxDecoration(
                        color: AppConstants.surfaceColor,
                        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informações do Canal',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isTV ? 20 : 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow('ID', widget.channelId, isTV),
                          _buildInfoRow('Nome', widget.channelName, isTV),
                          _buildInfoRow('URL', widget.streamUrl, isTV),
                          _buildInfoRow('Status', 'Disponível', isTV),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool isTV) {
    return Padding(
      padding: EdgeInsets.only(bottom: isTV ? 12 : 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: isTV ? 120 : 80,
            child: Text(
              '$label:',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: isTV ? 16 : 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: isTV ? 16 : 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
