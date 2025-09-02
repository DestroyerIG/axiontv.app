import 'package:flutter_riverpod/flutter_riverpod.dart';

class Channel {
  final String id;
  final String name;
  final String streamUrl;
  final String? logo;
  final String? category;
  final bool isLive;
  final bool isFavorite;
  final String? epgId;
  final Map<String, dynamic>? metadata;

  Channel({
    required this.id,
    required this.name,
    required this.streamUrl,
    this.logo,
    this.category,
    this.isLive = true,
    this.isFavorite = false,
    this.epgId,
    this.metadata,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      streamUrl: json['stream_url'] ?? '',
      logo: json['logo'],
      category: json['category'],
      isLive: json['is_live'] ?? true,
      isFavorite: json['is_favorite'] ?? false,
      epgId: json['epg_id'],
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stream_url': streamUrl,
      'logo': logo,
      'category': category,
      'is_live': isLive,
      'is_favorite': isFavorite,
      'epg_id': epgId,
      'metadata': metadata,
    };
  }

  Channel copyWith({
    String? id,
    String? name,
    String? streamUrl,
    String? logo,
    String? category,
    bool? isLive,
    bool? isFavorite,
    String? epgId,
    Map<String, dynamic>? metadata,
  }) {
    return Channel(
      id: id ?? this.id,
      name: name ?? this.name,
      streamUrl: streamUrl ?? this.streamUrl,
      logo: logo ?? this.logo,
      category: category ?? this.category,
      isLive: isLive ?? this.isLive,
      isFavorite: isFavorite ?? this.isFavorite,
      epgId: epgId ?? this.epgId,
      metadata: metadata ?? this.metadata,
    );
  }
}

class Playlist {
  final String id;
  final String name;
  final String url;
  final String type; // 'm3u' ou 'xtream'
  final String? username;
  final String? password;
  final DateTime lastUpdated;
  final List<Channel> channels;

  Playlist({
    required this.id,
    required this.name,
    required this.url,
    required this.type,
    this.username,
    this.password,
    required this.lastUpdated,
    required this.channels,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      type: json['type'] ?? 'm3u',
      username: json['username'],
      password: json['password'],
      lastUpdated: DateTime.parse(json['last_updated'] ?? DateTime.now().toIso8601String()),
      channels: (json['channels'] as List<dynamic>?)
          ?.map((e) => Channel.fromJson(e))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'type': type,
      'username': username,
      'password': password,
      'last_updated': lastUpdated.toIso8601String(),
      'channels': channels.map((e) => e.toJson()).toList(),
    };
  }
}

class IPTVState {
  final List<Playlist> playlists;
  final List<Channel> allChannels;
  final List<Channel> favoriteChannels;
  final Channel? currentChannel;
  final bool isLoading;
  final String? error;
  final String? currentPlaylistId;

  IPTVState({
    this.playlists = const [],
    this.allChannels = const [],
    this.favoriteChannels = const [],
    this.currentChannel,
    this.isLoading = false,
    this.error,
    this.currentPlaylistId,
  });

  IPTVState copyWith({
    List<Playlist>? playlists,
    List<Channel>? allChannels,
    List<Channel>? favoriteChannels,
    Channel? currentChannel,
    bool? isLoading,
    String? error,
    String? currentPlaylistId,
  }) {
    return IPTVState(
      playlists: playlists ?? this.playlists,
      allChannels: allChannels ?? this.allChannels,
      favoriteChannels: favoriteChannels ?? this.favoriteChannels,
      currentChannel: currentChannel ?? this.currentChannel,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentPlaylistId: currentPlaylistId ?? this.currentPlaylistId,
    );
  }
}

class IPTVNotifier extends StateNotifier<IPTVState> {
  IPTVNotifier() : super(IPTVState()) {
    _loadSampleData();
  }

  void _loadSampleData() {
    // Dados de exemplo para demonstração
    final sampleChannels = [
      Channel(
        id: '1',
        name: 'Globo',
        streamUrl: 'https://sample.com/globo.m3u8',
        logo: 'https://sample.com/globo.png',
        category: 'Entretenimento',
      ),
      Channel(
        id: '2',
        name: 'SBT',
        streamUrl: 'https://sample.com/sbt.m3u8',
        logo: 'https://sample.com/sbt.png',
        category: 'Entretenimento',
      ),
      Channel(
        id: '3',
        name: 'Record',
        streamUrl: 'https://sample.com/record.m3u8',
        logo: 'https://sample.com/record.png',
        category: 'Entretenimento',
      ),
      Channel(
        id: '4',
        name: 'Band',
        streamUrl: 'https://sample.com/band.m3u8',
        logo: 'https://sample.com/band.png',
        category: 'Entretenimento',
      ),
      Channel(
        id: '5',
        name: 'RedeTV!',
        streamUrl: 'https://sample.com/redetv.m3u8',
        logo: 'https://sample.com/redetv.png',
        category: 'Entretenimento',
      ),
    ];

    final samplePlaylist = Playlist(
      id: '1',
      name: 'Playlist Brasileira',
      url: 'https://sample.com/playlist.m3u',
      type: 'm3u',
      lastUpdated: DateTime.now(),
      channels: sampleChannels,
    );

    state = state.copyWith(
      playlists: [samplePlaylist],
      allChannels: sampleChannels,
      currentPlaylistId: '1',
    );
  }

  Future<void> loadPlaylist(String url, {String? username, String? password}) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simular carregamento de playlist
      await Future.delayed(const Duration(seconds: 2));
      
      // Aqui você implementaria o parsing real da playlist
      // Por enquanto, vamos usar dados de exemplo
      
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Erro ao carregar playlist: ${e.toString()}',
      );
    }
  }

  void setCurrentChannel(Channel channel) {
    state = state.copyWith(currentChannel: channel);
  }

  void toggleFavorite(Channel channel) {
    final updatedChannel = channel.copyWith(isFavorite: !channel.isFavorite);
    
    final updatedChannels = state.allChannels.map((c) {
      if (c.id == channel.id) return updatedChannel;
      return c;
    }).toList();

    final updatedFavorites = updatedChannels.where((c) => c.isFavorite).toList();

    state = state.copyWith(
      allChannels: updatedChannels,
      favoriteChannels: updatedFavorites,
    );
  }

  List<Channel> getChannelsByCategory(String category) {
    return state.allChannels.where((c) => c.category == category).toList();
  }

  List<String> getCategories() {
    return state.allChannels
        .map((c) => c.category)
        .where((c) => c != null)
        .cast<String>()
        .toSet()
        .toList();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final iptvProvider = StateNotifierProvider<IPTVNotifier, IPTVState>(
  (ref) => IPTVNotifier(),
);
