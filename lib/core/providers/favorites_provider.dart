import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:axion_tv/core/providers/iptv_provider.dart';

class FavoritesState {
  final List<Channel> favoriteChannels;
  final bool isLoading;
  final String? error;

  FavoritesState({
    this.favoriteChannels = const [],
    this.isLoading = false,
    this.error,
  });

  FavoritesState copyWith({
    List<Channel>? favoriteChannels,
    bool? isLoading,
    String? error,
  }) {
    return FavoritesState(
      favoriteChannels: favoriteChannels ?? this.favoriteChannels,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class FavoritesNotifier extends StateNotifier<FavoritesState> {
  FavoritesNotifier(this.ref) : super(FavoritesState());

  final Ref ref;

  List<Channel> get favoriteChannels => state.favoriteChannels;

  void addToFavorites(Channel channel) {
    if (!state.favoriteChannels.any((c) => c.id == channel.id)) {
      final updatedFavorites = [...state.favoriteChannels, channel];
      state = state.copyWith(favoriteChannels: updatedFavorites);
    }
  }

  void removeFromFavorites(String channelId) {
    final updatedFavorites = state.favoriteChannels
        .where((c) => c.id != channelId)
        .toList();
    state = state.copyWith(favoriteChannels: updatedFavorites);
  }

  bool isFavorite(String channelId) {
    return state.favoriteChannels.any((c) => c.id == channelId);
  }

  void clearFavorites() {
    state = state.copyWith(favoriteChannels: []);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, FavoritesState>(
  (ref) => FavoritesNotifier(ref),
);
